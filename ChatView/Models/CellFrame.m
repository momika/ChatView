//
//  CellFrame.m
//  ChatView
//
//  Created by peter on 16/8/19.
//  Copyright © 2016年 MacPro. All rights reserved.
//

#import "CellFrame.h"
#import "Constant.h"
#import "NSString+Size.h"
@implementation CellFrame

- (void)setMessage:(Message *)message
{
    _message = message;
    
    CGRect timeRect = CGRectZero;
    CGRect iconRect = CGRectZero;
    CGRect messageRect = CGRectZero;
    
    //计算
    //1.重新计算时间的位置坐标
    if (self.isShowTime)
    {
        timeRect = CGRectMake(0, 0, kMainScreenWidth, 50);
    }
    
    //2.重新计算头像的位置坐标
    if (message.isMe) //我的头像
    {
        iconRect = CGRectMake(kMainScreenWidth - kIconImageViewWidth - kSpace, CGRectGetMaxY(timeRect) + kSpace, kIconImageViewWidth, kIconImageViewHeight);
    }
    else //别人的头像
    {
        iconRect = CGRectMake(kSpace, CGRectGetMaxY(timeRect) + kSpace, kIconImageViewWidth, kIconImageViewHeight);
    }
    
    //3.重新计算消息的位置坐标
    
    //计算文字的大小
    CGSize messageSize = [message.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kMessageButttonFontSize]} maxSize:CGSizeMake(150, MAXFLOAT)];
    
    //按钮宽度=文字宽度+左右的空隙
    CGFloat buttonWidth = messageSize.width + kButtonInsertWidth*2;
    CGFloat buttonHeight = messageSize.height + 2*kButtonInsertHeight;
    
    if (message.isMe)
    {
        
        //屏幕的宽度 - 头像与屏幕右边的宽度 -  头像的宽度 - 文字的宽度 - 头像与文字的空隙
        messageRect = CGRectMake(kMainScreenWidth - kIconImageViewWidth - kSpace - buttonWidth - kSpace, CGRectGetMinY(iconRect), buttonWidth, buttonHeight);
    }
    else
    {
        //头像距离左边的距离 +  头像的宽度 + 头像与文字的空隙
        messageRect = CGRectMake(kSpace + kIconImageViewWidth + kSpace, CGRectGetMinY(iconRect), buttonWidth, buttonHeight);
    }
    
    //4.赋值
    self.timeRect = timeRect;
    self.iconRect = iconRect;
    self.messageRect = messageRect;
    
    //5.计算cell总高度
    self.cellRect = CGRectMake(0, 0, kMainScreenWidth, MAX(CGRectGetMaxY(iconRect), CGRectGetMaxY(messageRect)) + kSpace);
    
}
@end
