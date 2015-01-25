#import "NJOPReservation2.h"
#import "NSDictionary+ObjectForKeyOrNil.h"

@interface NJOPReservation2 ()

// Private interface goes here.

@end

@implementation NJOPReservation2

// Custom logic goes here.

//+ (NJOPReservation2 *)reservationWithReservationId:(NSInteger)reservationId usingManagedObjectContext:(NSManagedObjectContext *)moc {
//    
//    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[NJOPReservation2 entityName]];
//    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"reservationId = %d", reservationId]];
//    [fetchRequest setFetchLimit:1];
//    
//    NSError *error = nil;
//    
//    NSArray *results = [moc executeFetchRequest:fetchRequest error:&error];
//    
//    
//    if (error) {
//        NSLog(@"ERROR: %@ %@", [error localizedDescription], [error userInfo]);
//        exit(1);
//    }
//    
//    if ([results count] == 0) {
//        return nil;
//    }
//    
//    return [results objectAtIndex:0];
//}
//
//- (void)updateAttributes:(NSDictionary *)attributes {
//    self.reservationID = [attributes objectForKeyOrNil:attributes];
//}

@end
