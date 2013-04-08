#import <Cocoa/Cocoa.h>
#import "GeometricModel.h"

// GeometricModelCone renders a cone using OpenGL APIs.

@interface GeometricModelCone : GeometricModel 
{

}

+ (id) create;

- (id) init;
- (void) dealloc;

- (NSString*) description;  // Get user-friendly name

- (void) render: (GLenum) polygonMode // Render using OpenGL
          color: (Color*) color;

@end
