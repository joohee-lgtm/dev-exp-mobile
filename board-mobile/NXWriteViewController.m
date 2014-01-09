//
//  NXWriteViewController.m
//  board-mobile
//
//  Created by KIMJOOHWEE on 2013. 12. 18..
//  Copyright (c) 2013년 KIMJOOHWEE. All rights reserved.
//

#import "NXWriteViewController.h"
#import "NXDataModel.h"

@interface NXWriteViewController (){
    NXDataModel* _sendBoard;
}
@end

@implementation NXWriteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _imageField.image = _internalImage;
    _sendBoard = [[NXDataModel alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSendClick:(id)sender {
    //TODO: write to server using NSURLConnection
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSString* imageTitle = [self currentTime];
    NSLog(@"send start");
    [_sendBoard newPostTitle:self.titleField.text withContent:self.contentField.text withImage:self.imageField.image withImageTitle:imageTitle];
    NSLog(@"go");
    
    
}

- (NSString*)currentTime{
    NSDateFormatter *time = [[NSDateFormatter alloc]init];
    [time setDateFormat:@"yyMMddHHmmss"];
    NSString *currentTime = [time stringFromDate:[NSDate date]];
    return currentTime;
}


- (void)prepareData:(UIImage*)image
{
    _internalImage = image;
}


@end
