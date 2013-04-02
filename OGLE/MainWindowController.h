#import <Cocoa/Cocoa.h>
#import "GraphicView.h"

@interface MainWindowController : NSObject {

    IBOutlet GraphicView* _graphicView;
    IBOutlet NSPanel* _statisticsView;

    IBOutlet id _cameraProjectionArrayController;
    IBOutlet id _modelProjectionArrayController;
    IBOutlet id _earthModelArrayController;
    
    NSMutableArray* _cameraProjectionArray;
	NSMutableArray* _modelProjectionArray;
	NSMutableArray* _earthModelArray;

    NSTimer* _statisticsTimer;
    
    BOOL _statisticsVisible;
}


- (id) init;
- (void) dealloc;

- (void) cameraProjectionChanged: (id) sender;
- (void) modelProjectionChanged: (id) sender;
- (void) earthModelChanged: (id) sender;

- (unsigned int) countOfCameraProjections;
- (id) objectInCameraProjectionsAtIndex: (unsigned int)index;
- (void) insertObject: (id)anObject inCameraProjectionsAtIndex: (unsigned int)index;
- (void) removeObjectFromCameraProjectionsAtIndex: (unsigned int)index;
- (void) replaceObjectInCameraProjectionsAtIndex: (unsigned int)index withObject: (id)anObject;

- (unsigned int)countOfModelProjections;
- (id)objectInModelProjectionsAtIndex:(unsigned int)index;
- (void)insertObject:(id)anObject inModelProjectionsAtIndex:(unsigned int)index;
- (void)removeObjectFromModelProjectionsAtIndex:(unsigned int)index;
- (void)replaceObjectInModelProjectionsAtIndex:(unsigned int)index withObject:(id)anObject;

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
