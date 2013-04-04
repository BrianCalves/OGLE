#import <Cocoa/Cocoa.h>
#import "GeometricModel.h"

@interface GeometricModelSphere : GeometricModel 
{

}

+ (id) create;

- (id) init;
- (void) dealloc;

- (NSString*) description;

- (void) render: (GLenum) polygonMode
          color: (NSColor*) color;

@end
