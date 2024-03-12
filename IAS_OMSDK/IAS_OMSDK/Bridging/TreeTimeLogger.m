//
//  TreeTimeLogger.m
//  IASOMID_SDK
//
//  Created by Akshay Patil on 09/09/21.
//  Copyright © 2021 Akshay Patil. All rights reserved.
//

#import "TreeTimeLogger.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TreeTimeLogger() {
    NSMutableString *_timeLog;
}

@end

@implementation TreeTimeLogger
+ (TreeTimeLogger *)sharedLog {
    static dispatch_once_t pred = 0;
    __strong static TreeTimeLogger *appLog;
    dispatch_once(&pred, ^{
        appLog = [[self alloc] init];
    });
    return appLog;
}


- (id) init {
    self = [super init];
    if (self) {
        _timeLog = [NSMutableString string];
        NSString *name = @"OMIDSDK";
        Class _OMIDSDK = NSClassFromString(name);
        if (_OMIDSDK) {
            [[[_OMIDSDK performSelector:NSSelectorFromString(@"sharedInstance")]  performSelector:NSSelectorFromString(@"treeWalker")] performSelector:NSSelectorFromString(@"setTimeLogger:") withObject:self];
        }
    }
    return self;
}

- (void)didProcessObjectsCount:(NSInteger)count withTime:(CGFloat)time {
    [_timeLog appendFormat:@"objects count:%ld   time: %f ms\n", count, time];
}

- (NSString*)getTimeLog{
    return _timeLog;
}

- (void)clearTimeLog{
    _timeLog = [NSMutableString string];
}

@end
