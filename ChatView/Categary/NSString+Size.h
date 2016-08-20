//
//  NSString+Size.h
//  ChatView
//
//  Created by peter on 16/8/19.
//  Copyright © 2016年 MacPro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Size)
/**
 *  根据文字计算高宽
 */
- (CGSize)sizeWithAttributes:(NSDictionary *)attributes maxSize:(CGSize)maxSize;
@end
