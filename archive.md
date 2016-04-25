---
layout: page
title: Archive
permalink: /archive/
---

<ol>
{% for post in site.posts %}
  <li><a href="{{post.url}}">{{post.title}}</a> <span class="post-meta">{{ post.date | date: "%b %-d, %Y" }}</span></li>
{% endfor %}
</ol>
