//
//  MyCell.h
//  board-mobile
//
//  Created by KIMJOOHWEE on 2013. 12. 11..
//  Copyright (c) 2013년 KIMJOOHWEE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *uploaddate;
@property (weak, nonatomic) IBOutlet UILabel *num;


@end
