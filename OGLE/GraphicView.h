#import <Cocoa/Cocoa.h>
#import "CameraModel.h"
#import "Color.h"
#import "GeometricModel.h"

// GraphicView overrides NSOpenGLView drawRect: in order to render a scene.
// GraphicView provides state and behavior to facilitate scene rendering.
// GraphicView manipulates viewpoint according to mouse, trackpad, or keyboard.
// In this application, GraphicView is regulated by MainWindowController.

@interface GraphicView : NSOpenGLView 
{
    CameraModel* _cameraModel;    
    GeometricModel* _geometricModel;
    GeometricModel* _axesModel;
    GeometricModel* _directionModel; // Luminaire direction vector
    Color* _backgroundColor;
    Color* _geometryColor;
    GLenum _polygonModel;
    GLenum _shadeModel;
    BOOL _luminaireGeometryVisible;
}

- (void) prepareOpenGL;

- (void) activateContext; // Make the associated OpenGL context current
- (void) flushContext; // Force execution of buffered OpenGL commands

- (void) clear;

- (void) drawRect: (NSRect) bounds; // Render the scene
- (void) reshape; // Adjust the OpenGL viewport in response to window resize

- (GLdouble) modelViewMatrix: (int)index; // Access matrix; column-major order
- (GLdouble) projectionMatrix: (int)index; // Access matrix; column-major order

- (GLenum) polygonModel; // Corresponds to glPolygonMode(), GL_FILL, GL_LINE
- (void) setPolygonModel: (GLenum) newValue;

- (GLenum) shadeModel; // Corresponds to glShadeModel(), GL_FLAT, GL_SMOOTH
- (void) setShadeModel: (GLenum) newValue;

- (GeometricModel*) geometricModel; // Something to render
- (void) setGeometricModel: (GeometricModel*) geometricModel;

- (GeometricModel*) axesModel; // Visualization of coordinate axes
- (void) setAxesModel: (GeometricModel*) axesModel;

- (GeometricModel*) directionModel; // Visualization of light direction
- (void) setDirectionModel: (GeometricModel*) directionModel;

- (CameraModel*) cameraModel; // Defines projection matrix (glFrustum/glOrtho)
- (void) setCameraModel: (CameraModel*) cameraModel;

- (Color*) backgroundColor; // Corresponds to glClearColor()
- (void) setBackgroundColor: (Color*) color;

- (Color*) geometryColor; // Used to specify glMaterial()
- (void) setGeometryColor: (Color*) color;

- (BOOL) luminaireGeometryVisible; // Render indication of light direction
- (void) setLuminaireGeometryVisible: (BOOL) visible;

- (void) initializeModelView; // Set camera/viewer to default
- (void) resetModelView; // Return camera/viewer to default location/orientation

- (void) zoomIn; // Move the camera/viewer toward the scene by a quantum
- (void) zoomOut; // Move the camera/viewer away from the scene by a quantum
- (void) zoomFactor: (GLdouble) factor; // Move the camera/viewer toward/away

- (void) rotateDeltaTheta: (GLdouble) angleDegrees; // Rotate around the vector defined by the model origin and the camera position.
- (void) rotateDeltaX: (GLdouble) dx // Rotate geometry about its origin
               deltaY: (GLdouble) dy;

- (void) scrollWheel: (NSEvent*) event; // Mouse scroll wheel movement
- (void) swipeWithEvent: (NSEvent*) event; // Trackpad swipe gesture
- (void) rotateWithEvent: (NSEvent*) event; // Trackpad twist gesture
- (void) magnifyWithEvent: (NSEvent*) event; // Trackpad pinch gesture
- (void) mouseDragged: (NSEvent*) event; // Mouse click-and-drag
- (void) mouseUp: (NSEvent*) event; // Mouse button released
- (void) mouseDown: (NSEvent*) event; // Mouse button pressed
- (void) keyDown: (NSEvent*) event; // Keyboard key pressed




@end
