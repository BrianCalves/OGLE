#import <Cocoa/Cocoa.h>

@interface MainWindowController : NSObject {

    IBOutlet id graphicView;

    IBOutlet id projectionArrayController;
    IBOutlet id earthModelArrayController;

	NSMutableArray* _projectionArray;
	NSMutableArray* _earthModelArray;

}


- (id) init;
- (void) dealloc;

- (void) projectionChanged: (id) sender;
- (void) earthModelChanged: (id) sender;

- (unsigned int)countOfProjections;
- (id)objectInProjectionsAtIndex:(unsigned int)index;
- (void)insertObject:(id)anObject inProjectionsAtIndex:(unsigned int)index;
- (void)removeObjectFromProjectionsAtIndex:(unsigned int)index;
- (void)replaceObjectInProjectionsAtIndex:(unsigned int)index withObject:(id)anObject;

- (unsigned int)countOfEarthModels;
- (id)objectInEarthModelsAtIndex:(unsigned int)index;
- (void)insertObject:(id)anObject inEarthModelsAtIndex:(unsigned int)index;
- (void)removeObjectFromEarthModelsAtIndex:(unsigned int)index;
- (void)replaceObjectInEarthModelsAtIndex:(unsigned int)index withObject:(id)anObject;

@end
