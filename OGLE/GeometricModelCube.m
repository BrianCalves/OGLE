#import "GeometricModelCube.h"


@implementation GeometricModelCube

+ (id) create
{
    return [[[GeometricModelCube alloc] init] autorelease];
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
    return @"Cube";
}

static void normalVertex(double u, double t, double r, double h)
{                     
    // u: [0, h]
    // t: [0, 2pi]
    // r: radius
    // h: height
    
    double huh = (h - u) / h;
    
    double x = huh * r * cos(t);
    double y = huh * r * sin(t);
    double z = u;
    
    double len = sqrt(x*x + y*y + z*z);
    
    double a = x / len;
    double b = y / len;
    double c = z / len;
    
    glNormal3d(a, b, c);
    glVertex3d(x, y, z);
}

- (void) render: (GLenum) polygonMode
          color: (Color*) color;
{
	glMatrixMode(GL_MODELVIEW);    
    glPolygonMode(GL_FRONT_AND_BACK, polygonMode);
    
    [color applyToColor]; // In case someone turns off the lights
    [color applyToFront:GL_AMBIENT];
    [color applyToFront:GL_DIFFUSE];
    [color applyToFront:GL_SPECULAR];
    
    GLdouble x = 0.5;
    GLdouble n = x / 2.0;
    
    glBegin(GL_QUADS);
    {    
        glNormal3d(0, 0, 1);
        glVertex3d( n,  n,  n);
        glVertex3d(-n,  n,  n);
        glVertex3d(-n, -n,  n);
        glVertex3d( n, -n,  n);

        glNormal3d(0, 0, -1);
        glVertex3d(-n, -n, -n);
        glVertex3d(-n,  n, -n);
        glVertex3d( n,  n, -n);
        glVertex3d( n, -n, -n);

        glNormal3d(0, -1, 0);
        glVertex3d( n, -n,  n);
        glVertex3d(-n, -n,  n);
        glVertex3d(-n, -n, -n);
        glVertex3d( n, -n, -n);
        
        glNormal3d(0, 1, 0);
        glVertex3d(-n,  n,  n);
        glVertex3d( n,  n,  n);
        glVertex3d( n,  n, -n);
        glVertex3d(-n,  n, -n);
        
        glNormal3d(-1, 0, 0);
        glVertex3d(-n, -n,  n);
        glVertex3d(-n,  n,  n);
        glVertex3d(-n,  n, -n);
        glVertex3d(-n, -n, -n);
        
        glNormal3d(1, 0, 0);
        glVertex3d( n,  n,  n);
        glVertex3d( n, -n,  n);
        glVertex3d( n, -n, -n);
        glVertex3d( n,  n, -n);
        
        
    }    
    glEnd();
    
    glDisable(GL_CULL_FACE);
    
    GLfloat equatorialPlaneAmbientReflection[] = { 0.8, 0.8, 0.8, 0.5 };
    
    glDepthMask(GL_FALSE);
    glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
    glColor4f(0.9f, 0.9f, 0.9f, 0.5f);
    glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, equatorialPlaneAmbientReflection);
    glMaterialfv(GL_BACK, GL_AMBIENT_AND_DIFFUSE, equatorialPlaneAmbientReflection);
    glBegin(GL_QUADS);
    {
        glNormal3d(   0,    0,    1);
        glVertex3f(-1.0,  1.0,  0.0);
        glVertex3f(-1.0, -1.0,  0.0);
        glVertex3f( 1.0, -1.0,  0.0);
        glVertex3f( 1.0,  1.0,  0.0);
    }
    glEnd();
    glDepthMask(GL_TRUE);    
}

@end
