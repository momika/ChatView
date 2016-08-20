//
//  Message.m
//  ChatView
//
//  Created by peter on 16/8/19.
//  Copyright © 2016年 MacPro. All rights reserved.
//

#import "Message.h"

@implementation Message

+ (instancetype)messageWithDictionary:(NSDictionary *)dictionary
{
    Message *message = [[self alloc] init];
    [message setValuesForKeysWithDictionary:dictionary];
    
    //0表示本人，1表示其他人
    message.isMe = ![dictionary[@"type"] boolValue];
    
    return message;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

@end
