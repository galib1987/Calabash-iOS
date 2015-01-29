#import "_NJOPRequest2.h"
#import "NJOPFBO.h"
#import "NJOPLeg.h"

@interface NJOPRequest2 : _NJOPRequest2 {}

- (NSString*)tailNumber;
- (NSString*)aircraftName;

- (NJOPLeg*)firstLeg;
- (NJOPLeg*)lastLeg;

@end
