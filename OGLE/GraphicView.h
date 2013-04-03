//
//  GraphicView.h
//  OGLE
//
//  Created by Brian Cálves on 2013-03-28.
//  Copyright 2013 Brian Cálves. All rights reserved.
//

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
