#import "GraphicView.h"

#include <OpenGL/gl.h>

//
// The following allows pinch-to-zoom on 10.5.x even though the magnification
// message of NSEvent wasn't officially supported until 10.6.
//
@interface NSEvent(GestureEvents)
- (CGFloat)magnification; // Extant since 10.5.2, official support since 10.6
@end 


@implementation GraphicView

- (GLenum) shadeModel 
{
    return _shadeModel;
}

- (void) setShadeModel: (GLenum) newValue 
{
    _shadeModel = newValue;
    [self setNeedsDisplay:YES];
}

- (GeometricModel*) geometricModel
{
    return _geometricModel;
}

- (void) setGeometricModel: (GeometricModel*) geometricModel
{
    [_geometricModel autorelease];
    _geometricModel = [geometricModel retain];
    [self setNeedsDisplay:YES];
}

- (CameraModel*) cameraModel
{
    return _cameraModel;
}

- (void) setCameraModel: (CameraModel*) cameraModel
{
    [_cameraModel autorelease];
    _cameraModel = [cameraModel retain];
    [self reshape];
    [self setNeedsDisplay:YES];
}

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
    [self setShadeModel:GL_FLAT];
}

static void drawAxes(bool flags)
{
    glMatrixMode(GL_MODELVIEW);
    
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
	
	GLint x = NSMinX(bounds);
	GLint y = NSMinY(bounds);
	GLsizei w = NSWidth(bounds);
	GLsizei h = NSHeight(bounds);
	
	glViewport(x, y, w, h); // Map OpenGL projection plane to NSWindow

    [[self cameraModel] applyProjection:bounds];
    
    /*
	GLdouble fieldOfViewDegrees = 40; // Measured vertically (y-axis)
	GLdouble fieldOfViewRadians = fieldOfViewDegrees * (M_PI / 180.0);

    GLdouble aspectRatio = NSWidth(bounds) / NSHeight(bounds);

	GLdouble zMin = 1;      // Near clipping plane; 0 < zMin < zMax
	GLdouble zMax = 500;    // Far clipping plane;  0 < zMin < zMax
	
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
     */

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
    
    glShadeModel([self shadeModel]);
    
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
    
    drawAxes(false);
    
    [[self geometricModel] render];

	[self flushContext];
	
}

- (BOOL) acceptsFirstResponder
{
    return YES;
}

- (GLdouble) modelViewMatrix: (int)index
{
    GLdouble matrix[] = 
    {
        1, 0, 0, 0,
        0, 1, 0, 0,
        0, 0, 1, 0,
        0, 0, 0, 1,        
    };
    
    [self activateContext];
    
    glGetDoublev(GL_MODELVIEW_MATRIX, matrix);
    
    return matrix[index];
}

- (GLdouble) projectionMatrix: (int)index
{
    GLdouble matrix[] = 
    {
        1, 0, 0, 0,
        0, 1, 0, 0,
        0, 0, 1, 0,
        0, 0, 0, 1,        
    };
    
    [self activateContext];
    
    glGetDoublev(GL_PROJECTION_MATRIX, matrix);
    
    return matrix[index];
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
    NSLog(@"[GraphicView rotateDeltaTheta:] angle=%lf degrees", angleDegrees);
    
    if (angleDegrees == 0)
        return;
    
    GLdouble angle = angleDegrees;
    
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

- (void) zoomFactor: (GLdouble) factor
{
    NSLog(@"[GraphicView zoomFactor:] factor=%lf", factor);

    if (factor == 1)
        return;
    
    //
    // OpenGL uses the column vector convention with column-major memory layout:
    //    
    //    [ 1 0 0 x ]    [  0  4  8  12 ]
    //    [ 0 1 0 y ]    [  1  5  9  13 ]
    //    [ 0 0 1 z ]    [  2  6  10 14 ]
    //    [ 0 0 0 1 ]    [  3  7  11 15 ]
    //
    
    GLdouble matrix[] = 
    {
        1, 0, 0, 0,
        0, 1, 0, 0,
        0, 0, 1, 0,
        0, 0, 0, 1,        
    };
    
    [self activateContext];
    
    glGetDoublev(GL_MODELVIEW_MATRIX, matrix);

    // Invert the scale factor before applying it to the z-axis displacement
    // component of the matrix, so that a 'smaller scale' creates a larger
    // displacement from the camera.
    
    matrix[14] *= (1.0 / factor);

    // FIXME - Inappropriate hard-coded value used to prevent zooming in
    //         'too far'.
    
    if (matrix[14] > -1.5)
        matrix[14] = -1.5;

    glMatrixMode(GL_MODELVIEW);
    glLoadMatrixd(matrix);
    
    [self setNeedsDisplay:YES];
    
}

- (void) keyDown: (NSEvent*) event
{
    if ([[event characters] compare:@"r"] == NSOrderedSame)
        [self resetModelView];
}

- (void) mouseDown: (NSEvent*) event 
{    
    // NSLog(@"[GraphicView mouseDown:%@]", event);
}

- (void) mouseUp: (NSEvent*) event
{    
    // NSLog(@"[GraphicView mouseUp:%@]", event);
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
    CGFloat magnification = [event magnification];
    GLdouble factor = exp(magnification);
    
    // NSLog(@"[GraphicView magnifyWithEvent:%@] magnification=%lf, factor=%lf", event, magnification, factor);
    
    [self zoomFactor:factor];
}

- (void) rotateWithEvent: (NSEvent*) event 
{    
    // NSLog(@"[GraphicView rotateWithEvent:%@", event);

    GLdouble angleDegrees = [event rotation];
    
    [self rotateDeltaTheta:angleDegrees];
    
}

- (void) swipeWithEvent: (NSEvent*)event 
{
    // NSLog(@"[GraphicView swipeWithEvent:%@", event);
  
    // Unfortunately, Swipe Events report a delta X of +/- 1.0.
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
