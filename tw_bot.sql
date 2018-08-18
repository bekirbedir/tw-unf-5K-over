-- phpMyAdmin SQL Dump
-- version 4.8.0
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 18 Ağu 2018, 19:02:29
-- Sunucu sürümü: 10.1.31-MariaDB
-- PHP Sürümü: 7.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `tw_bot`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `connect`
--

CREATE TABLE `connect` (
  `id` int(11) NOT NULL,
  `oauth_access_token` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `oauth_access_token_secret` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `oauth_consumer_key` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `oauth_consumer_secret` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `relational_user_id` bigint(20) DEFAULT NULL,
  `relational_username` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `followers_ids`
--

CREATE TABLE `followers_ids` (
  `id` int(11) NOT NULL,
  `relational_user_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `following_ids`
--

CREATE TABLE `following_ids` (
  `id` int(11) NOT NULL,
  `relational_user_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `hibernate_sequence`
--

CREATE TABLE `hibernate_sequence` (
  `next_val` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `hibernate_sequence`
--

INSERT INTO `hibernate_sequence` (`next_val`) VALUES
(5),
(5),
(5),
(5),
(5),
(5),
(5);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `inactive_list`
--

CREATE TABLE `inactive_list` (
  `id` int(11) NOT NULL,
  `username` text COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `not_following`
--

CREATE TABLE `not_following` (
  `id` int(11) NOT NULL,
  `user_id` text COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `not_following_ids`
--

CREATE TABLE `not_following_ids` (
  `id` int(11) NOT NULL,
  `relational_user_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `role`
--

CREATE TABLE `role` (
  `role_id` int(11) NOT NULL,
  `role` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `role`
--

INSERT INTO `role` (`role_id`, `role`) VALUES
(1, 'ADMIN');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `twitter_profile`
--

CREATE TABLE `twitter_profile` (
  `id` int(11) NOT NULL,
  `followers` int(11) DEFAULT NULL,
  `following` int(11) DEFAULT NULL,
  `last_tweet_date` datetime DEFAULT NULL,
  `relational_user_id` bigint(20) DEFAULT NULL,
  `retweet_total` int(11) DEFAULT NULL,
  `tweets_total` int(11) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `user_name` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `active` int(11) DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_turkish_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8_turkish_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_turkish_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `user`
--

INSERT INTO `user` (`user_id`, `active`, `email`, `last_name`, `name`, `password`) VALUES
(1, 1, 'asdasd@asdasd.com', 'asdasd', 'asdasd', '$2a$10$/luheoiT3IUUPZJDDJO1tOhmH/TuOEocZ65R9JtZ/r.ykdc1dSsqO'),
(2, 1, 'naasdljk@m.com', 'naasdljk', 'naasdljk', '$2a$10$X3z2kM.et9aZMAFj2KCOXubPz1xpJNjUFr6coLMxkIBprz4VOsLsi'),
(3, 1, 'test12@m.com', 'test12', 'test12', '$2a$10$EJOI5M/FprBzJApLgcELyeg0rwO6E3W3IYeIpU5oOZKOjUtj8J4S6'),
(4, 1, 'amnsdja@m.com', 'amnsdja', 'amnsdja', '$2a$10$UIYLwFDArq706hcWuOiXhe4bAAKm.Y/Bi12fwOYwOCMOj6yd62pqC');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `user_role`
--

CREATE TABLE `user_role` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `user_role`
--

INSERT INTO `user_role` (`user_id`, `role_id`) VALUES
(4, 1);

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `connect`
--
ALTER TABLE `connect`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `followers_ids`
--
ALTER TABLE `followers_ids`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `following_ids`
--
ALTER TABLE `following_ids`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `inactive_list`
--
ALTER TABLE `inactive_list`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `not_following`
--
ALTER TABLE `not_following`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `not_following_ids`
--
ALTER TABLE `not_following_ids`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`role_id`);

--
-- Tablo için indeksler `twitter_profile`
--
ALTER TABLE `twitter_profile`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- Tablo için indeksler `user_role`
--
ALTER TABLE `user_role`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `FKa68196081fvovjhkek5m97n3y` (`role_id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `inactive_list`
--
ALTER TABLE `inactive_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `not_following`
--
ALTER TABLE `not_following`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
