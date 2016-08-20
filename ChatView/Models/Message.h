//
//  Message.h
//  ChatView
//
//  Created by peter on 16/8/19.
//  Copyright © 2016年 MacPro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *time;

//是否是本人
@property (nonatomic, assign) BOOL isMe;

+ (instancetype)messageWithDictionary:(NSDictionary *)dictionary;

@end
