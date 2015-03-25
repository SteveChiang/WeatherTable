//
//  WSHelper.h
//  WeatherTable
//
//  Created by DontHackMe on 2015/3/25.
//  Copyright (c) 2015年 Steve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"
@interface WSHelper : NSObject
+(WSHelper*)getInstance;
-(NSArray*)getWeather;
@end
