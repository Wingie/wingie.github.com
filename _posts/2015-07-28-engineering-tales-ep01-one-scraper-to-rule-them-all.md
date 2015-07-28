---
layout: post
title: "Ep01: One Scraper to Rule them all"
description: ""
category: EngineeringTales
tags: []
image: "/images/spider.jpg"
---
{% include JB/setup %}

So one fine day i started a project with an old friend of mine. We wanted to know if it was possible to build a system that was capable of predicting with a certain degree of accuracy if two nations were going to war.

nothing came of that discussion, and sometime later i came into possession of some code that apparently was being used to write scrapers for popular newssites.

a quick glance told me why the project had been abandoned to its fate on bitbucket. 


{% img imageCenter /images/spider_list.png Ninja Attack! %}

like holy crap.

thats a lot of scrapers. the chap had written a scraper for every news site!

of course, since i wanted to work on some algorithms using the platform, i had to of course support a lot of news sites. 

i needed a way to be able to scrape the news_date, location, and the content of a news article.

```
description = '\n'.join([u.encode('utf-8').strip() for u in hxs.select('//p/text()').extract() if u.encode('utf-8').strip()!=''])
```

the biggest problem that i faced was of course uncicode text, some random chinese characters would fuck it all up.

seriously python needs to get its utf-8 encoding shit together.

```
image_src_s = [im for im in hxs.select('//img/@src').extract() if ('http' in im and 'png' in im)]
```

we can also find the first image. but i ended up trying to find the biggest image that i could and storing that.

once i get all this metadata, i just store it as a regular djano record in the hopes.

this might not sound like much, but it was the beginning of a project called [wingzTV](http://wingztv.com)