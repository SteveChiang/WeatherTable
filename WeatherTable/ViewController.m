//
//  ViewController.m
//  WeatherTable
//
//  Created by DontHackMe on 2015/3/25.
//  Copyright (c) 2015年 Steve. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
#import "WSHelper.h"
@interface ViewController ()
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSMutableDictionary *tags;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tags = [[NSMutableDictionary alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.data = [[WSHelper getInstance] getWeather];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.table reloadData];
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private
-(void)showViewWithMsg:(NSString*)msg {
    self.show.hidden = NO;
    self.showlabel.text = msg;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:1.5f];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.showlabel.text = @"";
            self.show.hidden = YES;
        });
    });
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell"];
    if (!cell) {
        cell = [[CustomCell alloc] init];
    }
    Weather *w = [self.data objectAtIndex:indexPath.row];
    [cell.city setText:[w display]];
    [cell handlesDidTagStrChange:^(NSString *tagStr) {
        if (!tagStr) {
            return;
        }
        
        [self.tags setObject:tagStr forKey:[NSNumber numberWithInteger:indexPath.row]];
        NSString *msg = [NSString stringWithFormat:@"Tagged %@ with %@", w.name, tagStr];
        [self showViewWithMsg:msg];
    }];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
}

@end
