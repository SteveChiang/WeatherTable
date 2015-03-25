//
//  CustomCell.h
//  WeatherTable
//
//  Created by DontHackMe on 2015/3/25.
//  Copyright (c) 2015年 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CustomCellTagHandler)(NSString *tagStr);
@interface CustomCell : UITableViewCell <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UITextField *tags;
@property (copy, nonatomic) CustomCellTagHandler handler;
-(void)handlesDidTagStrChange:(CustomCellTagHandler)handler;
@end
