---
layout: post
title: MySQL 5.7 issues
date:   2016-04-24 22:52:00 -0500
categories: update ubuntu
---

After the latest Ubuntu 16.04 update, I did what thousands and thousands of people did. I upgraded from 15.10 while using and older version of MySQL (5.6).


### Testing the update
The first thing I did was confirm that my Ruby projects still worked and all started up. I pulled the latest from my project and ran a `rake db:migrate` and it failed. I then tried to connect to my local database `mysql -u root -p` (My MySQL setup locally has NO password: this is important to remember, this issue ONLY effects those with no password set for root). While I was updating I also notice that MySQL was upgraded from 5.6 to 5.7.

<div class="banner callout">
  <h3>The MySQL 5.7 "Issue"</h3>
  <p>While this is not really and issue because it is by design. This update ONLY effects those with no password set for root. <a href="https://anonscm.debian.org/cgit/pkg-mysql/mysql-5.7.git/tree/debian/NEWS?id=1025a9fa9c6c112913c59138db49dbc94891d20f">More can be seen here...</a></p>
</div>

#### "Fix" MySQL 5.7 to work like it use to.
First we need to connect to mysql and by now you have found that you can not... Here is how:

{% highlight bash %}
sudo mysql -u root -p
(enter your sudo password)
(no password for mysql)
{% endhighlight %}


<div class="banner note">
  <h3>MySQL 5.7's New Requirements</h3>
  <p>Mysql was updated to 5.7 and now uses a socket for local connections or the `auth_socket` plugin. This is not needed on my development environment so I will need to alter the follow table.</p>
</div>
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

### References

<a href="https://anonscm.debian.org/cgit/pkg-mysql/mysql-5.7.git/tree/debian/NEWS?id=1025a9fa9c6c112913c59138db49dbc94891d20f">https://anonscm.debian.org/cgit/pkg-mysql/mysql-5.7.git/tree/debian/NEWS?id=1025a9fa9c6c112913c59138db49dbc94891d20f</a>
