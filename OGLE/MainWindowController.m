#import "MainWindowController.h"

@implementation MainWindowController

- (id) init
    {
    self = [super init];
    if (self)
		{
		_projectionArray = [[NSMutableArray arrayWithCapacity:0] retain];
		[_projectionArray addObject:@"Equidistant Cylindrical"];
		[_projectionArray addObject:@"Cylindrical Satellite-Tracking"];
		[_projectionArray addObject:@"Perspective Spherical"];
		[_projectionArray addObject:@"Perspective Ellipsoidal"];
		[_projectionArray addObject:@"Perspective Cylindrical"];
		[_projectionArray addObject:@"Perspective Conic"];
		[_projectionArray addObject:@"Perspective Planar"];
		}
	return self;
    }
        
- (void) dealloc
    {
    [_projectionArray release];
    [super dealloc];
    }

- (void) projectionChanged: (id) sender
{
	NSLog(@"Projection: %@", [[projectionArrayController selectedObjects] objectAtIndex:0]);
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

@end
