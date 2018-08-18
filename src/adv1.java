import twitter4j.*;
import twitter4j.conf.Configuration;
import twitter4j.conf.ConfigurationBuilder;

import java.sql.*;
import java.util.ArrayList;

public class adv1 {

    private Twitter twitter;

    public static void main(String[] args) throws InterruptedException {

        new adv1().initConfiguration();
    }

    private void initConfiguration() {

        ConfigurationBuilder builder = new ConfigurationBuilder();

        //-----------------iyiar------------------------

        builder.setOAuthConsumerKey("");
        builder.setOAuthConsumerSecret("");
        builder.setOAuthAccessToken("");
        builder.setOAuthAccessTokenSecret("");
    
        //-----------------iyiar------------------------
        Configuration configuration = builder.build();
        TwitterFactory factory = new TwitterFactory(configuration);
        twitter = factory.getInstance();

        String dbUserName = "root";
        String dbPass = "";
        String host = "127.0.0.1";
        String db = "tw_Bot";
        String port = "3306";

        Connection con = null;

        String url = "jdbc:mysql://" + host + ":" + port + "/" + db;
        // url = url + "?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("mysql connector not found");
        }

        try {
            con = DriverManager.getConnection(url, dbUserName, dbPass);

        } catch (SQLException e) {
            System.out.println("sql err: " + e.getMessage());
        }

        if (con != null) {
            System.out.println("success.");
        }

        //        foundNotFollowing(con);

        // notfollowingUnfollow(con);

        notfollowingUnfollowWithUserName(con);

        // followReadDb(con);

        // removeNotFollowed( con );

    }

    private void notfollowingUnfollowWithUserName(Connection con) {


        System.out.println("not following unfollow started....");
        String sql = "SELECT DISTINCT username FROM inactive_list order by id desc limit 500";
        int i = 0;
        try {
            Statement statement = con.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);


            while (resultSet.next()) {
                i++;

                String username = resultSet.getString("username");

                System.out.println(i + " username:" + String.valueOf(username));

                twitter.destroyFriendship(username); // make unf

                String updateQuery = "DELETE FROM inactive_list WHERE username = ? ";
                PreparedStatement preparedStmt = con.prepareStatement(updateQuery);
                preparedStmt.setString(1, username);

                Thread.sleep(1250);

                System.out.println("updateQuery : " + updateQuery);
                preparedStmt.executeUpdate();


            }
        } catch (Exception e) {

            System.out.println("ERROR :" + e.getMessage());
        }

    }

    private void notfollowingUnfollow(Connection con) {
        System.out.println("not following unfollow started....");
        String sql = "SELECT DISTINCT user_id FROM not_following order by id desc limit 500";
        int i = 0;
        try {
            Statement statement = con.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);


            while (resultSet.next()) {
                i++;

                long friendId = resultSet.getLong("user_id");

                System.out.println(i + " _userId:" + String.valueOf(friendId));

                twitter.destroyFriendship(friendId); // make unf

                String updateQuery = "DELETE FROM not_following WHERE user_id = ? ";
                PreparedStatement preparedStmt = con.prepareStatement(updateQuery);
                preparedStmt.setLong(1, friendId);

                Thread.sleep(1000);

                System.out.println("updateQuery : " + updateQuery);
                preparedStmt.executeUpdate();


            }
        } catch (Exception e) {

            System.out.println("ERROR :" + e.getMessage());
        }

    }

    private void foundNotFollowing(Connection con) {
        System.out.println("function started.");
        long cursor = -1;
        IDs ids;
        ArrayList<Long> followersList = new ArrayList<Long>();
        ArrayList<Long> followingList = new ArrayList<Long>();

        System.out.println("----------------------------------------------");

        try {
            do {
                ids = twitter.getFollowersIDs(cursor);
                System.out.println("followers working...");
                for (long id : ids.getIDs()) {
                    followersList.add(id);
                }
            } while ((cursor = ids.getNextCursor()) != 0);
            System.out.println("fullFriendList: " + followersList.size());

        } catch (TwitterException e) {
            e.printStackTrace();
        }
        cursor = -1;
        System.out
                .println("---------------followingList started-----------------");

        try {
            do {
                ids = twitter.getFriendsIDs(cursor);
                System.out.println("followingList working...");
                for (long id : ids.getIDs()) {
                    followingList.add(id);
                }
            } while ((cursor = ids.getNextCursor()) != 0);
            System.out.println("followingList: " + followingList.size());

        } catch (TwitterException e) {
            e.printStackTrace();
        }

        System.out
                .println("--------------------working--------------------------");

        followingList.removeAll(followersList);

        System.out.println("not following size: " + followingList.size());

        for (long userId : followingList) {
            insertNotFollowingDb(String.valueOf(userId), con);

        }

        System.out
                .println("------------------------finish------------------------");

    }

    public void followReadDb(Connection con) {

        System.out.println("followReadDb started.");
        try {
            int i = 0;
            String sql = "SELECT * FROM friends where scanned = 1 and status=0 and unfollowed = 0 limit 1000";
            // sql = "SELECT * FROM friends where scanned = 0 limit 5000";

            Statement statement = con.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);
            boolean isUnf = true;
            while (resultSet.next()) {
                long friendId = resultSet.getLong("friend_id");

                if (isUnf) {
                    System.out.println(i + " _userId:"
                            + String.valueOf(friendId));
                    makeUnfollow(con, friendId);
                    rawUpdated2(friendId, con); // make unfollowed = 1 on DB
                } else {
                    UserTwit userTwit = controlFollow(friendId);
                    rawUpdate(userTwit, con);
                    System.out.println(i + " _usertw:" + userTwit.getId() + " "
                            + userTwit.getStatus() + " "
                            + userTwit.getUsername());
                }
                Thread.sleep(500);
                i++;
            }
            statement.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("ERROR : followReadDb : " + ex.getMessage());
        }
        System.out.println("---finish----");

    }

    public UserTwit controlFollow(long friendId) {
        UserTwit usertw = new UserTwit();
        try {

            Relationship r = twitter.showFriendship(twitter.getId(), friendId);

            usertw.setId(friendId);
            usertw.setUsername(r.getTargetUserScreenName());

            if (!r.isTargetFollowingSource()) {
                usertw.setStatus(0);
                // twitter.destroyFriendship(friendId); //TODO destroy

            } else {
                usertw.setStatus(1);
            }

        } catch (Exception e) {

            System.out.println("ERROR (id: " + friendId + " ) controlFollow:"
                    + e.getMessage());
        }
        return usertw;

    }

    public void makeUnfollow(Connection con, long friendId) {

        try {
            twitter.destroyFriendship(friendId); // make unf

        } catch (Exception e) {

            System.out.println("ERROR (id: " + friendId + " ) controlFollow:"
                    + e.getMessage());
        }

    }

    public void rawUpdate(UserTwit usertw, Connection con) {

        try {
            String updateQuery = "update friends set status = ? , scanned = ? , username = ?  where friend_id = ?";
            PreparedStatement preparedStmt = con.prepareStatement(updateQuery);
            preparedStmt.setInt(1, usertw.getStatus());
            preparedStmt.setInt(2, 1);
            preparedStmt.setString(3, usertw.getUsername());
            preparedStmt.setString(4, String.valueOf(usertw.getId()));

            System.out.println("updateQuery : " + updateQuery);
            preparedStmt.executeUpdate();

        } catch (Exception ex) {
            System.out.println("UPDATE ERROR : " + ex.getMessage());
        }

    }

    public void rawUpdated2(long friendId, Connection con) {

        try {
            String updateQuery = "update friends set unfollowed = ?  where friend_id = ?";
            PreparedStatement preparedStmt = con.prepareStatement(updateQuery);
            preparedStmt.setInt(1, 1);
            preparedStmt.setString(2, String.valueOf(friendId));

            System.out.println("updateQuery : " + updateQuery);
            preparedStmt.executeUpdate();

        } catch (Exception ex) {
            System.out.println("UPDATE ERROR : " + ex.getMessage());
        }

    }

    public void insertDb(String friendId, int isStatus, int isScanned,
                         Connection con) {

        try {
            String insertSqlQuery = "insert into friends ( friend_id , status , scanned) values ( '"
                    + friendId + "'," + " 0,0)";
            System.out.println(insertSqlQuery);
            PreparedStatement insertRaw = con.prepareStatement(insertSqlQuery);
            insertRaw.executeUpdate();
        } catch (Exception ex) {
            System.out.println("raw error : " + ex.getMessage());
        }

    }

    public void insertNotFollowingDb(String friendId, Connection con) {

        try {
            String insertSqlQuery = "insert into not_following ( user_id ) values ( '"
                    + friendId + "')";
            // System.out.println(insertSqlQuery);
            PreparedStatement insertRaw = con.prepareStatement(insertSqlQuery);
            insertRaw.executeUpdate();
        } catch (Exception ex) {
            System.out.println("raw error : " + ex.getMessage());
        }

    }

    private void removeNotFollowed(Connection con) {
        System.out.println("function started.");
        // long[] longIds = null;
        long cursor = -1;
        IDs ids;
        // int unfollowedPeople = 0;
        ArrayList<Long> fullFriendList = new ArrayList<Long>();
        // ArrayList<Long> scannedList = new ArrayList<Long>();

        try {
            do {
                ids = twitter.getFriendsIDs(cursor);

                for (long id : ids.getIDs()) {
                    insertDb(String.valueOf(id), 0, 0, con);
                    // fullFriendList.add(id);
                }
            } while ((cursor = ids.getNextCursor()) != 0);
            // System.out.println("fullFriendList: " + fullFriendList);

        } catch (TwitterException e) {
            e.printStackTrace();
        }

    }

}