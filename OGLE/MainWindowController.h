#import <Cocoa/Cocoa.h>
#import "GraphicView.h"

@interface MainWindowController : NSObject {

    IBOutlet GraphicView* _graphicView;
    IBOutlet NSPanel* _statisticsView;

    IBOutlet id _cameraModelArrayController;
    IBOutlet id _geometricModelArrayController;
    IBOutlet id _shadeModelArrayController;
    
    NSMutableArray* _cameraModelArray;
	NSMutableArray* _geometricModelArray;
    NSMutableArray* _shadeModelArray;

    NSTimer* _statisticsTimer;
    
    BOOL _statisticsVisible;
}


- (id) init;
- (void) dealloc;

- (void) awakeFromNib;

- (void) cameraModelChanged: (id) sender;
- (void) geometricModelChanged: (id) sender;
- (void) shadeModelChanged: (id) sender;

- (unsigned int) countOfCameraProjections;
- (id) objectInCameraProjectionsAtIndex: (unsigned int)index;
- (void) insertObject: (id)anObject inCameraProjectionsAtIndex: (unsigned int)index;
- (void) removeObjectFromCameraProjectionsAtIndex: (unsigned int)index;
- (void) replaceObjectInCameraProjectionsAtIndex: (unsigned int)index withObject: (id)anObject;

- (unsigned int)countOfGeometricModels;
- (id)objectInGeometricModelsAtIndex:(unsigned int)index;
- (void)insertObject:(id)anObject inGeometricModelsAtIndex:(unsigned int)index;
- (void)removeObjectFromGeometricModelsAtIndex:(unsigned int)index;
- (void)replaceObjectInGeometricModelsAtIndex:(unsigned int)index withObject:(id)anObject;

- (unsigned int) countOfShadeModels;
- (id) objectInShadeModelsAtIndex: (unsigned int)index;
- (void) insertObject: (id)anObject inShadeModelsAtIndex: (unsigned int)index;
- (void) removeObjectFromShadeModelsAtIndex: (unsigned int)index;
- (void) replaceObjectInShadeModelsAtIndex: (unsigned int)index withObject: (id)anObject;

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
