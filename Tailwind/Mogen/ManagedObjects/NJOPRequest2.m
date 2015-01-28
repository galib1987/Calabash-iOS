#import "NJOPRequest2.h"
#import "NJOPNetJetsCorePM.h"

@interface NJOPRequest2 ()

// Private interface goes here.

@end

@implementation NJOPRequest2

- (NJOPLeg*)firstLeg
{
    [self willAccessValueForKey:@"legs"];

    __block NJOPLeg *firstLeg = nil;
    
    [self.legsSet enumerateObjectsUsingBlock:^(NJOPLeg *leg, BOOL *stop) {
        
        if (firstLeg == nil ||
            [leg.depTime isBefore:firstLeg.depTime])
        {
            firstLeg = leg;
        }
    }];
    
    [self didAccessValueForKey:@"legs"];
    
    return firstLeg;
}

- (NJOPLeg*)lastLeg
{
    [self willAccessValueForKey:@"legs"];
    
    __block NJOPLeg *lastLeg = nil;
    
    [self.legsSet enumerateObjectsUsingBlock:^(NJOPLeg *leg, BOOL *stop) {
        
        if (lastLeg == nil ||
            [leg.depTime isAfter:lastLeg.depTime])
        {
            lastLeg = leg;
        }
    }];
    
    [self didAccessValueForKey:@"legs"];
    
    return lastLeg;
}

@end
