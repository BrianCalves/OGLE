#import <Cocoa/Cocoa.h>
#import "GeometricModel.h"

// GeometricModelSphere renders a sphere using OpenGL APIs.

@interface GeometricModelSphere : GeometricModel 
{
    double _radius;
}

+ (id) create;
+ (id) createRadius: (double) radius;

- (id) init;
- (id) initRadius: (double) radius;
- (void) dealloc;

- (double) radius; // Get radius of sphere in world coordinates

- (NSString*) description;  // Get user-friendly name

- (void) render: (GLenum) polygonMode // Render using OpenGL
          color: (Color*) color;


@end
