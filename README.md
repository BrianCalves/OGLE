
Overview of OpenGL Example (OGLE) for Mac OS X
==============================================

This Cocoa application demonstrates how to implement rudimentary OpenGL rendering on Mac OS X.
OGLE provides keyboard, mouse, and trackpad interactivity, including basic gestures.
OGLE was developed using Xcode 3 on Mac OS X 10.5.8.
The programming language is Objective-C.

![Screenshot of OGLE](doc/OGLE-A.png?raw=true "Screenshot of OpenGL Example on Mac OS X 10.5.8")

Software Design
---------------

From a software design perspective, the primary component of OGLE is `GraphicView`, a subclass of `NSOpenGLView`.
The `Color` and `CameraModel` classes may be interesting to some audiences.

OGLE incorporates a single light source, to demonstrate basic lighting operations in OpenGL.

Hardware Requirements
---------------------

The OpenGL requirements for this application are double-buffered 32-bit RGBA color (8 8 8 8) with a 32-bit depth buffer.
If your hardware cannot satisfy these requirements, the application will not run, or may exit with an obscure error message.

The foregoing OpenGL hardware system requirements were specified using Apple's Interface Builder 3 *OpenGL View Inspector*.
If the design of Interface Builder 3 is any indication, hard-coding the OpenGL requirements is the method endorsed by Apple. 
Although, in general, that approach is probably not commendable.

Building and Running the Software
---------------------------------

If you have a Mac with Apple Developer Tools of a suitable vintage, you should be able to build and run OGLE on your computer by downloading the source code, opening OGLE.xcodeproj, then performing a `Build and Go`.

