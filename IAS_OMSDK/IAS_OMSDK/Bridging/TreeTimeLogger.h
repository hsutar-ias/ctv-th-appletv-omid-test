//
//  TreeTimeLogger.h
//  IASOMID_SDK
//
//  Created by Akshay Patil on 09/09/21.
//  Copyright © 2021 Akshay Patil. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TreeTimeLogger : NSObject
+ (TreeTimeLogger *)sharedLog;
- (NSString*)getTimeLog;
- (void)clearTimeLog;
@end

NS_ASSUME_NONNULL_END
