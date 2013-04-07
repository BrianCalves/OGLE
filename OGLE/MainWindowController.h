#import <Cocoa/Cocoa.h>
#import "GraphicView.h"

// MainWindowController intermediates between GUI and OpenGL scene.

@interface MainWindowController : NSObject
{
    IBOutlet id _resetViewpointToolbarItem;
    
    IBOutlet GraphicView* _graphicView; // Subclass of NSOpenGLView
    IBOutlet NSPanel* _statisticsView; // Provides view of OpenGL matrices

    IBOutlet id _cameraModelArrayController; // Intermediary with NSPopUpButton
    IBOutlet id _geometricModelArrayController; // Intermediary with NSPopUpBut
    IBOutlet id _polygonModelArrayController; // Intermediary with NSPopUpButton
    IBOutlet id _shadeModelArrayController; // Intermediary with NSPopUpButton
    
    NSMutableArray* _cameraModelArray; // Available OpenGL projection models
	NSMutableArray* _geometricModelArray; // Available OpenGL geometry models
    NSMutableArray* _polygonModelArray; // Available OpenGL polygon draw models
    NSMutableArray* _shadeModelArray; // Available OpenGL shade models

    NSTimer* _statisticsTimer; // To update the scene statistics occasionally
    NSColor* _backgroundColor; // To specify the OpenGL clear color
    NSColor* _geometryAmbientColor; // To specify OpenGL material properties
    BOOL _luminaireGeometryVisible; // To reveal direction of OpenGL light
    
    BOOL _statisticsVisible; // Whether the statistics panel is on screen
}


- (id) init;
- (void) dealloc;

- (void) awakeFromNib;

- (void) cameraModelChanged: (id) sender; // Notifies GraphicView
- (void) geometricModelChanged: (id) sender;  // Notifies GraphicView
- (void) polygonModelChanged: (id) sender; // Notifies GraphicView
- (void) shadeModelChanged: (id) sender; // Notifies GraphicView
- (void) backgroundColorChanged: (id) sender; // Notifies GraphicView
- (void) geometryAmbientColorChanged: (id) sender; // Notifies GraphicView
- (void) luminaireGeometryVisibleChanged: (id) sender; // Notifies GraphicView

- (void) resetViewpoint: (id) sender; // Delegates to GraphicView
- (void) zoomIn: (id) sender; // Delegates to GraphicView
- (void) zoomOut: (id) sender; // Delegates to GraphicView

- (NSColor*) backgroundColor; // Intermediary with GraphicView
- (void) setBackgroundColor: (NSColor*) color;

- (NSColor*) geometryAmbientColor; // Intermediate with GraphicView
- (void) setGeometryAmbientColor: (NSColor*) color;

- (BOOL) luminaireGeometryVisible; // Intermediate with GraphicView
- (void) setLuminaireGeometryVisible: (BOOL) visible;

- (unsigned int) countOfCameraProjections; // KVC for NSArrayController Content
- (id) objectInCameraProjectionsAtIndex: (unsigned int)index;
- (void) insertObject: (id)anObject inCameraProjectionsAtIndex: (unsigned int)index;
- (void) removeObjectFromCameraProjectionsAtIndex: (unsigned int)index;
- (void) replaceObjectInCameraProjectionsAtIndex: (unsigned int)index withObject: (id)anObject;

- (unsigned int)countOfGeometricModels; // KVC for NSArrayController Content
- (id)objectInGeometricModelsAtIndex:(unsigned int)index;
- (void)insertObject:(id)anObject inGeometricModelsAtIndex:(unsigned int)index;
- (void)removeObjectFromGeometricModelsAtIndex:(unsigned int)index;
- (void)replaceObjectInGeometricModelsAtIndex:(unsigned int)index withObject:(id)anObject;

- (unsigned int) countOfPolygonModels; // KVC for NSArrayController Content
- (id) objectInPolygonModelsAtIndex: (unsigned int)index;
- (void) insertObject: (id)anObject inPolygonModelsAtIndex: (unsigned int)index;
- (void) removeObjectFromPolygonModelsAtIndex: (unsigned int)index;
- (void) replaceObjectInPolygonModelsAtIndex: (unsigned int)index withObject: (id)anObject;

- (unsigned int) countOfShadeModels; // KVC for NSArrayController Content
- (id) objectInShadeModelsAtIndex: (unsigned int)index;
- (void) insertObject: (id)anObject inShadeModelsAtIndex: (unsigned int)index;
- (void) removeObjectFromShadeModelsAtIndex: (unsigned int)index;
- (void) replaceObjectInShadeModelsAtIndex: (unsigned int)index withObject: (id)anObject;

- (BOOL) isStatisticsVisible; // KVC to synchronize Statistics Panel visibility
- (void) setStatisticsVisible: (BOOL) visible;

- (NSString*) modelViewMatrix: (int)index; // Delegate to GraphicView
- (NSString*) projectionMatrix: (int)index; // Delegate to GraphicView

- (NSString*) modelViewMatrix0; // KVC: intermediate Stat. Panel & GraphicView
- (NSString*) modelViewMatrix1; // KVC: intermediate Stat. Panel & GraphicView
- (NSString*) modelViewMatrix2; // KVC: intermediate Stat. Panel & GraphicView
- (NSString*) modelViewMatrix3; // KVC: intermediate Stat. Panel & GraphicView
- (NSString*) modelViewMatrix4; // KVC: intermediate Stat. Panel & GraphicView
- (NSString*) modelViewMatrix5; // KVC: intermediate Stat. Panel & GraphicView
- (NSString*) modelViewMatrix6; // KVC: intermediate Stat. Panel & GraphicView
- (NSString*) modelViewMatrix7; // KVC: intermediate Stat. Panel & GraphicView
- (NSString*) modelViewMatrix8; // KVC: intermediate Stat. Panel & GraphicView
- (NSString*) modelViewMatrix9; // KVC: intermediate Stat. Panel & GraphicView
- (NSString*) modelViewMatrix10; // KVC: intermediate Stat. Panel & GraphicView
- (NSString*) modelViewMatrix11; // KVC: intermediate Stat. Panel & GraphicView
- (NSString*) modelViewMatrix12; // KVC: intermediate Stat. Panel & GraphicView
- (NSString*) modelViewMatrix13; // KVC: intermediate Stat. Panel & GraphicView
- (NSString*) modelViewMatrix14; // KVC: intermediate Stat. Panel & GraphicView
- (NSString*) modelViewMatrix15; // KVC: intermediate Stat. Panel & GraphicView

- (NSString*) projectionMatrix0; // KVC: intermediate Stat. Panel & GraphicView
- (NSString*) projectionMatrix1; // KVC: intermediate Stat. Panel & GraphicView
- (NSString*) projectionMatrix2; // KVC: intermediate Stat. Panel & GraphicView
- (NSString*) projectionMatrix3; // KVC: intermediate Stat. Panel & GraphicView
- (NSString*) projectionMatrix4; // KVC: intermediate Stat. Panel & GraphicView
- (NSString*) projectionMatrix5; // KVC: intermediate Stat. Panel & GraphicView
- (NSString*) projectionMatrix6; // KVC: intermediate Stat. Panel & GraphicView
- (NSString*) projectionMatrix7; // KVC: intermediate Stat. Panel & GraphicView
- (NSString*) projectionMatrix8; // KVC: intermediate Stat. Panel & GraphicView
- (NSString*) projectionMatrix9; // KVC: intermediate Stat. Panel & GraphicView
- (NSString*) projectionMatrix10; // KVC: intermediate Stat. Panel & GraphicView
- (NSString*) projectionMatrix11; // KVC: intermediate Stat. Panel & GraphicView
- (NSString*) projectionMatrix12; // KVC: intermediate Stat. Panel & GraphicView
- (NSString*) projectionMatrix13; // KVC: intermediate Stat. Panel & GraphicView
- (NSString*) projectionMatrix14; // KVC: intermediate Stat. Panel & GraphicView
- (NSString*) projectionMatrix15; // KVC: intermediate Stat. Panel & GraphicView

@end
