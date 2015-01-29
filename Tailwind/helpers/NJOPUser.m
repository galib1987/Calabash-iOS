//
//  NJOPUser.m
//  Tailwind
//
//  Created by Chad Long on 1/26/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPUser.h"
#import "NJOPTailwindPM.h"
#import "NJOPOAuthClient.h"

@implementation NJOPUser

static NSString *kUsername = @"username";
static NSString *kIndividualID = @"individualID";
static NSString *kDefaultAccountID = @"defaultAccountID";
static NSString *kFirstName = @"firstName";
static NSString *kLastName = @"lastName";

+ (NJOPUser*)sharedInstance
{
    static dispatch_once_t pred;
    static NJOPUser *sharedInstance = nil;
    
    dispatch_once(&pred, ^{
        sharedInstance = [[self alloc] init];
        
        sharedInstance.username = [[NSUserDefaults standardUserDefaults] objectForKey:kUsername] ?: @"";
        sharedInstance.individualID = [[NSUserDefaults standardUserDefaults] objectForKey:kIndividualID] ?: 0;
        sharedInstance.defaultAccountID = [[NSUserDefaults standardUserDefaults] objectForKey:kDefaultAccountID] ?: 0;
        sharedInstance.firstName = [[NSUserDefaults standardUserDefaults] objectForKey:kFirstName] ?: @"";
        sharedInstance.lastName = [[NSUserDefaults standardUserDefaults] objectForKey:kLastName] ?: @"";
        
        [sharedInstance addObserver:sharedInstance forKeyPath:kUsername options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    });
    
    return sharedInstance;
}

- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context
{
    // if the user changes, automatically sign out
    if ([keyPath isEqualToString:kUsername])
    {
        NSString *oldUsername = [NSString stringFromObject:change[NSKeyValueChangeOldKey]];
        NSString *newUsername = [NSString stringFromObject:change[NSKeyValueChangeNewKey]];
        
        if (![newUsername isEqualToString:oldUsername])
        {
            self.username = newUsername;
            [self signOut];
        }
    }
}

- (void)signOut
{
    self.individualID = 0;
    self.defaultAccountID = 0;
    self.firstName = @"";
    self.lastName = @"";
    
    [self saveToDisk];
    
    [[NJOPOAuthClient sharedInstance] resetCredential];
    
    // clear the database in background thread, utilizing the built-in networking queue to make sure any subsequent "brief"
    // network calls wait for this to complete
    NSOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        
        NSManagedObjectContext *moc = [[NJOPTailwindPM sharedInstance] privateMOC];
        [moc deleteAllObjectsForEntityName:[NJOPAccount entityName] predicate:nil error:nil];
        [moc save:nil];
        
        NSLog(@"user signed out");
    }];
    
    [[NCLNetworking sharedInstance].serialOperationQueue addOperation:operation];
}

- (void)saveToDisk
{
    [[NSUserDefaults standardUserDefaults] setObject:self.username forKey:kUsername];
    [[NSUserDefaults standardUserDefaults] setObject:self.individualID forKey:kIndividualID];
    [[NSUserDefaults standardUserDefaults] setObject:self.defaultAccountID forKey:kDefaultAccountID];
    [[NSUserDefaults standardUserDefaults] setObject:self.firstName forKey:kFirstName];
    [[NSUserDefaults standardUserDefaults] setObject:self.lastName forKey:kLastName];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
