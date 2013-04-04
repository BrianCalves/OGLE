#import "GeometricModelSphere.h"


@implementation GeometricModelSphere

+ (id) create
{
    return [[[GeometricModelSphere alloc] init] autorelease];
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
    return @"Sphere";
}

- (void) renderLatitude: (double) lat
              longitude: (double) lon
               altitude: (double) alt
{
    assert(lat >= -90.0);
    assert(lat <=  90.0);    
    assert(lon >= -180.0);
    assert(lon <=  180.0);
    
    //    lat = (lat +  90.0) * (M_PI / 180.0);
    //    lon = (lon + 180.0) * (M_PI / 180.0);
    
    lat = (lat +  0.0) * (M_PI / 180.0);
    lon = (lon +  0.0) * (M_PI / 180.0);
        
    double r = .5;
    
    double x = (r + alt) * cos(lat) * cos(lon);
    double y = (r + alt) * cos(lat) * sin(lon);
    double z = (r + alt) * sin(lat);
    
    double len = sqrt(x*x + y*y + z*z);
    
    double t = x / len;
    double u = y / len;
    double v = z / len;
    
    glNormal3d(t, u, v);
    glVertex3d(x, y, z);
}

- (void) render: (GLenum) polygonMode
{
	glMatrixMode(GL_MODELVIEW);
    
    glEnable(GL_CULL_FACE);
    glCullFace(GL_BACK);
    glPolygonMode(GL_FRONT_AND_BACK, polygonMode);
    
    GLfloat ambientReflection[] = { 0.5, 0.5, 0.5, 1.0 };
    GLfloat specularReflection[] = { 0.5, 0.5, 0.5, 1.0 };
    
    glColor4f(0.5, 0.5, 0.5, 1);
    glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, ambientReflection);
    glMaterialfv(GL_FRONT, GL_SPECULAR, specularReflection);
    glBegin(GL_QUADS);
    {    
        int n = 10;
        for (int lat=-90; lat<90; lat+=n)
        {
            for (int lon=-180; lon<180; lon+=n)
            {
                [self renderLatitude: n+lat longitude:   lon altitude: 0];
                [self renderLatitude:   lat longitude:   lon altitude: 0];
                [self renderLatitude:   lat longitude: n+lon altitude: 0];
                [self renderLatitude: n+lat longitude: n+lon altitude: 0];
            }            
        }
        
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
        // glNormal3d(   0,    0,    1);
        glVertex3f(-1.0,  1.0,  0.0);
        glVertex3f(-1.0, -1.0,  0.0);
        glVertex3f( 1.0, -1.0,  0.0);
        glVertex3f( 1.0,  1.0,  0.0);
    }
    glEnd();
    glDepthMask(GL_TRUE);    
}


@end
