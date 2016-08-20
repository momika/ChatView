//
//  MessageBottonBarView.h
//  ChatView
//
//  Created by peter on 16/8/19.
//  Copyright © 2016年 MacPro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageBottomBarView : UIView
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;

+ (instancetype)messageBottomBarViewWithFrame:(CGRect)frame;
@end
