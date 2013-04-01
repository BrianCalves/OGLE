#import "MainWindowController.h"

@implementation MainWindowController

- (id) init
{
    self = [super init];
    if (self)
		{
            _projectionArray = [[NSMutableArray arrayWithCapacity:0] retain];
            // [_projectionArray addObject:@"Flat Equidistant Cylindrical"];
            // [_projectionArray addObject:@"Flat Cylindrical Satellite-Tracking"];
            [_projectionArray addObject:@"Perspective Spherical"];
            // [_projectionArray addObject:@"Perspective Ellipsoidal"];
            // [_projectionArray addObject:@"Perspective Cylindrical"];
            // [_projectionArray addObject:@"Perspective Conic"];
            // [_projectionArray addObject:@"Perspective Planar"];
            // [_projectionArray addObject:@"Orthographic Spherical"];
            // [_projectionArray addObject:@"Orthographic Ellipsoidal"];
            // [_projectionArray addObject:@"Orthographic Cylindrical"];
            // [_projectionArray addObject:@"Orthographic Conic"];
            // [_projectionArray addObject:@"Orthographic Planar"];
            
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
    [_projectionArray release];
    [_projectionArray release];
    [super dealloc];
}

- (void) projectionChanged: (id) sender
{
	NSLog(@"Projection: %@", [[projectionArrayController selectedObjects] objectAtIndex:0]);
}

- (void) earthModelChanged: (id) sender
{
	NSLog(@"Earth Model: %@", [[earthModelArrayController selectedObjects] objectAtIndex:0]);
}

- (unsigned int)countOfProjections
{
    return [_projectionArray count];
}

- (id)objectInProjectionsAtIndex:(unsigned int)index
{
    return [_projectionArray objectAtIndex:index];
}

- (void)insertObject:(id)anObject inProjectionsAtIndex:(unsigned int)index
{
    [_projectionArray insertObject:anObject atIndex:index];
}

- (void)removeObjectFromProjectionsAtIndex:(unsigned int)index
{
    [_projectionArray removeObjectAtIndex:index];
}

- (void)replaceObjectInProjectionsAtIndex:(unsigned int)index
                               withObject:(id)anObject
{
    [_projectionArray replaceObjectAtIndex:index withObject:anObject];
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
    if ([statisticsView isVisible])
        [statisticsView close];
    else
    {
        [self willChangeValueForKey:@"statisticsVisible"];
        [statisticsView makeKeyAndOrderFront:self];        
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
    return [NSString stringWithFormat:@"%lf", [graphicView modelViewMatrix:index]];
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
