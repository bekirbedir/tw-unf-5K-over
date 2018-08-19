var screenNameList = []
var userNameList = []
screenNameList = document.getElementsByClassName("screen_name")
for(var i = 0 ; i < screenNameList.length ; i ++)
{
 userNameList .push( 'INSERT INTO inactive_list(username) VALUES ("' + screenNameList[i].innerText.replace("@","") + '")' )
 }

//console.log(userNameList )

var sqlComment = userNameList.join(";")

console.log(sqlComment);
unfollow.goToPage(0)
