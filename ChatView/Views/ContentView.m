//
//  ContentView.m
//  ChatView
//
//  Created by peter on 16/8/19.
//  Copyright © 2016年 MacPro. All rights reserved.
//

#import "ContentView.h"
#import "CellFrame.h"
#import "ChatCell.h"

@interface ContentView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@end
@implementation ContentView
#pragma mark - lazy
- (UITableView *)tableView
{
    if (!_tableView)
    {
        UITableView *tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        tb.delegate = self;
        tb.dataSource = self;
        //隐藏分割线
        tb.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:tb];
        
        [tb registerClass:[ChatCell class] forCellReuseIdentifier:@"Cell"];
        
        _tableView = tb;
    }
    
    return _tableView;
}

//tableView滚动到最底部
- (void)scrollViewToBottom
{
    //滚动到最后一行
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messageCellFrameArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

/**
 *  刷新界面
 */
- (void)reloadMessageTableView
{
    [self.tableView reloadData];
}

- (void)setMessageCellFrameArray:(NSArray *)messageCellFrameArray
{
    _messageCellFrameArray = messageCellFrameArray;
    
    //刷新
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageCellFrameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    //获取cellframe
    CellFrame *cellFrame = self.messageCellFrameArray[indexPath.row];
    
    cell.cellFrame = cellFrame;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellFrame *cellFrame = self.messageCellFrameArray[indexPath.row];
    
    //返回cell的高度
    return cellFrame.cellRect.size.height;
}


@end
