#import <Cocoa/Cocoa.h>
#import "CameraModel.h"

// CameraModelPerspective provides a perspective OpenGL projection matrix.

@interface CameraModelPerspective : CameraModel
{

}

+ (id) create;

- (NSString*) description; // Get user-friendly name

- (void) applyProjection: (NSRect) bounds; // Set OpenGL projection

@end
