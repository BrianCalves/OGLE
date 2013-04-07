#import <Cocoa/Cocoa.h>

// GeometricModels render geometry using OpenGL APIs.

@interface GeometricModel : NSObject 
{
}

- (NSString*) description;  // Get user-friendly name

- (void) render: (GLenum) polygonMode // Render using OpenGL
          color: (NSColor*) color;


@end
