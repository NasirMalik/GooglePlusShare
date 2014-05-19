//
//  ViewController.m
//  GPlusSample
//
//  Created by Nasir on 30/12/2013.
//  Copyright (c) 2013 ShinnX Studios. All rights reserved.
//  nasir.shinnx@gmail.com
//  www.shinnxstudios.com
// Follow this https://developers.google.com/+/mobile/ios/getting-started
//              https://developers.google.com/+/mobile/ios/share/
//

#import "ViewController.h"

#import <GoogleOpenSource/GoogleOpenSource.h>
#import <GooglePlus/GooglePlus.h>

#define CLIEND_ID @"98223363200-tteph5459h1qve2js1o3vb4jqeegcghg.apps.googleusercontent.com" //add your Google Plus ClientID here
#define GOOGLE_PLUS_CLIEND_ID @"440607175691-4bhfdefg7sbkrrjk3mp9t5dc15upiet0.apps.googleusercontent.com"

static NSString * const kClientId = CLIEND_ID;

@interface ViewController ()

@end

@implementation ViewController
@synthesize signInButton;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
    signIn.shouldFetchGoogleUserEmail = YES;  // Uncomment to get the user's email
    
    // You previously set kClientId in the "Initialize the Google+ client" step
    signIn.clientID = kClientId;
    
    [GPPSignIn sharedInstance].actions = [NSArray arrayWithObjects:
                                          @"http://schemas.google.com/AddActivity",
                                          @"http://schemas.google.com/BuyActivity",
                                          @"http://schemas.google.com/CheckInActivity",
                                          @"http://schemas.google.com/CommentActivity",
                                          @"http://schemas.google.com/CreateActivity",
                                          @"http://schemas.google.com/ListenActivity",
                                          @"http://schemas.google.com/ReserveActivity",
                                          @"http://schemas.google.com/ReviewActivity",
                                          nil];
    
    // Uncomment one of these two statements for the scope you chose in the previous step
    signIn.scopes = @[ kGTLAuthScopePlusLogin ];  // "https://www.googleapis.com/auth/plus.login" scope
    //signIn.scopes = @[ @"profile" ];            // "profile" scope
    
    // Optional: declare signIn.actions, see "app activities"
    signIn.delegate = self;
    
    
    [signIn trySilentAuthentication];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error
{
    NSLog(@"Received error %@ and auth object %@",error, auth);
    if (error) {
        // Do some error handling here.
    } else {
        NSLog(@"%@ %@",[GPPSignIn sharedInstance].userEmail, [GPPSignIn sharedInstance].userID);
        [self refreshInterfaceBasedOnSignIn];
    }
}

-(void)refreshInterfaceBasedOnSignIn
{
    if ([[GPPSignIn sharedInstance] authentication]) {
        // The user is signed in.
        self.signInButton.hidden = YES;
        // Perform other actions here, such as showing a sign-out button
    } else {
        self.signInButton.hidden = NO;
        // Perform other actions here
    }
}

// Share Code
- (IBAction) didTapShare: (id)sender {
    id<GPPNativeShareBuilder> shareBuilder = [[GPPShare sharedInstance] nativeShareDialog];
    
    // This line will fill out the title, description, and thumbnail from
    // the URL that you are sharing and includes a link to that URL.
    [shareBuilder setURLToShare:[NSURL URLWithString:@"https://www.shinnxstudios.com"]];
    [shareBuilder setPrefillText:@"This is an awesome G+ Sample to share"];
   // [shareBuilder setTitle:@"Title" description:@"Descp" thumbnailURL:[NSURL URLWithString:@"https://www.fbo.com/imageurl"]];
    
    [shareBuilder open];
}



// For Signout USe this code
- (void)signOut {
    [[GPPSignIn sharedInstance] signOut];
}

// Disconnet User
- (void)disconnect {
    [[GPPSignIn sharedInstance] disconnect];
}

- (void)didDisconnectWithError:(NSError *)error {
    if (error) {
        NSLog(@"Received error %@", error);
    } else {
        // The user is signed out and disconnected.
        // Clean up user data as specified by the Google+ terms.
    }
}

@end
