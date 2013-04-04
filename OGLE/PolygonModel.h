#import <Cocoa/Cocoa.h>


@interface PolygonModel : NSObject 
{
    GLenum _value;
    NSString* _description;
}

+ (id) createFill;
+ (id) createLine;

+ (id) createValue: (GLenum) value description: (NSString*) description;

- (id) initValue: (GLenum) value description: (NSString*) description;
- (void) dealloc;

- (GLenum) value;
- (NSString*) description;


@end
