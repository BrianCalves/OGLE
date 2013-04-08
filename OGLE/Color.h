#import <Cocoa/Cocoa.h>

// Color simplifies the application of color to OpenGL.

@interface Color : NSObject 
{
    NSColor* _value;
}

+ (id) create;
+ (id) createColor: (NSColor*) color;
+ (id) createWhite: (GLfloat) w alpha: (GLfloat) a;
+ (id) createRed: (GLfloat) r green: (GLfloat) g blue: (GLfloat) b alpha: (GLfloat) a;
+ (id) white;
+ (id) black;
+ (id) red;
+ (id) green;
+ (id) blue;
+ (id) yellow;
+ (id) magenta;
+ (id) purple;

- (id) init;
- (id) initColor: (NSColor*) color;
- (void) dealloc;

- (NSColor*) value;

- (void) applyToBackground;
- (void) applyToColor;
- (void) applyToBack: (GLenum) material;
- (void) applyToFront: (GLenum) material;
- (void) applyToFaces: (GLenum) material;
- (void) applyToFace: (GLenum) face material: (GLenum) material;
- (void) applyToFace: (GLenum) face, ... /* material */; // Color & ...
- (void) apply: (GLenum) material, ... /* material */; // Color & both faces

@end
