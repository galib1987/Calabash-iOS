//
//  NJOPOSViewController.m
//  Tailwind
//
//  Created by netjets on 1/12/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPOSViewController.h"
#import "NJOPFlightHTTPClient.h"
#import "NJOPSession.h"

@import MessageUI;

@interface NJOPOSViewController () <MFMailComposeViewControllerDelegate>
@property (nonatomic) NSArray *accounts;
@property (nonatomic) NJOPSession *session;

@end

@implementation NJOPOSViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configureSlider];
    
    self.session = [NJOPSession sharedInstance];
    
    self.latenessSlider.value = 20;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureSlider {
    self.latenessSlider.minimumValue = 1;
    self.latenessSlider.maximumValue = 60;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sliderChanged:(id)sender {
    int intValue = (int)ceil(self.latenessSlider.value);
    [_latenessNotificationButton setTitle:[NSString stringWithFormat:@"I'LL BE %d MINUTES LATE", intValue] forState:UIControlStateNormal];
    
}

- (NSDictionary *)getOSRInfo {
    NJOPSession *session = [NJOPSession sharedInstance];
    NSLog(@"%@",session.accounts);
    
    NSDictionary *accountDict = session.accounts[0];

    return accountDict;
}

- (void)sendMail {
    NSString *teamEmail = [[self getOSRInfo] valueForKeyPath:@"accountOSRTeamEmail"];
    NSString *clientName = [NSString stringWithFormat:@"%@ %@", self.session.individual.firstName, self.session.individual.lastName];
    
    MFMailComposeViewController *composeController = [[MFMailComposeViewController alloc] init];
    composeController.mailComposeDelegate = self;
    if ([MFMailComposeViewController canSendMail]) {
        composeController.mailComposeDelegate = self;
        [composeController setSubject:@"Running Late"];
        [composeController setToRecipients:@[teamEmail]];
        [composeController setMessageBody:[NSString stringWithFormat:@"I am running %d minutes late. \n - %@", (int)self.latenessSlider.value, clientName] isHTML:NO];
        [self presentViewController:composeController animated:YES completion:nil];
    } else {
        NSString *email = [NSString stringWithFormat:@"mailto:%@?&subject=NETJETS!", teamEmail];
        email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
        
    }
}

- (IBAction)lateButtonPressed:(id)sender {
    
    [self sendMail];
}

- (IBAction)sendMailPressed:(id)sender {
    
    [self sendMail];
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    if (result == MFMailComposeResultSent) {
        NSLog(@"GO TEAM GO!");
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)callPressed:(id)sender {
    
    NSString *phNo = [[self getOSRInfo] valueForKeyPath:@"accountOSRTeamPhone"];
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    UIAlertView *calert;
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Phone is offline." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
    }
}
@end
