//
//  DetailViewController.m
//  board-mobile
//
//  Created by KIMJOOHWEE on 2013. 12. 11..
//  Copyright (c) 2013년 KIMJOOHWEE. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+WebCache.h"
#import "DetailCell.h"

@interface DetailViewController (){
}

@end

@implementation DetailViewController
@synthesize titleField;
@synthesize imageField;
@synthesize contentField;
@synthesize commentArr;

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
    _detailTitle.text = titleField;
    _detailContent.text = contentField;
    [_detailImage setImageWithURL:[NSURL URLWithString:imageField]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [commentArr count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* item = [commentArr objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"cmtcell";
    DetailCell* comment2 = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    comment2.commentLabel.text = [item objectForKey:@"content"];
    return comment2;
}

@end
