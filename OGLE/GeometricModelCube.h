#import <Cocoa/Cocoa.h>
#import "GeometricModel.h"

// GeometricModelCube renders a cube using OpenGL APIs.

@interface GeometricModelCube : GeometricModel
{

}

+ (id) create;

- (id) init;
- (void) dealloc;

- (NSString*) description;  // Get user-friendly name

- (void) render: (GLenum) polygonMode // Render using OpenGL
          color: (NSColor*) color;

@end
