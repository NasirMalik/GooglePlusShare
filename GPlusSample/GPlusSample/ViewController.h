//
//  ViewController.h
//  GPlusSample
//
//  Created by Nasir on 30/12/2013.
//  Copyright (c) 2013 ShinnX Studios. All rights reserved.
//  nasir.shinnx@gmail.com
//  www.shinnxstudios.com
// Follow this https://developers.google.com/+/mobile/ios/getting-started
//              https://developers.google.com/+/mobile/ios/share/
//


#import <UIKit/UIKit.h>
#import <GooglePlus/GooglePlus.h>


@class GPPSignInButton;
@interface ViewController : UIViewController <GPPSignInDelegate>
{
    
}
@property (weak, nonatomic) IBOutlet GPPSignInButton *signInButton;

- (IBAction) didTapShare: (id)sender;

@end
