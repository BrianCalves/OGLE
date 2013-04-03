#import "CameraModelOrthographic.h"


@implementation CameraModelOrthographic

+ (id) create
{
    return [[[CameraModelOrthographic alloc] init] autorelease];
}

- (NSString*) description
{
    return @"Orthographic";
}

- (void) applyProjection: (NSRect) bounds
{
    GLdouble fieldOfViewDegrees = 40; // Measured vertically (y-axis)
	GLdouble fieldOfViewRadians = fieldOfViewDegrees * (M_PI / 180.0);
    
    GLdouble aspectRatio = NSWidth(bounds) / NSHeight(bounds);
    
    // FIXME - Inappropriate hard-coded values: zMin, zMax
    //         Perhaps these could be scene/model dependent?
    
	GLdouble zMin = 1;      // Near clipping plane; 0 < zMin < zMax
	GLdouble zMax = 500;    // Far clipping plane;  0 < zMin < zMax
	
	GLdouble yMax = zMin * tan(fieldOfViewRadians/2.0);
	GLdouble yMin = -yMax;
	
	GLdouble xMax = aspectRatio * yMax;
	GLdouble xMin = aspectRatio * yMin;
	
	glMatrixMode(GL_PROJECTION);
    glLoadIdentity();    
	glOrtho(
            xMin,  // left, near clipping plane
            xMax,  // right, near clipping plane
            yMin,  // bottom, near clipping plane
            yMax,  // top, near clipping plane
            zMin,  // distance to near clipping plane
            zMax); // distance to far clipping plane
}

@end
