//
//  ShadeModel.h
//  OGLE
//
//  Created by Brian Cálves on 2013-04-02.
//  Copyright 2013 Brian Cálves. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ShadeModel : NSObject {

    GLenum _value;
    NSString* _description;
    
}

+ (id) createFlat;
+ (id) createSmooth;

+ (id) createValue: (GLenum) value description: (NSString*) description;

- (id) initValue: (GLenum) value description: (NSString*) description;
- (void) dealloc;

- (GLenum) value;
- (NSString*) description;

@end
