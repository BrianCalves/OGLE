#import <Cocoa/Cocoa.h>
#import "GeometricModel.h"

// GeometricModelAxes renders coordinate axes vectors using OpenGL APIs.

@interface GeometricModelAxes : GeometricModel 
{
    
}

+ (id) create;

- (id) init;
- (void) dealloc;

- (NSString*) description;  // Get user-friendly name

- (void) render: (GLenum) polygonMode // Render using OpenGL
          color: (Color*) color;

@end
