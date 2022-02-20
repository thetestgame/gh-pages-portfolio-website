---
layout: full-page
title: About
permalink: /about/
weight: 3
---

<img src="https://raw.githubusercontent.com/thetestgame/thetestgame/master/images/emotes/testhappyflipped.png" width="150" align="right">

# **About Me**

Hello, My name is {{ site.author.name }}! :wave:
========================================

I'm a professional Game Developer and Web Developer based in Wisconsin.

Since 2004 I've been living and breathing software development, progressively building and expanding my skillset. Creating everything from video games to distributed networking solutions and AR/VR marketing applications. I've had the chance to immerse myself in many different works and projects in the last 17 years, helping to make this world a little better through design & code. 

<hr/>
<div class="row">
    <div class="col">
        {% include about/skills.html title="Programming Skills" source=site.data.programming-skills %}
        {% include about/skills.html title="Hardware Skills" source=site.data.hardware-skills %}
        {% include about/skills.html title="Other Skills" source=site.data.other-skills %}
    </div>
    <div class="col">
        <h2>Work History</h2>
        {% include about/timeline.html %}
    </div>
</div>