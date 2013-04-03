#import <Cocoa/Cocoa.h>
#import "GeometricModel.h"

@interface GeometricModelSphere : GeometricModel 
{

}

+ (id) create;

- (id) init;
- (void) dealloc;

- (NSString*) description;

- (void) render;

@end
