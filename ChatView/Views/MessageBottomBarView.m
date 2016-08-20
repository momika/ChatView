
//
//  MessageBottonBarView.m
//  ChatView
//
//  Created by peter on 16/8/19.
//  Copyright © 2016年 MacPro. All rights reserved.
//

#import "MessageBottomBarView.h"

@implementation MessageBottomBarView
+ (instancetype)messageBottomBarViewWithFrame:(CGRect)frame
{
    MessageBottomBarView *messageBottomBarView = [[NSBundle mainBundle] loadNibNamed:@"MessageBottomBarView" owner:self options:nil][0];
    messageBottomBarView.frame = frame;
    
    return messageBottomBarView;
}


@end
