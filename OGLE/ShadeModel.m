#import "ShadeModel.h"


@implementation ShadeModel

+ (id) createFlat
{
    return [ShadeModel createValue:GL_FLAT description:@"Flat"];
}

+ (id) createSmooth
{
    return [ShadeModel createValue:GL_SMOOTH description:@"Smooth"];
}

+ (id) createValue: (GLenum) value description: (NSString*) description
{
    return [[[ShadeModel alloc] initValue: value description: description] autorelease];
}

- (id) initValue: (GLenum) value description: (NSString*) description
{
    self = [super init];
    if (self)
    {
        _value = value;
        _description = [[NSString stringWithString:description] retain];
    }
    return self;
}

- (void) dealloc
{
    [_description release];
    [super dealloc];
}

- (GLenum) value
{
    return _value;
}

- (NSString*) description
{
    return [[_description retain] autorelease]; // Retain/autorelease because [description] is nominally not an accessor, so the result of [description] must outlive self.
}

@end
