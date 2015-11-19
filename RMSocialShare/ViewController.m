//
//  ViewController.m
//  RMSocialShare
//
//  Created by Ricardo Maduro on 02/11/15.
//  Copyright © 2015 Ricardo Maduro. All rights reserved.
//

#import "ViewController.h"
#import "Social/Social.h"

@interface ViewController ()


@property (weak, nonatomic) IBOutlet UITextView *twitterTextView;
@property (weak, nonatomic) IBOutlet UITextView *facebookTextView;
@property (weak, nonatomic) IBOutlet UITextView *moreTextView;


- (void) initTextViews;
- (void) showAlertMessage:(NSString *) myMessage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initTextViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showFacebookClick:(id)sender {
    
    if ([self.facebookTextView isFirstResponder]) {
        [self.facebookTextView resignFirstResponder];
    }
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook ]){
        
        SLComposeViewController *facebookVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [facebookVC setInitialText:self.facebookTextView.text];
        
        [self presentViewController:facebookVC animated:YES completion:nil];
        
    } else {
        // objection
        [self showAlertMessage:@"Please sign in to facebook before you post"];
    }
}
- (IBAction)showTweeterClick:(id)sender {
    if ([self.twitterTextView isFirstResponder]) {
        [self.twitterTextView resignFirstResponder];
    }
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter ]){
        
        SLComposeViewController *moreVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        if([self.twitterTextView.text length] < 140) {
            [moreVC setInitialText:self.twitterTextView.text];
        }else {
            NSString *shortText = [self.twitterTextView.text substringToIndex:140];
            [moreVC setInitialText:shortText];
        }
        
        [self presentViewController:moreVC animated:YES completion:nil];
        
    } else {
        // objection
        [self showAlertMessage:@"Please sign in to twitter before you tweet"];
    }
}

- (IBAction)showMoreClick:(id)sender {
    UIActivityViewController *moreVC = [
                                        [UIActivityViewController alloc]
                                        initWithActivityItems:@[self.moreTextView.text] applicationActivities:nil];
    
    [self presentViewController:moreVC animated:YES completion:nil];
}


- (void) showAlertMessage:(NSString *) myMessage {
    UIAlertController *alertController;
    alertController = [UIAlertController alertControllerWithTitle:@"Social share" message:myMessage preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)showMessageClick:(id)sender {
    [self showAlertMessage:@"Just a message!"];
}

- (void) initTextViews{
    self.twitterTextView.layer.backgroundColor=
    [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0].CGColor;
    self.twitterTextView.layer.cornerRadius=10.0;
    self.twitterTextView.layer.borderColor=
    [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    self.twitterTextView.layer.borderWidth=2.0;
    
    self.facebookTextView.layer.backgroundColor=
    [UIColor colorWithRed:1.0 green:0.9 blue:0.7 alpha:1.0].CGColor;
    self.facebookTextView.layer.cornerRadius=10.0;
    self.facebookTextView.layer.borderColor=
    [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    self.facebookTextView.layer.borderWidth=2.0;
    
    self.moreTextView.layer.backgroundColor=
    [UIColor colorWithRed:0.3 green:0.8 blue:0.3 alpha:1.0].CGColor;
    self.moreTextView.layer.cornerRadius=10.0;
    self.moreTextView.layer.borderColor=
    [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    self.moreTextView.layer.borderWidth=2.0;
    
}

@end
