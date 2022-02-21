---
name: Toontown VR
tools: [Panda3D, Python3, Astron, OpenVR]
image:
description: An experimental virtual reality port of Disney's defunct Toontown Online. The project features a custom fork of the Panda3D game engine and a fully upgraded Python 3 version of the original Python 2.2 game.
---

<div align="center">
    <img src="/images/toontown-logo.png">
    <h2>Virtual Reality Edition</h2>
</div>
<hr/>

Toontown VR was an experimental one off port of Disney's Toontown designed to run under Valve's OpenVR library. The user interface was not ported and controls were incomplete resulting in the user needing to take the headset off regularly to interact with the keyboard/mouse.

To achieve the required performance to run the 20+ year old game under virtual reality the codebase had to be upgraded to the latest version of Panda3D and the Python 3 language. A custom render window was also written in later iterations to render directly to OpenVR from within the C++ engine code further reducing the load Python had to handle for optimal performance.

## Live Stream Demo

On October 25th, 2020 a live demo was recorded of an early version of the prototype. The demo was recored with an Oculus Rift S and had frame rate issues because at the time the OpenVR composit submit was happening in the single threaded Python side of the Panda3D engine. Resulting in a lot of global interpretor lock interaction going back and forth from C++ to Python

The live stream archive can be found here.

{% include videos/youtubePlayer.html id='N78HXmZZAI0' %}