#import "MainWindowController.h"

@implementation MainWindowController

- (id) init
{
    self = [super init];
    if (self)
		{
            _cameraProjectionArray = [[NSMutableArray arrayWithCapacity:0] retain];
            [_cameraProjectionArray addObject:@"Perspective"];
         // [_cameraProjectionArray addObject:@"Orthographic"];
         // [_cameraProjectionArray addObject:@"Flat"];

            _modelProjectionArray = [[NSMutableArray arrayWithCapacity:0] retain];
            [_modelProjectionArray addObject:@"None"];
         // [_modelProjectionArray addObject:@"Cylindrical Equidistant"];
            [_modelProjectionArray addObject:@"Cylindrical Satellite-Tracking"];
         // [_modelProjectionArray addObject:@"Planar Equidistant"];
         // [_modelProjectionArray addObject:@"Planar Satellite-Tracking"];
         // [_modelProjectionArray addObject:@"Conic ..."];

            _earthModelArray = [[NSMutableArray arrayWithCapacity:0] retain];
            [_earthModelArray addObject:@"Sphere"];
            // [_earthModelArray addObject:@"Ellipsoid"];

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
    [_earthModelArray release];
    [_modelProjectionArray release];
    [_cameraProjectionArray release];
    [super dealloc];
}

- (void) cameraProjectionChanged: (id) sender
{
	NSLog(@"Camera Projection: %@", [[_cameraProjectionArrayController selectedObjects] objectAtIndex:0]);
}

- (void) modelProjectionChanged: (id) sender
{
	NSLog(@"Model Projection: %@", [[_modelProjectionArrayController selectedObjects] objectAtIndex:0]);
}

- (void) earthModelChanged: (id) sender
{
	NSLog(@"Earth Model: %@", [[_earthModelArrayController selectedObjects] objectAtIndex:0]);
}

- (unsigned int) countOfCameraProjections
{
    return [_cameraProjectionArray count];
}

- (id) objectInCameraProjectionsAtIndex: (unsigned int)index
{
    return [_cameraProjectionArray objectAtIndex:index];
}

- (void) insertObject: (id)anObject inCameraProjectionsAtIndex: (unsigned int)index
{
    [_cameraProjectionArray insertObject:anObject atIndex:index];
}

- (void) removeObjectFromCameraProjectionsAtIndex: (unsigned int)index
{
    [_cameraProjectionArray removeObjectAtIndex:index];
}

- (void) replaceObjectInCameraProjectionsAtIndex: (unsigned int)index
                                      withObject: (id)anObject
{
    [_cameraProjectionArray replaceObjectAtIndex:index withObject:anObject];
}

- (unsigned int)countOfModelProjections
{
    return [_modelProjectionArray count];
}

- (id)objectInModelProjectionsAtIndex:(unsigned int)index
{
    return [_modelProjectionArray objectAtIndex:index];
}

- (void)insertObject:(id)anObject inModelProjectionsAtIndex:(unsigned int)index
{
    [_modelProjectionArray insertObject:anObject atIndex:index];
}

- (void)removeObjectFromModelProjectionsAtIndex:(unsigned int)index
{
    [_modelProjectionArray removeObjectAtIndex:index];
}

- (void)replaceObjectInModelProjectionsAtIndex:(unsigned int)index
                               withObject:(id)anObject
{
    [_modelProjectionArray replaceObjectAtIndex:index withObject:anObject];
}

- (unsigned int)countOfEarthModels
{
    return [_earthModelArray count];
}

- (id)objectInEarthModelsAtIndex:(unsigned int)index
{
    return [_earthModelArray objectAtIndex:index];
}

- (void)insertObject:(id)anObject inEarthModelsAtIndex:(unsigned int)index
{
    [_earthModelArray insertObject:anObject atIndex:index];
}

- (void)removeObjectFromEarthModelsAtIndex:(unsigned int)index
{
    [_earthModelArray removeObjectAtIndex:index];
}

- (void)replaceObjectInEarthModelsAtIndex:(unsigned int)index
                               withObject:(id)anObject
{
    [_earthModelArray replaceObjectAtIndex:index withObject:anObject];
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
//    return [statisticsView isVisible];
    return _statisticsVisible;
}

- (void) setStatisticsVisible: (BOOL) visible
{
//    if (visible != [statisticsView isVisible])
//    {
//        [self willChangeValueForKey:@"statisticsVisible"];
//        if (visible)
//            [statisticsView makeKeyAndOrderFront:self];
//        else
//            [statisticsView close];
//        [self didChangeValueForKey:@"statisticsVisible"];    
//    }
        
    [self willChangeValueForKey:@"statisticsVisible"];
    _statisticsVisible = visible;
    [self didChangeValueForKey:@"statisticsVisible"];
}

- (NSString*) modelViewMatrix: (int)index
{
    return [NSString stringWithFormat:@"%lf", [_graphicView modelViewMatrix:index]];
//    return [NSString stringWithFormat:@"%lf", 1.0];
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
