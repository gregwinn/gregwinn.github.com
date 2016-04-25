---
layout: post
title: MySQL 5.7 issues
date:   2016-04-24 22:52:00 -0500
categories: update ubuntu
---

After the latest Ubuntu 16.04 update, I did what thousands and thousands of people did. I upgraded from 15.10 while using and older version of MySQL (5.6).

<div class="banner callout">
  <h3>Upgrading Ubuntu 15.10 to 16.04</h3>
  <p>I used the GUI, and the update went VERY smooth and without error!</p>
</div>

### Testing the update
The first thing I did was confirm that my Ruby projects still worked and all started up. I pulled the latest from my project and ran a `rake db:migrate` and it failed. I then tried to connect to my local database `mysql -u root -p` (My MySQL setup locally has not password, this is important to remember). Durring the update I also notice that MySQL was upgraded from 5.6 to 5.7.

<div class="banner note">
  <h3>MySQL 5.7's New Requirements</h3>
  <p>Mysql was updated to 5.7 and now uses a socket for local connections. This is not needed on my development environment so I will need to alter the follow tables.</p>
</div>

#### "Fix" MySQL 5.7 to work like it use to.
First we need to connect to mysql and by now you have found that you can not... Here is how:

{% highlight bash %}
sudo mysql -u root -p
(enter your sudo password)
(no password for mysql)
{% endhighlight %}


Now we need to alter the User table to remove the new auth_socket plugin.
{% highlight sql %}
mysql > UPDATE mysql.user SET plugin = "mysql_native_password" where User = 'root' AND plugin = "auth_socket";
mysql> FLUSH PRIVILEGES;
mysql> quit
{% endhighlight %}

Lets `stop` and `start` the service and connect like normal!
{% highlight bash %}
sudo service mysql stop
sudo service mysql start

mysql -u root
mysql >
{% endhighlight %}
