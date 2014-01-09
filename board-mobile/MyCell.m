//
//  MyCell.m
//  board-mobile
//
//  Created by KIMJOOHWEE on 2013. 12. 11..
//  Copyright (c) 2013년 KIMJOOHWEE. All rights reserved.
//

#import "MyCell.h"


@implementation MyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
