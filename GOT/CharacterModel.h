//
//  CharacterModel.h
//  
//
//  Created by Marek on 03.09.2015.
//
//

#import <Foundation/Foundation.h>

@interface CharacterModel : NSObject

@property NSString *name;
@property NSString *abstract;

-(id)initWithName:(NSString *)name abstract:(NSString *)abstract;

@end
