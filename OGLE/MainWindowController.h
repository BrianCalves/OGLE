#import <Cocoa/Cocoa.h>
#import "GraphicView.h"

@interface MainWindowController : NSObject {

    IBOutlet GraphicView* graphicView;
    IBOutlet NSPanel* statisticsView;

    IBOutlet id projectionArrayController;
    IBOutlet id earthModelArrayController;

	NSMutableArray* _projectionArray;
	NSMutableArray* _earthModelArray;

    NSTimer* _statisticsTimer;
    
    BOOL _statisticsVisible;
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

- (BOOL) isStatisticsVisible;
- (void) setStatisticsVisible: (BOOL) visible;

- (NSString*) modelViewMatrix: (int)index;

- (NSString*) modelViewMatrix0;
- (NSString*) modelViewMatrix1;
- (NSString*) modelViewMatrix2;
- (NSString*) modelViewMatrix3;
- (NSString*) modelViewMatrix4;
- (NSString*) modelViewMatrix5;
- (NSString*) modelViewMatrix6;
- (NSString*) modelViewMatrix7;
- (NSString*) modelViewMatrix8;
- (NSString*) modelViewMatrix9;
- (NSString*) modelViewMatrix10;
- (NSString*) modelViewMatrix11;
- (NSString*) modelViewMatrix12;
- (NSString*) modelViewMatrix13;
- (NSString*) modelViewMatrix14;
- (NSString*) modelViewMatrix15;
- (NSString*) modelViewMatrix16;

@end
