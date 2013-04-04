#import <Cocoa/Cocoa.h>
#import "CameraModel.h"
#import "GeometricModel.h"

@interface GraphicView : NSOpenGLView {

    CameraModel* _cameraModel;    
    GeometricModel* _geometricModel;
    GLenum _shadeModel;
    
}

- (GLdouble) modelViewMatrix: (int)index;
- (GLdouble) projectionMatrix: (int)index;

- (void) drawRect: (NSRect) bounds;

- (GLenum) shadeModel;
- (void) setShadeModel: (GLenum) newValue;

- (GeometricModel*) geometricModel;
- (void) setGeometricModel: (GeometricModel*) geometricModel;

- (CameraModel*) cameraModel;
- (void) setCameraModel: (CameraModel*) cameraModel;

- (void) resetModelView;

@end
