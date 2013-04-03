#import <Cocoa/Cocoa.h>


@interface ShadeModel : NSObject {

    GLenum _value;
    NSString* _description;
    
}

+ (id) createFlat;
+ (id) createSmooth;

+ (id) createValue: (GLenum) value description: (NSString*) description;

- (id) initValue: (GLenum) value description: (NSString*) description;
- (void) dealloc;

- (GLenum) value;
- (NSString*) description;

@end
