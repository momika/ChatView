//
//  ViewController.m
//  ChatView
//
//  Created by peter on 16/8/20.
//  Copyright © 2016年 MacPro. All rights reserved.
//

#import "ViewController.h"
#import "ContentView.h"
#import "Message.h"
#import "CellFrame.h"
#import "MessageBottomBarView.h"
#import "UIView+Frame.h"
// 发送框视图高度
#define kMessageBottomBarViewHeigth 50

@interface ViewController ()<UITextFieldDelegate>
{
    // 键盘动画时间
    CGFloat _keyboardDuration;
}
@property (nonatomic, weak) ContentView *contentView;
// 消息列表
@property (nonatomic, strong) NSMutableArray *messageCellFrameArray;

// 时间格式化对象
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

// 发送消息框视图
@property (nonatomic, weak) MessageBottomBarView *messageBottomBarView;

@end

@implementation ViewController

#pragma mark - lazy

- (MessageBottomBarView *)messageBottomBarView
{
    if (!_messageBottomBarView)
    {
        MessageBottomBarView *messageBottomBarView = [MessageBottomBarView messageBottomBarViewWithFrame:CGRectMake(0, self.view.frame.size.height - kMessageBottomBarViewHeigth, self.view.frame.size.width, kMessageBottomBarViewHeigth)];
        messageBottomBarView.messageTextField.delegate = self;
        [self.view addSubview:messageBottomBarView];
        
        _messageBottomBarView = messageBottomBarView;
    }
    
    return _messageBottomBarView;
}


- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter)
    {
        //初始化时间格式化对象
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"HH:mm";
    }
    
    return _dateFormatter;
}

- (NSMutableArray *)messageCellFrameArray
{
    if (!_messageCellFrameArray)
    {
        _messageCellFrameArray = [NSMutableArray array];
    }
    
    return _messageCellFrameArray;
}

- (ContentView *)contentView
{
    if (!_contentView)
    {
        ContentView *contentView = [[ContentView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - kMessageBottomBarViewHeigth)];
        [self.view addSubview:contentView];
        
        [self.view sendSubviewToBack:contentView];
        
        _contentView = contentView;
    }
    
    return _contentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
      //创建发送消息功能视图
    self.messageBottomBarView.layer.contents = (id)[UIImage imageNamed:@"chat_bottom_bg"].CGImage;
    
    //读取聊天数据
    [self handleModelFromMessagePlist];
    
    //侦听键盘将要显示的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotificationHandle:) name:UIKeyboardWillShowNotification object:nil];
    
}

#pragma mark - 键盘将要显示
/**
 *  键盘将要显示
 */
- (void)keyboardWillShowNotificationHandle:(NSNotification *)notification
{
    
    //保存键盘的一些信息
    NSDictionary *userInfo = notification.userInfo;
    
    //获取动画时间
    _keyboardDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    //获取键盘出现后的大小
    CGRect keyboardEndRect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    
    //动画显示bar
    [UIView animateWithDuration:_keyboardDuration animations:^{
        
        NSLog(@"%f",keyboardEndRect.origin.y - kMessageBottomBarViewHeigth);
        
        //修改y坐标
        self.messageBottomBarView.y = keyboardEndRect.origin.y - kMessageBottomBarViewHeigth;
    } completion:^(BOOL finished) {
        //tableView滚动到最底部
        [self.contentView scrollViewToBottom];
    }];
}

//封装数据模型
- (void)handleModelFromMessagePlist
{
    NSArray *messages = [NSArray arrayWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil]]];
    
    //封装数据模型
    for (NSDictionary *dic in messages)
    {
        //取上条数据
        Message *lastMessage = [self lastMessage];
        
        //封装当前消息
        Message *message = [Message messageWithDictionary:dic];
        
        CellFrame *cellFrame = [[CellFrame alloc] init];
        //判断是否显示时间
        cellFrame.showTime = ![message.time isEqualToString:lastMessage.time];
        //set方法计算
        cellFrame.message = message;
        
        [self.messageCellFrameArray addObject:cellFrame];
    }
    
    //刷新界面
    self.contentView.messageCellFrameArray = self.messageCellFrameArray;
}

#pragma mark - 取最后一条消息
/**
 *  取最后一条消息
 */
- (Message *)lastMessage
{
    //取上条数据
    CellFrame *lastCellFrame = [self.messageCellFrameArray lastObject];
    Message *lastMessage = lastCellFrame.message;
    
    return lastMessage;
}

#if 0
- (BOOL)isHiddenMessageTimeWithLastTime:(NSString *)lastTime
{
    
    //获取系统时间
    NSDate *currentDate = [NSDate date];
    //把时间格式化为HH:mm
    NSString *dateString = [self.dateFormatter stringFromDate:currentDate];
    
    //两个时间比较
    return [lastTime isEqualToString:[NSString stringWithFormat:@"今天 %@",dateString]];
    
}
#endif

#pragma mark - 获取当前时间
- (NSString *)currentDateFormatter
{
    //获取系统时间
    NSDate *currentDate = [NSDate date];
    //把时间格式化为HH:mm
    NSString *dateString = [self.dateFormatter stringFromDate:currentDate];
    
    return [NSString stringWithFormat:@"今天 %@",dateString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //1.隐藏键盘
    [self.view endEditing:YES];
    
    //2.调整bar坐标
    [UIView animateWithDuration:_keyboardDuration animations:^{
        //坐标还原
        self.messageBottomBarView.y = self.view.frame.size.height - kMessageBottomBarViewHeigth;
    }];
    
    //3.封装message
    Message *message = [[Message alloc] init];
    message.text = textField.text;
    message.time = [self currentDateFormatter];
    message.isMe = YES;
    
    //获取最后一条消息
    Message *lastMessage = [self lastMessage];
    
    CellFrame *cellFrame = [[CellFrame alloc] init];
    //判断显示时间
    cellFrame.showTime = ![lastMessage.time isEqualToString:message.time];
    cellFrame.message = message;
    
    //4.添加到数组
    [self.messageCellFrameArray addObject:cellFrame];
    
    //5.清空文字
    textField.text = @"";
    
    //6.刷新界面
    [self.contentView reloadMessageTableView];
    
    //7.滚动到最下面
    [self.contentView scrollViewToBottom];
    
    
    return YES;
}
@end
