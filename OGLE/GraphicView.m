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

- (void) resetModelView
{
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    glTranslated(0.0, 0.0, -2.5);
    glRotated(-90.0, 1.0, 0.0, 0.0);
    glRotated(-90.0, 0.0, 0.0, 1.0);
    glRotated(  5.0, 0.0, 1.0, 0.0);
    glRotated( -5.0, 0.0, 0.0, 1.0);        
    
    [self setNeedsDisplay:YES];
}

- (void) prepareOpenGL
{
    [self resetModelView];
}

static void drawAxes(bool flags)
{
    glBegin(GL_LINES);
    {
        GLfloat xAmbientReflection[] = { 1, 0, 0, 1.0 };
        glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, xAmbientReflection);
        glColor3f(1.0f, 0.0f, 0.0f);
        glVertex3f( 0.0,  0.0,  0.0);
        glVertex3f( 1.0,  0.0,  0.0);
        
        GLfloat yAmbientReflection[] = { 0, 1, 0, 1.0 };
        glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, yAmbientReflection);
        glColor3f(0.0f, 1.0f, 0.0f);
        glVertex3f( 0.0,  0.0,  0.0);
        glVertex3f( 0.0,  1.0,  0.0);

        GLfloat zAmbientReflection[] = { 0, 0, 1, 1.0 };
        glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, zAmbientReflection);
        glColor3f(0.0f, 0.0f, 1.0f);
        glVertex3f( 0.0,  0.0,  0.0);
        glVertex3f( 0.0,  0.0,  1.0);
    }
    glEnd();
 
    if (flags)
    {
        glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);        
        
        GLfloat flagAmbientReflection[] = { 1.0f, 0.85f, 0.35f, 1.0 };
        glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, flagAmbientReflection);
        glColor3f(1.0f, 0.85f, 0.35f);

        // X-Z plane    
        glBegin(GL_TRIANGLES);
        {
            glVertex3f(  0.0,  1.0,  0.1);
            glVertex3f( -0.1,  1.0, -0.1);
            glVertex3f(  0.1,  1.0, -0.1);
        }
        glEnd();
        
        // X-Y plane    
        glBegin(GL_TRIANGLES);
        {
            glVertex3f(  0.0,  0.1,  1.0);
            glVertex3f( -0.1, -0.1,  1.0);
            glVertex3f(  0.1, -0.1,  1.0);
        }
        glEnd();
        
        // Y-Z plane    
        glBegin(GL_TRIANGLES);
        {
            glVertex3f(  1.0,  0.0,  0.1);
            glVertex3f(  1.0, -0.1, -0.1);
            glVertex3f(  1.0,  0.1, -0.1);
        }
        glEnd();
    }
    
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
//    glOrtho(
		xMin,  // left, near clipping plane
		xMax,  // right, near clipping plane
		yMin,  // bottom, near clipping plane
		yMax,  // top, near clipping plane
		zMin,  // distance to near clipping plane
		zMax); // distance to far clipping plane

}

//#define assertLessEqual(a, b) ((void) ((a <= b) ? 0 : __assert (#e, __FILE__, __LINE__)))
#define assertLessEqual(a, b) ((void) ((a <= b) ? 0 : ((void)printf ("%s:%u: function %s expected %s <= %s (%lf <= %lf)\n", __FILE__, __LINE__, __PRETTY_FUNCTION__, #a, #b, a, b), abort()) ))

//((void)printf ("%s:%u: failed assertion `%s'\n", file, line, e), abort())


static void degreesLLA(double lat, double lon, double alt)
{
    // pre:  -90 <= latitudeDegrees  <=  90
    // pre: -180 <= longitudeDegrees <= 180

    assert(lat >= -90.0);
    assert(lat <=  90.0);    
    assert(lon >= -180.0);
    assert(lon <=  180.0);
    
//    lat = (lat +  90.0) * (M_PI / 180.0);
//    lon = (lon + 180.0) * (M_PI / 180.0);
    
    lat = (lat +  0.0) * (M_PI / 180.0);
    lon = (lon +  0.0) * (M_PI / 180.0);
    
//    assert(lat >= 0.0);
//    assertLessEqual(lat, M_PI);
//    assert(lat <= M_PI);
//    assert(lon >= 0.0);
//    assert(lon <= (2.0 * M_PI));
    
    // r > 0
    // lat e [0, pi]
    // lon e [0, 2pi]
    
    double r = .5;

    //    double x = (r + alt) * sin(lat) * cos(lon);
    //    double y = (r + alt) * sin(lat) * sin(lon);
    //    double z = (r + alt) * cos(lat);
    
    double x = (r + alt) * cos(lat) * cos(lon);
    double y = (r + alt) * cos(lat) * sin(lon);
    double z = (r + alt) * sin(lat);

    double len = sqrt(x*x + y*y + z*z);
    
    double t = x / len;
    double u = y / len;
    double v = z / len;
    
    glNormal3d(t, u, v);
    glVertex3d(x, y, z);
}


static void drawEarth()
{
	glMatrixMode(GL_MODELVIEW);
    /*
	glLoadIdentity();
	glTranslated(0.0, 0.0, -2.0);
    glRotated(-90.0, 1.0, 0.0, 0.0);
    glRotated(-90.0, 0.0, 0.0, 1.0);
    glRotated(  5.0, 0.0, 1.0, 0.0);
    glRotated( -5.0, 0.0, 0.0, 1.0);
     */
    
    drawAxes(false);

//    glEnable(GL_CULL_FACE);
//    glCullFace(GL_BACK);
    glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);

    GLfloat ambientReflection[] = { 0.5, 0.5, 0.5, 1.0 };
    GLfloat specularReflection[] = { 0.5, 0.5, 0.5, 1.0 };
        
    glColor4f(0.5, 0.5, 0.5, 1);
    glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, ambientReflection);
    glMaterialfv(GL_FRONT, GL_SPECULAR, specularReflection);
    glBegin(GL_QUADS);
    {    
        int n = 10;
        for (int lat=-90; lat<90; lat+=n)
        {
            for (int lon=-180; lon<180; lon+=n)
            {
                degreesLLA( n+lat,   lon, 0);
                degreesLLA(   lat,   lon, 0);
                degreesLLA(   lat, n+lon, 0);
                degreesLLA( n+lat, n+lon, 0);
            }            
        }
        
    }    
    glEnd();
    glDisable(GL_CULL_FACE);

    GLfloat equatorialPlaneAmbientReflection[] = { 0.8, 0.8, 0.8, 0.5 };
    
    glDepthMask(GL_FALSE);
    glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
    glColor4f(0.9f, 0.9f, 0.9f, 0.5f);
    glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, equatorialPlaneAmbientReflection);
    glMaterialfv(GL_BACK, GL_AMBIENT_AND_DIFFUSE, equatorialPlaneAmbientReflection);
    glBegin(GL_QUADS);
    {
        glVertex3f(-1.0,  1.0,  0.0);
        glVertex3f(-1.0, -1.0,  0.0);
        glVertex3f( 1.0, -1.0,  0.0);
        glVertex3f( 1.0,  1.0,  0.0);
    }
    glEnd();
    glDepthMask(GL_TRUE);
    
}

-(void) drawRect: (NSRect) bounds
{
	[self activateContext];

    GLfloat ambientLight[] = { 0.4, 0.4, 0.4, 1.0 };
    GLfloat lightPosition0[] = { 2.0, 2.0, 2.0, 0.0 };
    GLfloat lightAmbient0[] = { 0.2, 0.2, 0.2, 1.0 };
    GLfloat lightDiffuse0[] = { 0.6, 0.6, 0.6, 1.0 };
    GLfloat lightSpecular0[] = { 0.2, 0.2, 0.2, 1.0 };
        
        
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glCullFace(GL_BACK);
    glLightModelfv(GL_LIGHT_MODEL_AMBIENT, ambientLight);
    
    glLightfv(GL_LIGHT0, GL_POSITION, lightPosition0);
    glLightfv(GL_LIGHT0, GL_AMBIENT, lightAmbient0);
    glLightfv(GL_LIGHT0, GL_DIFFUSE, lightDiffuse0);
    glLightfv(GL_LIGHT0, GL_SPECULAR, lightSpecular0);
    
    glShadeModel(GL_FLAT);
    
    glEnable(GL_BLEND);
    glEnable(GL_CULL_FACE);
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_LIGHTING);
    glEnable(GL_LIGHT0);
	
	// glClearColor(0, 0, 0, 0);
    // glClearColor(0.8, 0.8, 0.8, 0);
    // glClearColor(0.98, 0.98, 0.98, 0);
    glClearColor(1, 1, 1, 0);

    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    drawEarth();

	[self flushContext];
	
}

- (BOOL) acceptsFirstResponder
{
    return YES;
}

- (void) rotateDeltaX: (GLdouble) dx
               deltaY: (GLdouble) dy
{
    GLdouble length = sqrt(dx*dx + dy*dy);
    GLdouble angle = length;
    
    GLdouble vx = dx/length;
    GLdouble vy = dy/length;    
    
    NSLog(@"[GraphicView rotateDeltaX:deltaY:] dx=%lf, dy=%lf, vx=%lf, vy=%lf, angle=%lf", dx, dy, vx, vy, angle);
    
    if (isnan(vx) ||
        isnan(vy))
        return;
    
    GLdouble modelViewMatrix[] = 
    {
        1, 0, 0, 0,
        0, 1, 0, 0,
        0, 0, 1, 0,
        0, 0, 0, 1,        
    };
    
    [self activateContext];
    
    glGetDoublev(GL_MODELVIEW_MATRIX, modelViewMatrix);
    
    //
    // OpenGL uses the column vector convention with column-major memory layout:
    //    
    //    [ 1 0 0 x ]    [  0  4  8  12 ]
    //    [ 0 1 0 y ]    [  1  5  9  13 ]
    //    [ 0 0 1 z ]    [  2  6  10 14 ]
    //    [ 0 0 0 1 ]    [  3  7  11 15 ]
    //
    
    glMatrixMode(GL_MODELVIEW);
    glRotated(angle,
              vx * modelViewMatrix[1] + vy * modelViewMatrix[0],
              vx * modelViewMatrix[5] + vy * modelViewMatrix[4],
              vx * modelViewMatrix[9] + vy * modelViewMatrix[8]);
    
    [self setNeedsDisplay:YES];
}

- (void) rotateDeltaTheta: (GLdouble) angleDegrees
{
    if (angleDegrees == 0)
        return;
    
    GLdouble angle = angleDegrees;
    
    NSLog(@"[GraphicView rotateDeltaTheta:] angle=%lf", angle);
    
    GLdouble m[] = 
    {
        1, 0, 0, 0,
        0, 1, 0, 0,
        0, 0, 1, 0,
        0, 0, 0, 1,        
    };
    
    [self activateContext];
    
    glGetDoublev(GL_MODELVIEW_MATRIX, m);
    
    //
    // OpenGL uses the column vector convention with column-major memory layout:
    //    
    //    [ 1 0 0 x ]    [  0  4  8  12 ]
    //    [ 0 1 0 y ]    [  1  5  9  13 ]
    //    [ 0 0 1 z ]    [  2  6  10 14 ]
    //    [ 0 0 0 1 ]    [  3  7  11 15 ]
    //
    
    glMatrixMode(GL_MODELVIEW);
    glRotated(angle, m[2], m[6], m[10]);
    
    [self setNeedsDisplay:YES];
}

- (void) keyDown: (NSEvent*) event
{
    if ([[event characters] compare:@"r"] == NSOrderedSame)
        [self resetModelView];
}

- (void) mouseDown: (NSEvent*) event 
{    
    NSLog(@"[GraphicView mouseDown:%@]", event);
}

- (void) mouseUp: (NSEvent*) event
{    
    NSLog(@"[GraphicView mouseUp:%@]", event);
}

- (void) mouseDragged: (NSEvent*) event 
{
 // NSLog(@"[GraphicView mouseDragged:%@]", event);
    
    GLdouble dx = [event deltaX];
    GLdouble dy = [event deltaY];
    
    [self rotateDeltaX:dx deltaY:dy];

}

- (void) magnifyWithEvent: (NSEvent*) event 
{
    NSLog(@"[GraphicView magnifyWithEvent:%@", event);
}

- (void) rotateWithEvent: (NSEvent*) event 
{
    
 // NSLog(@"[GraphicView rotateWithEvent:%@", event);

    GLdouble angleDegrees = [event rotation];
    
    [self rotateDeltaTheta:angleDegrees];
    
}

- (void) swipeWithEvent: (NSEvent*)event 
{
    NSLog(@"[GraphicView swipeWithEvent:%@", event);
  
    // Unfortunately, swiping events report a delta X of +/- 1.0.
    // This is not suitable for interactive panning, for example.
    // Mac OS X 10.5 and prior do not support the NSTouch API for gestures.
    
}

- (void) scrollWheel: (NSEvent*) event
{
    GLdouble dx = -[event deltaX];
    GLdouble dy = -[event deltaY];

    [self rotateDeltaX:dx deltaY:dy];
}

@end
