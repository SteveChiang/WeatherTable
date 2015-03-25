//
//  CustomCell.m
//  WeatherTable
//
//  Created by DontHackMe on 2015/3/25.
//  Copyright (c) 2015年 Steve. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - public
-(void)handlesDidTagStrChange:(CustomCellTagHandler)handler {
    self.handler = handler;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    self.handler(textField.text);
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
@end
