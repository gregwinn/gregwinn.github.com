---
layout: post
title: Why nodejs
categories: update nodejs
---

Recently I have been toying around with AngularJS with in a Ruby on Rails application. This had really been my first major use of anything other than jQuery, I am a huge jQuery fan and have been way before I got into rails. After taking a really great tutorial from Anthony Alicea on Udemy.com it was instantly clear to me. AngularJS is badass, and I should be using this more often! Two way data binding seems like something that should be available in jQuery but I have not had too much luck finding anything good, until Angular.

<div class="banner note">
  <h3>Using AngularJS often leads to NodeJS but can be used with any language.</h3>
  <p>I often use AngularJS with Ruby on Rails projects but in this case I was looking at NodeJS.</p>
</div>

Playing with AngularJS led me to Node.js (I know they are separate things, AngularJS just peeked my interest in all things Javascript again). I have had a little experience with node prior to this but in a VERY early version, when it was just becoming a “thing”. I set out to try it again, and told myself that I was going to complete a project using just javascript!

To get my feet wet and start learning some of the in’s and out’s of Node.js I went back to Udemy.com for some help. This time I was not so lucky in finding a “high” quality tutorial. It looks like everyone who had a crappy mic was making tutorials on Node. This led me to a mix of places, and finally landed on a tutorial talking about a “framework” like thing for Node.js called ExpressJS. It quickly reminded me of Sinatra on Ruby, and I was immediately comfortable. My next hurdle was finding out what this “Jade” stuff was all about.

### Jade

Ok first off, why? Secondly, what? As a Rails developer I have known about haml and some other templating languages but, when did HTML become so hard to write or use? Why do we feel we need to replace this easy to use and understand language? I asked that very question to some developer friends: “Why replace HTML with Jade or any other templating language?”. Most developers who could offer up an explanation said they can write it faster than HTML alone. Others stated, “HTML is too dirty” as in it was hard to read or debug.

I gave Jade a very good look over, and then played with it for a week or two on some test applications I was building. I personally am not a fan, HTML is easy and I don’t see any reason to replace it with something that has to be parsed and converted to HTML.

Back to NodeJS & ExpressJS… also AngularJS

### Express JS

With the decision not to use Jade, I was looking for alternatives when I discovered that I could simply use HTML and AngularJS as my front end. So I started a project with Node.js and ExpressJS. Creating an API, I got into my second or third endpoint when I realized what was going on and said “Why am I doing this in NodeJS?”. Why was I creating an API in Node and not something like Sinatra or Rails with endless helpers and gems to get the job done? I quickly said to myself that I am just learning this, and there has to be an “ah HA” moment! I will not keep you waiting, that moment never came, but why? After I had built a project and finished it, I was very proud of my accomplishment and started to really think about why I would use Node.js+Express over Rails for any future projects.

### It’s Javascript People!
I did like that Node is self contained and had a package manager, then was also simple to install and run on a server (very similar to bundler for Ruby). I also liked the speed and concurrent connections you can get from it.

We have to remember that it’s just Javascript, and I know that is a ton of it’s appeal. Front end developers can now build backend services, and for companies it makes sense by getting access to a larger talent pool. Because everyone and their mother knows a little Javascript. From my point of view right now, Node.js seems to be over hyped and a fix all new toy.

### Why Javascript?
With an alternative like Ruby, why would you choose Javascript to write a backend service API? Many things that I can do in one line in Ruby, take four or five in Javascript. As developers, do we feel that writing more code is good? Why do we think that being more expressive is better when it comes to code?

Many state that Rails is too black box or magic. I often reply, “What’s so wrong with that?”. I often get the typical, “Once you step out of CRUD or want to do anything complicated Rails forces you to do it the ‘Rails Way’”, of which I also reply “What’s so wrong with that?”. Rails forces a standard that any other Rails developer can walk in and go, “Yep, I know what’s going on here”. As a developer that started with PHP, I know that not having any standards is a royal pain in the ass for the next person that has to look at my code. Thus becoming the black box anyway. Rails takes care of your low hanging fruit and allows you to get to the meat, quickly. While Node has some ORM options, why not just is a real ORM in Rails and be done?

Before digging into Node.js, you might want to read up on the benefits of using JavaScript across the stack which unifies the language and data format (JSON), allowing you to optimally reuse developer resources. As this is more a benefit of JavaScript than Node.js specifically, we won’t discuss it much here. But it’s a key advantage to incorporating Node in your stack.

### Conclusion, I think…
While I am a Rails fan, I don’t dislike Node or Javascript. I believe they have there place, and when used properly they are great. I will continue to use Node and Express along with Angular separately or all together when it’s needed. It really comes down to what you are comfortable with and finding the correct tool for the job. As I said above, Node.js has a place and should be used when you find that place. As developers, we often get hung up in the latest and greatest. Starting your next project, really think if Node.js is right for the job or something like Rails will get you to the finish line quicker.
