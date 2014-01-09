//
//  DetailViewController.h
//  board-mobile
//
//  Created by KIMJOOHWEE on 2013. 12. 11..
//  Copyright (c) 2013년 KIMJOOHWEE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NXDataModel.h"

@interface DetailViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>

@property  NSString *titleField;
@property  NSString *imageField;
@property  NSString *contentField;
@property  NSArray *commentArr;
@property (weak, nonatomic) IBOutlet UILabel *detailTitle;
@property (weak, nonatomic) IBOutlet UIImageView *detailImage;
@property (weak, nonatomic) IBOutlet UITextView *detailContent;

@end
