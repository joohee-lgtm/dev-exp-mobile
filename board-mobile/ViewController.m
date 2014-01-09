//
//  ViewController.m
//  board-mobile
//
//  Created by KIMJOOHWEE on 2013. 11. 27..
//  Copyright (c) 2013년 KIMJOOHWEE. All rights reserved.
//

#import "ViewController.h"
#import "NXFraction.h"
#import "NXDataModel.h"


@interface ViewController ()

@end

@implementation ViewController
{
    NXDataModel* _myModel;
}

- (void)sayHello:(NSString*)string
//:(타입명)변수명 *가 없는 경우는 primitive타입일 경우
{
    NSLog(@"hello app - %@",string);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self sayHello:@"_____ahahahahhahahhhh"];
	// Do any additional setup after loading the view, typically from a nib.
    
    _myModel = [[NXDataModel alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onButtonClick:(id)sender {
    
    [self sayHello:@"_____ahahahahhahahhhh"];
    self.textLabel.textColor = [UIColor redColor];
    self.textLabel.text = @"반가웡";
    
    NXFraction *fraction;
    fraction = [NXFraction alloc];
    fraction = [fraction init];
    [fraction setNumerator:3];
    [fraction setDenominator:1];
    [fraction print];

    NSLog(@"%@",[_myModel description]);
}

- (IBAction)returned:(UIStoryboardSegue*)segue{
    self.textLabel.text
        = @"들어올 때는 맘대로지만 나갈땐 아니란다.";
}


@end

