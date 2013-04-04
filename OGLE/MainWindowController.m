#import "MainWindowController.h"
#import "CameraModelPerspective.h"
#import "CameraModelOrthographic.h"
#import "GeometricModelCone.h"
#import "GeometricModelCube.h"
#import "GeometricModelSphere.h"
#import "PolygonModel.h"
#import "ShadeModel.h"

@implementation MainWindowController

- (id) init
{
    self = [super init];
    if (self)
		{
            _cameraModelArray = [[NSMutableArray arrayWithCapacity:0] retain];
            [_cameraModelArray addObject:[CameraModelPerspective create]];
            [_cameraModelArray addObject:[CameraModelOrthographic create]];

            _geometricModelArray = [[NSMutableArray arrayWithCapacity:0] retain];
            [_geometricModelArray addObject:[GeometricModelSphere create]];
            [_geometricModelArray addObject:[GeometricModelCone create]];
            [_geometricModelArray addObject:[GeometricModelCube create]];

            _polygonModelArray = [[NSMutableArray arrayWithCapacity:0] retain];
            [_polygonModelArray addObject:[PolygonModel createFill]];
            [_polygonModelArray addObject:[PolygonModel createLine]];
            
            _shadeModelArray = [[NSMutableArray arrayWithCapacity:0] retain];
            [_shadeModelArray addObject:[ShadeModel createFlat]];
            [_shadeModelArray addObject:[ShadeModel createSmooth]];
            
            _geometryAmbientColor = [[NSColor colorWithDeviceWhite:0.5 alpha:0.9] retain];
            
            _statisticsTimer = [[NSTimer 
                scheduledTimerWithTimeInterval:0.1 
                                        target:self 
                                      selector:@selector(refreshStatistics:) 
                                      userInfo:nil 
                                       repeats:YES] retain];
            
            _statisticsVisible = NO;
            
		}
	return self;
}

- (void) dealloc
{
    [_statisticsTimer release];
    [_geometryAmbientColor release];
    [_shadeModelArray release];
    [_polygonModelArray release];
    [_geometricModelArray release];
    [_cameraModelArray release];
    [super dealloc];
}

- (void) awakeFromNib
{
    [self cameraModelChanged:self];
    [self geometricModelChanged:self];
    [self polygonModelChanged:self];
    [self shadeModelChanged:self];
    [self geometryAmbientColorChanged:self];

    // XXX - Cope with 10.5.x Cocoa defect involving PDF-based image templates:
    //
    //       When the image is first loaded in the user interface, transparent
    //       areas, such as the background, are improperly painted white.
    //       Such a white background remains until an event forces the image to
    //       be redrawn. 
    //
    //       Manually sending setAlpha: on NSImageRep objects seems to prevent
    //       the inappropriate white background from ever appearing. This
    //       defect is reported on the Internet, but it seems to be obscure,
    //       perhaps due to infrequent use of PDF-based image templates circa
    //       Mac OS X 10.5.
    //
    for (id imageRep in [[_resetViewpointToolbarItem image] representations])
        [imageRep setAlpha:YES];

    // The following line of code causes NSColorPanel instances to support
    // transparency, unless directed otherwise:
    
    [NSColor setIgnoresAlpha:NO];    
}

- (void) cameraModelChanged: (id) sender
{
	NSLog(@"Camera Model: %@", [[_cameraModelArrayController selectedObjects] objectAtIndex:0]);
    CameraModel* cameraModel = [[_cameraModelArrayController selectedObjects] objectAtIndex:0];
    [_graphicView setCameraModel:cameraModel];
}

- (void) geometricModelChanged: (id) sender
{
	NSLog(@"Geometric Model: %@", [[_geometricModelArrayController selectedObjects] objectAtIndex:0]);    
    GeometricModel* geometricModel = [[_geometricModelArrayController selectedObjects] objectAtIndex:0];
    [_graphicView setGeometricModel:geometricModel];
}

- (void) polygonModelChanged: (id) sender
{
	NSLog(@"Polygon Model: %@", [[_polygonModelArrayController selectedObjects] objectAtIndex:0]);    
    PolygonModel* polygonModel = [[_polygonModelArrayController selectedObjects] objectAtIndex:0];
    [_graphicView setPolygonModel:[polygonModel value]];
}

- (void) shadeModelChanged: (id) sender
{
	NSLog(@"Shade Model: %@", [[_shadeModelArrayController selectedObjects] objectAtIndex:0]);    
    ShadeModel* shadeModel = [[_shadeModelArrayController selectedObjects] objectAtIndex:0];
    [_graphicView setShadeModel:[shadeModel value]];
}

- (void) geometryAmbientColorChanged: (id) sender
{
	NSLog(@"Geometry Ambient Color: %@", [self geometryAmbientColor]);
    [_graphicView setGeometryAmbientColor:[self geometryAmbientColor]];
}

- (void) resetViewpoint: (id) sender
{
    [_graphicView resetModelView];
}

- (void) zoomIn: (id) sender
{
    [_graphicView zoomIn];
}

- (void) zoomOut: (id) sender
{
    [_graphicView zoomOut];
}

- (NSColor*) geometryAmbientColor
{
    return _geometryAmbientColor;
}

- (void) setGeometryAmbientColor: (NSColor*) color
{
    [_geometryAmbientColor autorelease];
    _geometryAmbientColor = [color retain];
    [self geometryAmbientColorChanged:self];
}

- (unsigned int) countOfCameraProjections
{
    return [_cameraModelArray count];
}

- (id) objectInCameraProjectionsAtIndex: (unsigned int)index
{
    return [_cameraModelArray objectAtIndex:index];
}

- (void) insertObject: (id)anObject inCameraProjectionsAtIndex: (unsigned int)index
{
    [_cameraModelArray insertObject:anObject atIndex:index];
}

- (void) removeObjectFromCameraProjectionsAtIndex: (unsigned int)index
{
    [_cameraModelArray removeObjectAtIndex:index];
}

- (void) replaceObjectInCameraProjectionsAtIndex: (unsigned int)index
                                      withObject: (id)anObject
{
    [_cameraModelArray replaceObjectAtIndex:index withObject:anObject];
}

- (unsigned int) countOfGeometricModels
{
    return [_geometricModelArray count];
}

- (id)objectInGeometricModelsAtIndex:(unsigned int)index
{
    return [_geometricModelArray objectAtIndex:index];
}

- (void)insertObject:(id)anObject inGeometricModelsAtIndex:(unsigned int)index
{
    [_geometricModelArray insertObject:anObject atIndex:index];
}

- (void)removeObjectFromGeometricModelsAtIndex:(unsigned int)index
{
    [_geometricModelArray removeObjectAtIndex:index];
}

- (void)replaceObjectInGeometricModelsAtIndex:(unsigned int)index
                                   withObject:(id)anObject
{
    [_geometricModelArray replaceObjectAtIndex:index withObject:anObject];
}

- (unsigned int) countOfPolygonModels
{
    return [_polygonModelArray count];
}

- (id) objectInPolygonModelsAtIndex: (unsigned int)index
{
    return [_polygonModelArray objectAtIndex:index];
}

- (void) insertObject: (id)anObject inPolygonModelsAtIndex: (unsigned int)index
{
    [_polygonModelArray insertObject:anObject atIndex:index];
}

- (void) removeObjectFromPolygonModelsAtIndex: (unsigned int)index
{
    [_polygonModelArray removeObjectAtIndex:index];
}

- (void) replaceObjectInPolygonModelsAtIndex: (unsigned int)index
                                withObject: (id)anObject
{
    [_polygonModelArray replaceObjectAtIndex:index withObject:anObject];
}

- (unsigned int) countOfShadeModels
{
    return [_shadeModelArray count];
}

- (id) objectInShadeModelsAtIndex: (unsigned int)index
{
    return [_shadeModelArray objectAtIndex:index];
}

- (void) insertObject: (id)anObject inShadeModelsAtIndex: (unsigned int)index
{
    [_shadeModelArray insertObject:anObject atIndex:index];
}

- (void) removeObjectFromShadeModelsAtIndex: (unsigned int)index
{
    [_shadeModelArray removeObjectAtIndex:index];
}

- (void) replaceObjectInShadeModelsAtIndex: (unsigned int)index
                                withObject: (id)anObject
{
    [_shadeModelArray replaceObjectAtIndex:index withObject:anObject];
}


- (void) toggleStatisticsVisibility: (id) sender
{
    if ([_statisticsView isVisible])
        [_statisticsView close];
    else
    {
        [self willChangeValueForKey:@"statisticsVisible"];
        [_statisticsView makeKeyAndOrderFront:self];        
        [self didChangeValueForKey:@"statisticsVisible"];
    }
}

- (BOOL) isStatisticsVisible
{
    return _statisticsVisible;
}

- (void) setStatisticsVisible: (BOOL) visible
{
    [self willChangeValueForKey:@"statisticsVisible"];
    _statisticsVisible = visible;
    [self didChangeValueForKey:@"statisticsVisible"];
}

- (NSString*) modelViewMatrix: (int)index
{
    return [NSString stringWithFormat:@"%lf", [_graphicView modelViewMatrix:index]];
}

- (NSString*) projectionMatrix: (int)index
{
    return [NSString stringWithFormat:@"%lf", [_graphicView projectionMatrix:index]];
}

- (NSString*) modelViewMatrix0
{
    return [self modelViewMatrix:0];
}

- (NSString*) modelViewMatrix1
{
    return [self modelViewMatrix:1];
}

- (NSString*) modelViewMatrix2
{
    return [self modelViewMatrix:2];
}

- (NSString*) modelViewMatrix3
{
    return [self modelViewMatrix:3];
}

- (NSString*) modelViewMatrix4
{
    return [self modelViewMatrix:4];
}

- (NSString*) modelViewMatrix5
{
    return [self modelViewMatrix:5];
}

- (NSString*) modelViewMatrix6
{
    return [self modelViewMatrix:6];
}

- (NSString*) modelViewMatrix7
{
    return [self modelViewMatrix:7];
}

- (NSString*) modelViewMatrix8
{
    return [self modelViewMatrix:8];
}

- (NSString*) modelViewMatrix9
{
    return [self modelViewMatrix:9];
}

- (NSString*) modelViewMatrix10
{
    return [self modelViewMatrix:10];
}

- (NSString*) modelViewMatrix11
{
    return [self modelViewMatrix:11];
}

- (NSString*) modelViewMatrix12
{
    return [self modelViewMatrix:12];
}

- (NSString*) modelViewMatrix13
{
    return [self modelViewMatrix:13];
}

- (NSString*) modelViewMatrix14
{
    return [self modelViewMatrix:14];
}

- (NSString*) modelViewMatrix15
{
    return [self modelViewMatrix:15];
}

- (NSString*) projectionMatrix0
{
    return [self projectionMatrix:0];
}

- (NSString*) projectionMatrix1
{
    return [self projectionMatrix:1];
}

- (NSString*) projectionMatrix2
{
    return [self projectionMatrix:2];
}

- (NSString*) projectionMatrix3
{
    return [self projectionMatrix:3];
}

- (NSString*) projectionMatrix4
{
    return [self projectionMatrix:4];
}

- (NSString*) projectionMatrix5
{
    return [self projectionMatrix:5];
}

- (NSString*) projectionMatrix6
{
    return [self projectionMatrix:6];
}

- (NSString*) projectionMatrix7
{
    return [self projectionMatrix:7];
}

- (NSString*) projectionMatrix8
{
    return [self projectionMatrix:8];
}

- (NSString*) projectionMatrix9
{
    return [self projectionMatrix:9];
}

- (NSString*) projectionMatrix10
{
    return [self projectionMatrix:10];
}

- (NSString*) projectionMatrix11
{
    return [self projectionMatrix:11];
}

- (NSString*) projectionMatrix12
{
    return [self projectionMatrix:12];
}

- (NSString*) projectionMatrix13
{
    return [self projectionMatrix:13];
}

- (NSString*) projectionMatrix14
{
    return [self projectionMatrix:14];
}

- (NSString*) projectionMatrix15
{
    return [self projectionMatrix:15];
}

- (void) refreshStatistics: (NSTimer*) timer
{
    [self willChangeValueForKey:@"modelViewMatrix0"];
    [self didChangeValueForKey:@"modelViewMatrix0"];
    
    [self willChangeValueForKey:@"modelViewMatrix1"];
    [self didChangeValueForKey:@"modelViewMatrix1"];
    
    [self willChangeValueForKey:@"modelViewMatrix2"];
    [self didChangeValueForKey:@"modelViewMatrix2"];
    
    [self willChangeValueForKey:@"modelViewMatrix3"];
    [self didChangeValueForKey:@"modelViewMatrix3"];
    
    [self willChangeValueForKey:@"modelViewMatrix4"];
    [self didChangeValueForKey:@"modelViewMatrix4"];
    
    [self willChangeValueForKey:@"modelViewMatrix5"];
    [self didChangeValueForKey:@"modelViewMatrix5"];
    
    [self willChangeValueForKey:@"modelViewMatrix6"];
    [self didChangeValueForKey:@"modelViewMatrix6"];
    
    [self willChangeValueForKey:@"modelViewMatrix7"];
    [self didChangeValueForKey:@"modelViewMatrix7"];
    
    [self willChangeValueForKey:@"modelViewMatrix8"];
    [self didChangeValueForKey:@"modelViewMatrix8"];
    
    [self willChangeValueForKey:@"modelViewMatrix9"];
    [self didChangeValueForKey:@"modelViewMatrix9"];
    
    [self willChangeValueForKey:@"modelViewMatrix10"];
    [self didChangeValueForKey:@"modelViewMatrix10"];
    
    [self willChangeValueForKey:@"modelViewMatrix11"];
    [self didChangeValueForKey:@"modelViewMatrix11"];
    
    [self willChangeValueForKey:@"modelViewMatrix12"];
    [self didChangeValueForKey:@"modelViewMatrix12"];
    
    [self willChangeValueForKey:@"modelViewMatrix13"];
    [self didChangeValueForKey:@"modelViewMatrix13"];
    
    [self willChangeValueForKey:@"modelViewMatrix14"];
    [self didChangeValueForKey:@"modelViewMatrix14"];
    
    [self willChangeValueForKey:@"modelViewMatrix15"];
    [self didChangeValueForKey:@"modelViewMatrix15"];

    [self willChangeValueForKey:@"projectionMatrix0"];
    [self didChangeValueForKey:@"projectionMatrix0"];
    
    [self willChangeValueForKey:@"projectionMatrix1"];
    [self didChangeValueForKey:@"projectionMatrix1"];
    
    [self willChangeValueForKey:@"projectionMatrix2"];
    [self didChangeValueForKey:@"projectionMatrix2"];
    
    [self willChangeValueForKey:@"projectionMatrix3"];
    [self didChangeValueForKey:@"projectionMatrix3"];
    
    [self willChangeValueForKey:@"projectionMatrix4"];
    [self didChangeValueForKey:@"projectionMatrix4"];
    
    [self willChangeValueForKey:@"projectionMatrix5"];
    [self didChangeValueForKey:@"projectionMatrix5"];
    
    [self willChangeValueForKey:@"projectionMatrix6"];
    [self didChangeValueForKey:@"projectionMatrix6"];
    
    [self willChangeValueForKey:@"projectionMatrix7"];
    [self didChangeValueForKey:@"projectionMatrix7"];
    
    [self willChangeValueForKey:@"projectionMatrix8"];
    [self didChangeValueForKey:@"projectionMatrix8"];
    
    [self willChangeValueForKey:@"projectionMatrix9"];
    [self didChangeValueForKey:@"projectionMatrix9"];
    
    [self willChangeValueForKey:@"projectionMatrix10"];
    [self didChangeValueForKey:@"projectionMatrix10"];
    
    [self willChangeValueForKey:@"projectionMatrix11"];
    [self didChangeValueForKey:@"projectionMatrix11"];
    
    [self willChangeValueForKey:@"projectionMatrix12"];
    [self didChangeValueForKey:@"projectionMatrix12"];
    
    [self willChangeValueForKey:@"projectionMatrix13"];
    [self didChangeValueForKey:@"projectionMatrix13"];
    
    [self willChangeValueForKey:@"projectionMatrix14"];
    [self didChangeValueForKey:@"projectionMatrix14"];
    
    [self willChangeValueForKey:@"projectionMatrix15"];
    [self didChangeValueForKey:@"projectionMatrix15"];
    
    
//    NSLog(@"[MainWindowController refreshStatistics] modelViewMatrix0 = %@", [self modelViewMatrix0]);
    
}


@end
