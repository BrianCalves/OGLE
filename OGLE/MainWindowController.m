#import "MainWindowController.h"
#import "CameraModelPerspective.h"
#import "CameraModelOrthographic.h"
#import "GeometricModelCone.h"
#import "GeometricModelSphere.h"
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

            _shadeModelArray = [[NSMutableArray arrayWithCapacity:0] retain];
            [_shadeModelArray addObject:[ShadeModel createFlat]];
            [_shadeModelArray addObject:[ShadeModel createSmooth]];
            
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
    [_shadeModelArray release];
    [_geometricModelArray release];
    [_cameraModelArray release];
    [super dealloc];
}

- (void) awakeFromNib
{
    [self cameraModelChanged:self];
    [self geometricModelChanged: self];
    [self shadeModelChanged: self];
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

- (void) shadeModelChanged: (id) sender
{
	NSLog(@"Shade Model: %@", [[_shadeModelArrayController selectedObjects] objectAtIndex:0]);    
    ShadeModel* shadeModel = [[_shadeModelArrayController selectedObjects] objectAtIndex:0];
    [_graphicView setShadeModel:[shadeModel value]];
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

- (NSString*) modelViewMatrix16
{
    return [self modelViewMatrix:16];
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

    [self willChangeValueForKey:@"modelViewMatrix16"];
    [self didChangeValueForKey:@"modelViewMatrix16"];

    
//    NSLog(@"[MainWindowController refreshStatistics] modelViewMatrix0 = %@", [self modelViewMatrix0]);
    
}


@end
