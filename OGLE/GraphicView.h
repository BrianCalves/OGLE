#import <Cocoa/Cocoa.h>
#import "GeometricModel.h"

@interface GraphicView : NSOpenGLView {

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

@end
