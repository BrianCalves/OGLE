#import <Cocoa/Cocoa.h>
#import "GeometricModel.h"

@interface GeometricModelSphere : GeometricModel 
{
    double _radius;
}

+ (id) create;
+ (id) createRadius: (double) radius;

- (id) init;
- (id) initRadius: (double) radius;
- (void) dealloc;

- (double) radius;
- (NSString*) description;

- (void) render: (GLenum) polygonMode
          color: (NSColor*) color;

@end
