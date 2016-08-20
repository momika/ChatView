//
//  ChatCell.m
//  ChatView
//
//  Created by peter on 16/8/19.
//  Copyright © 2016年 MacPro. All rights reserved.
//

#import "ChatCell.h"
#import "Constant.h"
#import "CellFrame.h"
#import "UIImage+Size.h"

@interface ChatCell ()

/**
 *  时间
 */
@property (nonatomic, weak) UILabel *timeLabel;
/**
 *  头像
 */
@property (nonatomic, weak) UIImageView *iconImageView;
/**
 *  消息
 */
@property (nonatomic, weak) UIButton *messageButton;
@end
@implementation ChatCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //选中不会变灰
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    }
    
    return self;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel)
    {
        UILabel *l = [[UILabel alloc] init];
        l.textAlignment = NSTextAlignmentCenter;
        l.textColor = [UIColor lightGrayColor];
        l.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:l];
        
        _timeLabel = l;
    }
    
    return _timeLabel;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.clipsToBounds = YES;
        [self.contentView addSubview:imageView];
        
        _iconImageView = imageView;
    }
    
    return _iconImageView;
}

- (UIButton *)messageButton
{
    if (!_messageButton)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:kMessageButttonFontSize];
        btn.titleLabel.numberOfLines = 0;
        //内容偏移
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, kButtonInsertWidth, 0, kButtonInsertWidth);
        [self.contentView addSubview:btn];
        
        _messageButton = btn;
    }
    
    return _messageButton;
}

- (void)setCellFrame:(CellFrame *)cellFrame
{
    
    //取出消息对象
    Message *message = cellFrame.message;
    
    //消息赋值
    [self.messageButton setTitle:message.text forState:UIControlStateNormal];
    //时间赋值
    self.timeLabel.text = message.time;
    //头像赋值
    NSString *iconImageName = @"icon01";
    //消息背景图片
    NSString *messageBackgroundImageName = @"chat_send_nor";
    //消息的颜色
    UIColor *messageColor = [UIColor whiteColor];
    
    if (!message.isMe)
    {
        iconImageName = @"icon02";
        messageBackgroundImageName = @"chat_recive_nor";
        messageColor = [UIColor blackColor];
    }
    self.iconImageView.image = [UIImage imageNamed:iconImageName];
    
    //修改消息背景图片
    [self.messageButton setBackgroundImage:[[UIImage imageNamed:messageBackgroundImageName] resizeImage] forState:UIControlStateNormal];
    //修改消息文字的颜色
    [self.messageButton setTitleColor:messageColor forState:UIControlStateNormal];
    
    //重新修改坐标
    self.messageButton.frame = cellFrame.messageRect;
    self.iconImageView.frame = cellFrame.iconRect;
    self.timeLabel.frame = cellFrame.timeRect;
    
    //添加圆角半径
    self.iconImageView.layer.cornerRadius = self.iconImageView.frame.size.width/2;
}

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
