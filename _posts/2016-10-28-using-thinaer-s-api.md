---
layout: post
title: Intro to THINaer's API
date:   2016-10-28 20:50:00 -0500
categories: update api iot
---

THINaer is an IoT based company that offers an API that provides proximity and environmental information based on deployed <span class="yellow">"iris"</span> (AKA Beacons) and it's <span class="yellow">"Cirrus"</span> (an IoT Gateway). The iris devices are movable or static based on use case and the Cirrus is always static in a fixed location. iris transmits it's signal at a set interval along with any other sensor data the iris may have, this can include; internal chip temperature on the “ii12”, external temperature and relative humidity on the “ii18e”, and finaly movement detection using an accelerometer on the “ii18a”.

<div class="white-box">
  <img src="/images/Iris64.png" alt="iris from THINaer" />
</div>

### The Hardware Technologie
THINaer is using the latest in BLE 4.1 technologie to transmit its packet over a custom protocol. This protocol can be picked up by any BLE device that can read device packets, tho because this is a custom proprietary protocol designed by the team and myself some development work will need to be done to decode the packets.

<div class="banner note">
  <h3>THINaer Protocol</h3>
  <p>Decoding the packet is only needed if you want to use iris outside of the API.</p>
</div>

### The REST API
In just a few days <span class="red">the company will be releasing a new version of the API (v2)</span>, so everything that follows will talk about using the latest version. The THINaer API provides near-real time access to proximity and environmental information. It also provides historical movement information, this is used for asset tracking use cases, we will talk more about that later. The API also provides a two way look, meaning I can see what a Cirrus can see or I can look from the perspective of an iris.

<div class="banner callout">
  <h3>Proximity and Environmental</h3>
  <p>THINaer API provides near-real time access to proximity and environmental information.</p>
</div>

Something a little special with this API is that it allows a developer to organize it’s devices based on “clients” and “venues”. This comes into play when you are building a multi tenant application using the API. You can then have many “clients” that belong to your application and assign devices to the client as you see fit, providing some separation for your customers. Within the “client” you can then further organize to “venues”, this often relates to physical locations but are really just groups and can be used anyway you see fit.

### Getting started - Authentication
Before you can make any requests to get data you need to authenticate with the API. Below is an example using CURL.


{% highlight bash %}
curl --request POST \
  --url {{url}}/api/v2/application/token \
  --header 'content-type: application/json' \
  --header 'secret: cf2aca10-9355-11e6-8b95-7932558ded9d' \
  --header 'uid: 7345ccf0-fa43-4ad2-a5c0-d26a172c2acd'
{% endhighlight %}


The UID and Secret are provided by THINaer at first setup. This token request will return just that, a token that should be saved and will expire in 24 hours.

<div class="banner callout">
  <h3>Token</h3>
  <p>The token should be saved and will expire in 24 hours.</p>
</div>

### Let's get the iris and Cirrus devices assigned to your account!
Now that you have authenticated lets looks the the devices assigned to your account. Using the token you just received we will request all devices by type. See below:

#### iris Devices by application
{% highlight bash %}
curl --request GET \
  --url {{url}}/api/v2/application/iris \
  --header 'content-type: application/json' \
  --header 'token: {{token}}'
{% endhighlight %}

#### Cirrus Devices by application
{% highlight bash %}
curl --request GET \
  --url {{url}}/api/v2/application/cirrus \
  --header 'content-type: application/json' \
  --header 'token: {{token}}'
{% endhighlight %}

The two objects returned will display all devices assigned to your account, you can save that data locally or make this request as often as you like. When you buy new devices they will always show under your account and this request will update the moment they are added.

### Going forward
If you come back, I will cover some simple use cases and how to get the data out of THINaer! I how now that you have a basic understanding of how to authenticate and make your first request using the new version 2 THINaer API.
