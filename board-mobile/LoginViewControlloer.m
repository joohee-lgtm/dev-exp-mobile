//
//  LoginViewControlloer.m
//  board-mobile
//
//  Created by KIMJOOHWEE on 2013. 12. 11..
//  Copyright (c) 2013년 KIMJOOHWEE. All rights reserved.
//

#import "LoginViewControlloer.h"
#import "NXDataModel.h"

@interface LoginViewControlloer (){
    NXDataModel* _dataModel;
}

@end

@implementation LoginViewControlloer

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
    _dataModel = [[NXDataModel alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickLogin:(id)sender {
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return [_dataModel authenticateID:self.idfield.text withPassword:self.pwfield.text];
}

@end
