#import <Cocoa/Cocoa.h>
#import "GeometricModel.h"

@interface GeometricModelCube : GeometricModel
{

}

+ (id) create;

- (id) init;
- (void) dealloc;

- (NSString*) description;

- (void) render: (GLenum) polygonMode;

@end
