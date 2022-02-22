---
layout: full-page
title: About
permalink: /
weight: 1
---

{% remote_include https://raw.githubusercontent.com/thetestgame/thetestgame/master/README.md %}

<hr/>
<div class="row">
    <div class="col">
        <!--{% include about/progress-skills.html title="Cloud Technologies" source=site.data.cloud-skills %}-->
        {% include about/progress-skills.html title="Programming Skills" source=site.data.tools-technologies-skills %}
        <!--{% include about/skills.html title="Industry Knowledge" source=site.data.industry-skills %}-->
        <!--{% include about/skills.html title="Hardware Skills" source=site.data.hardware-skills %}-->
        <!--{% include about/skills.html title="Other Skills" source=site.data.other-skills %}-->
    </div>
    <div class="col">
        <h2>Recent Work History</h2>
        {% include about/work-timeline.html %}

        <h2>Recent Volunteer History</h2>
        {% include about/volunteer-timeline.html %}
    </div>
</div>
