#import "NJOPRequest2.h"
#import "NJOPNetJetsCorePM.h"

@interface NJOPRequest2 ()

// Private interface goes here.

@end

@implementation NJOPRequest2

- (NSString*)tailNumber
{
    return [self lastLeg].tailNumber;
}

- (NSString*)aircraftName
{
    NJOPLeg *lastLeg = [self lastLeg];
    
    return lastLeg.actualAircraft ?: self.requestedAircraft;
}

- (NJOPLeg*)firstLeg
{
    __block NJOPLeg *firstLeg = nil;
    
    [self.legsSet enumerateObjectsUsingBlock:^(NJOPLeg *leg, BOOL *stop) {
        
        if (firstLeg == nil ||
            [leg.depTime isBefore:firstLeg.depTime])
        {
            firstLeg = leg;
        }
    }];
    
    return firstLeg;
}

- (NJOPLeg*)lastLeg
{
    __block NJOPLeg *lastLeg = nil;
    
    [self.legsSet enumerateObjectsUsingBlock:^(NJOPLeg *leg, BOOL *stop) {
        
        if (lastLeg == nil ||
            [leg.depTime isAfter:lastLeg.depTime])
        {
            lastLeg = leg;
        }
    }];
    
    return lastLeg;
}

@end
