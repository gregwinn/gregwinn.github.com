---
layout: post
title: Environmentals using THINaer's IoT API
date:   2016-11-09 13:50:00 -0500
categories: update api iot
---

This article will assume you have read and understood the “<a href="/update/api/iot/2016/10/28/using-thinaer-s-api.html">Intro to THINaer’s API</a>”. If you have not read that article it covers how to connect and authenticate with the API along with some organizational tips. This post will cover a simple use case using one <span class="yellow">Cirrus</span> and a few <span class="yellow">iris (ii18e)</span>, <span class="yellow">iris 18e</span> holds environmental sensors that monitor temperature and relative humidity. The chip used to monitor temperature is accurate to +/-0.5C and relative humidity to +/-2%. While the <span class="yellow">ii12</span> does display something called “internal temperature” it is very inaccurate and should only be used for non essential functions or if you want to take a close guess at temp.

<div class="banner callout">
  <h3>Environmental Accuracy</h3>
  <p>ii18e is accurate to +/-0.5C (temp) and +/-2% (RH).</p>
</div>

<div class="white-box">
  <img src="/images/ii18e.png" alt="iris from THINaer" />
</div>

### Setup

Taking the Cirrus, I am going to plug it in and follow the setup instructions included in my box. This involves just a few steps:

<ol>
  <li>Provide power to the device.</li>
  <li>Using your computer with wifi, connect to the “Whisker.IO” wifi network.</li>
  <li>Scan for available wifi networks.</li>
  <li>Select and provide the password.</li>
</ol>

The Cirrus will power off then on and <span class="red">the blue LED should blink periodically but not with any uniformity</span>. If it continues to blink with uniformity then just try again.

Now let’s place an <span class="yellow">ii18e</span> indoors about 30 feet away from the Cirrus, and another outdoors about 50 to 80 feet away.

<span class="red">Once you have deployed the hardware it has already begun to collect data</span>! Now that the <span class="yellow">Cirrus</span> was powered on and connected to wifi it started sending data back to THINaer for use in the API.

### Start collecting environmentals

Let’s do some basic organization of our hardware for later use, using POSTMAN or curl (or any programming language) lets place the two iris at a new “venue” but first let’s create a “venue” called “Home”. The API allows a developer to organize it’s devices based on “clients” and “venues”. This comes into play when you are building a multi tenant application using the API. You can then have many “clients” that belong to your application and assign devices to the client as you see fit, providing some separation for your customers. Within the “client” you can then further organize to “venues”, this often relates to physical locations but are really just groups and can be used anyway you see fit.

<div class="banner note">
  <h3>Venues</h3>
  <p>Venues often relate to physical locations but are really just groups and can be used anyway you see fit.</p>
</div>

{% highlight bash %}
curl --request POST \
  --url http://api.thinaer.io/api/v2/venue/ \
  --header 'client-id: 580504eb8c427a849136a3ee' \
  --header 'content-type: application/json' \
  --header 'token: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJjcmVhdGVkIjoiMjAxNi0xMS0wMlQwMTo1NjowNS45NjVaIn0.i6KnWmSqzcXmLt5kxXbPpLfam9EkzXQwWaLRObHJ4lk' \
  --data '{\n	"name": "Home"\n}'
{% endhighlight %}


##### Response

{% highlight json %}
{
  "__v": 0,
  "client_id": "580504eb8c427a849136a3ee",
  "name": "Home",
  "_id": "580833346fca85b59e347c1e"
}
{% endhighlight %}

Now lets use the new venue id to assign to the devices so they belong to that venue.

<div class="banner note">
  <h3>Best Practice</h3>
  <p>It’s good practice to organize your devices even if you don’t plan to use the venue in your application. It could save you a bunch of time later!</p>
</div>

Assign each device to the newly created venue (580833346fca85b59e347c1e):

{% highlight bash %}
curl --request PUT \
  --url http://api.thinaer.io/api/v2/device/123456789a31 \
  --header 'client-id: 580504eb8c427a849136a3ee' \
  --header 'content-type: application/json' \
  --header 'token: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJjcmVhdGVkIjoiMjAxNi0xMS0wMlQwMTo1NjowNS45NjVaIn0.i6KnWmSqzcXmLt5kxXbPpLfam9EkzXQwWaLRObHJ4lk' \
  --data '{\n	"venue_id": "580833346fca85b59e347c1e",\n}'

  # Do for each device.
{% endhighlight %}

### Our simple application

Now we can write a <span class="yellow">simple script to collect the data every 15 minutes</span> and save it to the database. In my example below I am using <span class="red">ruby from the THINaer API docs</span> to look for all my devices by my venue_id and then looping them. Once looped and am saving them to redis for later use! At this point you can really do whatever you want to do with the information.

<div class="banner callout">
  <h3>Proximity and Environmental</h3>
  <p>THINaer API provides near-real time access to proximity and environmental information.</p>
</div>

##### Get devices by venue_id.
{% highlight ruby %}
require 'uri'
require 'net/http'

url = URI("{{url}}/api/v2/venue/580833346fca85b59e347c1e/devices")

http = Net::HTTP.new(url.host, url.port)

request = Net::HTTP::Get.new(url)
request["content-type"] = 'application/json'
request["client-id"] = '580504eb8c427a849136a3ee'
request["token"] = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJjcmVhdGVkIjoiMj...'

response = http.request(request)
devices = response.read_body
{% endhighlight %}

##### Loop the devices and save the data I want to redis.

{% highlight ruby %}
devices.each do |device|
  REDIS.set(device['_id'] + "_temp", device['temp'])
  REDIS.set(device['_id'] + "_rh", device['rh'])
end
{% endhighlight %}

##### Front-end HTML view

The API provides the temp in celsius but on the front end I have converted it to fahrenheit.
<div class="white-box">
  <img src="/images/html_datafromapi.png" alt="iris from THINaer" />
</div>

My next article on the API will cover more in depth on organization and I will touch on movement history and how to see where your beacons have been!
