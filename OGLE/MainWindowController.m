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
            
		}
	return self;
}

- (void) dealloc
{
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

@end
