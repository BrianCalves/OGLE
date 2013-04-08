#import <Cocoa/Cocoa.h>
#import "GeometricModel.h"

// GeometricModelVector renders a vector using OpenGL APIs.

@interface GeometricModelVector : GeometricModel 
{
    GLdouble _from[3];
    GLdouble _to[3];
}

+ (id) createFrom: (GLdouble*) a to: (GLdouble*) b;

- (id) initFrom: (GLdouble*) a to: (GLdouble*) b;
- (void) dealloc;

- (NSString*) description;  // Get user-friendly name

- (void) render: (GLenum) polygonMode // Render using OpenGL
          color: (Color*) color;

@end
