#import <Cocoa/Cocoa.h>
#import "CameraModel.h"

@interface CameraModelPerspective : CameraModel
{

}

+ (id) create;

- (NSString*) description;

- (void) applyProjection: (NSRect) bounds;

@end
