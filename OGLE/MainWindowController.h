#import <Cocoa/Cocoa.h>

@interface MainWindowController : NSObject {

    IBOutlet id earthModelArrayController;
    IBOutlet id graphicView;

	NSMutableArray* _earthModelArray;

}


- (id) init;
- (void) dealloc;

- (void) earthModelChanged: (id) sender;

- (unsigned int)countOfEarthModels;
- (id)objectInEarthModelsAtIndex:(unsigned int)index;
- (void)insertObject:(id)anObject inEarthModelsAtIndex:(unsigned int)index;
- (void)removeObjectFromEarthModelsAtIndex:(unsigned int)index;
- (void)replaceObjectInEarthModelsAtIndex:(unsigned int)index withObject:(id)anObject;

@end
