//
//  GraphicView.m
//  OGLE
//
//  Created by Brian Cálves on 2013-03-28.
//  Copyright 2013 Brian Cálves. All rights reserved.
//

#import "GraphicView.h"
#include <OpenGL/gl.h>

@implementation GraphicView

static void drawAnObject()
{
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	glTranslated(0.0, 0.0, -2.0);
    glColor3f(1.0f, 0.85f, 0.35f);
    glBegin(GL_TRIANGLES);
    {
        glVertex3f(  0.0,  0.3, 0.0);
        glVertex3f( -0.3, -0.3, 0.0);
        glVertex3f(  0.3, -0.3 ,0.0);
    }
    glEnd();
}

- (void) activateContext
{
	[[self openGLContext] makeCurrentContext];
}

- (void) flushContext
{
	[[self openGLContext] flushBuffer];
}

- (void) reshape	
{
    // The viewing frustum must be updated. The frustum is defined by
	// a field of view, a near clipping plane, and the distance to
	// the far clipping plane.
	//
	// In OpenGL, the viewing frustum looks down the -Z axis. The
	// +Y axis is up. The +X axis is to the right. The world is
	// translated and rotated in front of the frustum by means
	// of the model-view matrix.
	//
	// In general, it is not practical to incorporate the actual
	// characteristics of the physical computer display into the
	// frustum calculation: the visual may span multiple display
	// devices of varying dimension and resolution. In other
	// words, nothing can be assumed about the number of pixels
	// or the number of pixels per inch, because these
	// characteristics might vary across the logical viewport.
	//
	// Depth buffer precision is affected by the values specified for
	// zNear and zFar. Bits of lost depth buffer precision (L) is
	// approximately:
	//
	//     L = log2(zFar / zNear)
	//
	// The greater the ratio of zFar to zNear, the less effective
	// the depth buffer will be at distinguishing surfaces that are
	// near each other. Depth buffer effectiveness also declines if
	// zNear approaches zero.

	[self activateContext];

	NSRect bounds = [self bounds];
	
	GLint x = 0;
	GLint y = 0;
	GLsizei w = NSWidth(bounds);
	GLsizei h = NSHeight(bounds);
	
	glViewport(x, y, w, h); // Map OpenGL projection plane to NSWindow

	GLdouble fieldOfViewDegrees = 40; // Measured vertically (y-axis)
	GLdouble fieldOfViewRadians = fieldOfViewDegrees * (M_PI / 180.0);

    GLdouble aspectRatio = NSWidth(bounds) / NSHeight(bounds);

	GLdouble zMin = 1;      // Near clipping plane; 0 < zMin < zMax
	GLdouble zMax = 10;     // Far clipping plane;  0 < zMin < zMax
	
	GLdouble yMax = zMin * tan(fieldOfViewRadians/2.0);
	GLdouble yMin = -yMax;
	
	GLdouble xMax = aspectRatio * yMax;
	GLdouble xMin = aspectRatio * yMin;
	
	glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
		
	glFrustum(
		xMin,  // left, near clipping plane
		xMax,  // right, near clipping plane
		yMin,  // bottom, near clipping plane
		yMax,  // top, near clipping plane
		zMin,  // distance to near clipping plane
		zMax); // distance to far clipping plane

}

-(void) drawRect: (NSRect) bounds
{
	[self activateContext];
	
	// glClearColor(0, 0, 0, 0);
    // glClearColor(0.8, 0.8, 0.8, 0);
    // glClearColor(0.98, 0.98, 0.98, 0);
    glClearColor(1, 1, 1, 0);

    glClear(GL_COLOR_BUFFER_BIT);
    drawAnObject();

	[self flushContext];
	
}

@end
