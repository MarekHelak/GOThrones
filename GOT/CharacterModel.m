//
//  CharacterModel.m
//  
//
//  Created by Marek on 03.09.2015.
//
//

#import "CharacterModel.h"

@implementation CharacterModel

-(id)initWithName:(NSString *)name abstract:(NSString *)abstract{
    
    if (self = [super init])
    {
        self.name = name;
        self.abstract = abstract;
    }
    return self;
    
}
@end
