//
//  Weather.m
//  WeatherTable
//
//  Created by DontHackMe on 2015/3/25.
//  Copyright (c) 2015年 Steve. All rights reserved.
//

#import "Weather.h"

@implementation Weather
-(NSString*)display {
    return [NSString stringWithFormat:@"%@ - %@", self.name, self.temp];
}
@end
