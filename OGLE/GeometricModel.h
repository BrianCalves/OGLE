#import <Cocoa/Cocoa.h>

#define assertLessEqual(a, b) ((void) ((a <= b) ? 0 : ((void)printf ("%s:%u: function %s expected %s <= %s (%lf <= %lf)\n", __FILE__, __LINE__, __PRETTY_FUNCTION__, #a, #b, a, b), abort()) ))

@interface GeometricModel : NSObject 
{
}

- (void) render;
- (NSString*) description;

@end
