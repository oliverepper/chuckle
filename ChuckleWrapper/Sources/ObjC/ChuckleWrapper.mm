//
//  ChuckleWrapper.mm
//  
//
//  Created by Oliver Epper on 06.07.21.
//

#import "ChuckleWrapper.h"
#include "chuckle.h"

@implementation ChuckleWrapper

+ (NSString *)joke
{
    return [NSString stringWithCString:joke().c_str() encoding:[NSString defaultCStringEncoding]];
}

@end
