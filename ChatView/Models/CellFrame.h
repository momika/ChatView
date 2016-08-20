//
//  CellFrame.h
//  ChatView
//
//  Created by peter on 16/8/19.
//  Copyright © 2016年 MacPro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"
#import <UIKit/UIKit.h>
@interface CellFrame : NSObject

/**
 *  消息
 */
@property (nonatomic, strong) Message *message;

/**
 *  时间frame
 */
@property (nonatomic) CGRect timeRect;

/**
 *  消息frame
 */
@property (nonatomic) CGRect messageRect;

/**
 *  头像frame
 */
@property (nonatomic) CGRect iconRect;

/**
 *  单元格frame
 */
@property (nonatomic) CGRect cellRect;

/**
 *  是否显示时间
 */
@property (nonatomic, getter=isShowTime) BOOL showTime;

@end
