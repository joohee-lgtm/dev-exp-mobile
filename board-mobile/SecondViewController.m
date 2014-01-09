//
//  SecondViewController.m
//  board-mobile
//
//  Created by KIMJOOHWEE on 2013. 11. 27..
//  Copyright (c) 2013년 KIMJOOHWEE. All rights reserved.
//

#import "SecondViewController.h"
#import "NXDataModel.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UILabel *textlabel2;
@property (weak, nonatomic) IBOutlet UITextField *idField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
- (IBAction)onClickRegister:(id)sender;

@end

@implementation SecondViewController
{
    NXDataModel* _dataModel;
}


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
    _idField.delegate = self;
    _passwordField.delegate = self;
    
    [super viewDidLoad];
    self.textlabel2.text=@"가입하는 페이지";
	// Do any additional setup after loading the view.
    _dataModel = [[NXDataModel alloc] init];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    [self.view addGestureRecognizer:tap];
}

-(void)didTap:(UITapGestureRecognizer*)rec
{
    [self.idField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    
    CGRect newframe = self.view.frame;
    newframe.origin.y = 0;
    self.view.frame = newframe;
    self.view.alpha = 1;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onClickRegister:(id)sender {
    [_dataModel saveId:self.idField.text
          withPassword:self.passwordField.text];
}


#pragma mark - TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _idField) {
        [_idField resignFirstResponder];
        [_passwordField becomeFirstResponder];
    }
    else if (textField == _passwordField) {
        [_passwordField resignFirstResponder];
        [self onClickRegister:self];
    }
    return NO;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _idField || textField==_passwordField) {
        [UIView beginAnimations:@"MyAnimation" context:nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        
        CGRect newframe = self.view.frame;
        newframe.origin.y = -100;
        self.view.frame = newframe;
        self.view.alpha = 0.5;
        [UIView commitAnimations];
    }
    
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField == _idField) {
        CGRect newframe = self.view.frame;
        newframe.origin.y = 0;
        self.view.frame = newframe;
    }
    return YES;
}


@end
