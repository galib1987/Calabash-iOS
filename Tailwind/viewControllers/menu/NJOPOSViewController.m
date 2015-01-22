//
//  NJOPOSViewController.m
//  Tailwind
//
//  Created by netjets on 1/12/15.
//  Copyright (c) 2015 NetJets. All rights reserved.
//

#import "NJOPOSViewController.h"
@import MessageUI;

@interface NJOPOSViewController () <MFMailComposeViewControllerDelegate>

@end

@implementation NJOPOSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configureSlider];
    

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


- (IBAction)sendMailPressed:(id)sender {
    MFMailComposeViewController *composeController = [[MFMailComposeViewController alloc] init];
    if ([MFMailComposeViewController canSendMail]) {
        composeController.mailComposeDelegate = self;
        [composeController setSubject:@"NETJETS INQUIRY"];
        [composeController setMessageBody:@"I need..." isHTML:NO];
        [self presentViewController:composeController animated:YES completion:nil];
    } else {
        NSString *email = @"mailto:rosa@urbanpixels.com?&subject=NETJETS!";;
        email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
 
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    if (result == MFMailComposeResultSent) {
        NSLog(@"GO TEAM GO!");
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)callPressed:(id)sender {
    NSString *phNo = @"+9176918605";
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    UIAlertView *calert;
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
    }
}
@end
