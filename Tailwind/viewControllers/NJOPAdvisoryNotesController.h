//
//  NJOPAdvisoryNotesController.h
//  Tailwind
//
//  Created by netjets on 1/5/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "SimpleDataSourceTableViewController.h"
#import "NJOPReservation.h"

@interface NJOPAdvisoryNotesController : SimpleDataSourceTableViewController

@property (nonatomic) NJOPReservation *reservation;

+ (NSString *)scanString:(NSString *)string
                startTag:(NSString *)startTag
                  endTag:(NSString *)endTag;
@end
