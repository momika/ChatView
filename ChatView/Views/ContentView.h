//
//  ContentView.h
//  ChatView
//
//  Created by peter on 16/8/19.
//  Copyright © 2016年 MacPro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentView : UIView
/**
 *  消息列表
 */
@property (nonatomic, strong) NSArray *messageCellFrameArray;

//tableView滚动到最底部
- (void)scrollViewToBottom;

/**
 *  刷新界面
 */
- (void)reloadMessageTableView;
@end
