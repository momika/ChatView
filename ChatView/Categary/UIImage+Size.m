//
//  UIImage+Size.m
//  ChatView
//
//  Created by peter on 16/8/19.
//  Copyright © 2016年 MacPro. All rights reserved.
//

#import "UIImage+Size.h"

@implementation UIImage (Size)

- (UIImage *)resizeImage {
    
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(self.size.height / 2 , self.size.width / 2, self.size.height / 2, self.size.width / 2)];
}
@end
