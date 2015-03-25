//
//  Weather.h
//  WeatherTable
//
//  Created by DontHackMe on 2015/3/25.
//  Copyright (c) 2015年 Steve. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *temp;
-(NSString*)display;
@end
