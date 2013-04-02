//
//  GraphicView.h
//  OGLE
//
//  Created by Brian Cálves on 2013-03-28.
//  Copyright 2013 Brian Cálves. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface GraphicView : NSOpenGLView {

    GLenum _shadeModel;
    
}

- (GLdouble) modelViewMatrix: (int)index;
- (GLdouble) projectionMatrix: (int)index;

- (void) drawRect: (NSRect) bounds;

- (GLenum) shadeModel;
- (void) setShadeModel: (GLenum) newValue;

@end
