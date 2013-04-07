#import "CameraModelPerspective.h"


@implementation CameraModelPerspective

+ (id) create
{
    return [[[CameraModelPerspective alloc] init] autorelease];
}

- (NSString*) description
{
    return @"Perspective";
}

- (void) applyProjection: (NSRect) bounds
{
    GLdouble w = NSWidth(bounds);
    GLdouble h = NSHeight(bounds);
    
    GLdouble aspectRatio = w / h;
    
    GLdouble fieldOfViewDegrees = 40; // Measured vertically (y-axis)
	GLdouble fieldOfViewRadians = fieldOfViewDegrees * (M_PI / 180.0);
    
    // FIXME - Inappropriate hard-coded values: zMin, zMax
    //         These should probably be scene/geometry dependent?
    
	GLdouble zMin = 1;      // Near clipping plane; 0 < zMin < zMax
	GLdouble zMax = 500;    // Far clipping plane;  0 < zMin < zMax
	
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

@end
