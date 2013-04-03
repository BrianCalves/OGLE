#import <Cocoa/Cocoa.h>
#import "CameraModel.h"

@interface CameraModelOrthographic : CameraModel
{

}

+ (id) create;

- (NSString*) description;

- (void) applyProjection: (NSRect) bounds;

@end
