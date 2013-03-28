#import "MainWindowController.h"

@implementation MainWindowController

- (id) init
    {
    self = [super init];
    if (self)
		{
		_earthModelArray = [[NSMutableArray arrayWithCapacity:0] retain];
		[_earthModelArray addObject:@"Spherical"];
		[_earthModelArray addObject:@"Flat"];
		}
	return self;
    }
        
- (void) dealloc
    {
    [_earthModelArray release];
    [super dealloc];
    }

- (void) earthModelChanged: (id) sender
{
	NSLog(@"Earth Model: %@", [[earthModelArrayController selectedObjects] objectAtIndex:0]);
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
