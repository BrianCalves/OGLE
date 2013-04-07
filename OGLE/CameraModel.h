#import <Cocoa/Cocoa.h>

// CameraModels calculate OpenGL projection matrices. This is a superclass.

@interface CameraModel : NSObject
{
    
}

- (NSString*) description; // Get user-friendly name

- (void) applyProjection: (NSRect) bounds; // Set OpenGL projection

@end
