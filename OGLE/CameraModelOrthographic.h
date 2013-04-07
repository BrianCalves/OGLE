#import <Cocoa/Cocoa.h>
#import "CameraModel.h"

// CameraModelOrthographic provides an orthographic OpenGL projection matrix.

@interface CameraModelOrthographic : CameraModel
{

}

+ (id) create;

- (NSString*) description; // Get user-friendly name

- (void) applyProjection: (NSRect) bounds; // Set OpenGL projection

@end
