//
//  NXWriteViewController.h
//  board-mobile
//
//  Created by KIMJOOHWEE on 2013. 12. 18..
//  Copyright (c) 2013년 KIMJOOHWEE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NXWriteViewController : UIViewController
{
    UIImage* _internalImage;
    
}

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UIImageView *imageField;
@property (weak, nonatomic) IBOutlet UITextView *contentField;

- (IBAction)onSendClick:(id)sender;
- (void) prepareData:(UIImage*)image;
- (NSString*)currentTime;

@end
