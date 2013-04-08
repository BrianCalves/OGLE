#import "GeometricModelAxes.h"


@implementation GeometricModelAxes

+ (id) create
{
    return [[[GeometricModelAxes alloc] init] autorelease];
}

- (id) init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (void) dealloc
{
    [super dealloc];
}

- (NSString*) description
{
    return @"Coordinate Axes";
}

- (void) render: (GLenum) polygonMode
          color: (Color*) color;
{
    
    Color* xColor = color? color:[Color red];
    Color* yColor = color? color:[Color green];
    Color* zColor = color? color:[Color blue];
    Color* fColor = color? color:[Color createRed:1.0 
                                            green:0.85 
                                             blue:0.35 
                                            alpha:1.0];
    
    glMatrixMode(GL_MODELVIEW);    
    glBegin(GL_LINES);
    
    [xColor apply: GL_AMBIENT_AND_DIFFUSE, nil];
    glVertex3f( 0.0,  0.0,  0.0);
    glVertex3f( 1.0,  0.0,  0.0);
    
    [yColor apply: GL_AMBIENT_AND_DIFFUSE, nil];
    glVertex3f( 0.0,  0.0,  0.0);
    glVertex3f( 0.0,  1.0,  0.0);
    
    [zColor apply: GL_AMBIENT_AND_DIFFUSE, nil];
    glVertex3f( 0.0,  0.0,  0.0);
    glVertex3f( 0.0,  0.0,  1.0);
    
    glEnd();
    
    BOOL flags = NO; // Visual indicator sometimes useful for debugging
    if (flags)
    {
        [fColor apply: GL_AMBIENT_AND_DIFFUSE, nil];
        
        glDisable(GL_CULL_FACE);
        glPolygonMode(GL_FRONT_AND_BACK, polygonMode);
        
        glBegin(GL_TRIANGLES); // X-Z plane
        glVertex3f(  0.0,  1.0,  0.1);
        glVertex3f( -0.1,  1.0, -0.1);
        glVertex3f(  0.1,  1.0, -0.1);
        glEnd();
        
        glBegin(GL_TRIANGLES); // X-Y plane 
        glVertex3f(  0.0,  0.1,  1.0);
        glVertex3f( -0.1, -0.1,  1.0);
        glVertex3f(  0.1, -0.1,  1.0);
        glEnd();
        
        glBegin(GL_TRIANGLES); // Y-Z plane 
        glVertex3f(  1.0,  0.0,  0.1);
        glVertex3f(  1.0, -0.1, -0.1);
        glVertex3f(  1.0,  0.1, -0.1);
        glEnd();
        
        glEnable(GL_CULL_FACE);
    }
}


@end
