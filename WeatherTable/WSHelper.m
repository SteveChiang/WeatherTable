//
//  WSHelper.m
//  WeatherTable
//
//  Created by DontHackMe on 2015/3/25.
//  Copyright (c) 2015年 Steve. All rights reserved.
//

#import "WSHelper.h"
@implementation WSHelper
static WSHelper *instance = nil;

+(WSHelper*)getInstance {
    @synchronized(self) {
        if (instance == nil){
            instance = [[WSHelper alloc] init];
        }
    }
    return instance;
}

#pragma mark - public
-(NSArray*)getWeather {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSString *url = @"http://api.openweathermap.org/data/2.5/box/city?bbox=12,32,15,37,10&cluster=yes";
    NSDictionary *dict = [self httpGetDict:url];
    if (!dict) {
        return result;
    }
    
    NSArray *list = [dict objectForKey:@"list"];
    for (NSDictionary *content in list) {
        Weather *w = [[Weather alloc] init];
        w.name = [content objectForKey:@"name"];
        w.temp = [[[content objectForKey:@"main"] objectForKey:@"temp"] stringValue];
        [result addObject:w];
    }

    return result;
}


#pragma mark - private
-(NSDictionary*)httpGetDict:(NSString*)requestUrl {
    NSURL *url = [NSURL URLWithString:requestUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *responseStr = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSDictionary *responseDict = [self objFromJsonStr:responseStr];
    return responseDict;
}

-(id)objFromJsonStr:(NSString*)jsonStr {
    NSError *error = nil;
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    id result = [NSJSONSerialization JSONObjectWithData:jsonData
                                                options:NSJSONReadingMutableContainers
                                                  error:&error];
    if (error) {
        NSLog(@"[ERROR][JSON Parser] %@", error);
        result = nil;
    }
    
    return result;
}
@end
