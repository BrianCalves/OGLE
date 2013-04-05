#import <Cocoa/Cocoa.h>
#import "CameraModel.h"
#import "GeometricModel.h"

@interface GraphicView : NSOpenGLView {

    CameraModel* _cameraModel;    
    GeometricModel* _geometricModel;
    NSColor* _backgroundColor;
    NSColor* _geometryAmbientColor;
    GLenum _polygonModel;
    GLenum _shadeModel;
    
}

- (GLdouble) modelViewMatrix: (int)index;
- (GLdouble) projectionMatrix: (int)index;

- (void) drawRect: (NSRect) bounds;

- (GLenum) polygonModel;
- (void) setPolygonModel: (GLenum) newValue;

- (GLenum) shadeModel;
- (void) setShadeModel: (GLenum) newValue;

- (GeometricModel*) geometricModel;
- (void) setGeometricModel: (GeometricModel*) geometricModel;

- (CameraModel*) cameraModel;
- (void) setCameraModel: (CameraModel*) cameraModel;

- (NSColor*) backgroundColor;
- (void) setBackgroundColor: (NSColor*) color;

- (NSColor*) geometryAmbientColor;
- (void) setGeometryAmbientColor: (NSColor*) color;

- (void) resetModelView;
- (void) zoomIn;
- (void) zoomOut;

@end
