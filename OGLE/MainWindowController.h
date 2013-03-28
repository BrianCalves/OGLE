#import <Cocoa/Cocoa.h>

@interface MainWindowController : NSObject {

    IBOutlet id projectionArrayController;
    IBOutlet id graphicView;

	NSMutableArray* _projectionArray;

}


- (id) init;
- (void) dealloc;

- (void) projectionChanged: (id) sender;

- (unsigned int)countOfProjections;
- (id)objectInProjectionsAtIndex:(unsigned int)index;
- (void)insertObject:(id)anObject inProjectionsAtIndex:(unsigned int)index;
- (void)removeObjectFromProjectionsAtIndex:(unsigned int)index;
- (void)replaceObjectInProjectionsAtIndex:(unsigned int)index withObject:(id)anObject;

@end
