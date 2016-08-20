//
//  NSString+Size.m
//  ChatView
//
//  Created by peter on 16/8/19.
//  Copyright © 2016年 MacPro. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)
- (CGSize)sizeWithAttributes:(NSDictionary *)attributes maxSize:(CGSize)maxSize {
    
    return [self boundingRectWithSize:maxSize
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:attributes context:nil].size;
}
@end
