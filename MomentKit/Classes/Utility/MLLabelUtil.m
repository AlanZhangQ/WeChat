//
//  MLLabelUtil.m
//  MomentKit
//
//  Created by Alan on 2018/07/13.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "MLLabelUtil.h"

@implementation MLLabelUtil

MLLinkLabel *kMLLinkLabel()
{
    MLLinkLabel *_linkLabel = [MLLinkLabel new];
    _linkLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _linkLabel.textColor = [UIColor blackColor];
    _linkLabel.font = kComTextFont;
    _linkLabel.numberOfLines = 0;
    _linkLabel.linkTextAttributes = @{NSForegroundColorAttributeName:kHLTextColor};
    _linkLabel.activeLinkTextAttributes = @{NSForegroundColorAttributeName:kHLTextColor,NSBackgroundColorAttributeName:kHLBgColor};
    _linkLabel.activeLinkToNilDelay = 0.3;
    return _linkLabel;
}

NSMutableAttributedString *kMLLinkLabelAttributedText(id object)
{
    NSMutableAttributedString *attributedText = nil;
    if ([object isKindOfClass:[Comment class]])
    {
        Comment *comment = (Comment *)object;
        if (comment.pk % 2 == 0) {
            NSString *likeString  = [NSString stringWithFormat:@"Jeanne回复%@：%@",comment.userName,comment.text];
            attributedText = [[NSMutableAttributedString alloc] initWithString:likeString];
            [attributedText setAttributes:@{NSFontAttributeName:kComHLTextFont,NSLinkAttributeName:@"Jeanne"}
                                    range:[likeString rangeOfString:@"Jeanne"]];
            [attributedText setAttributes:@{NSFontAttributeName:kComHLTextFont,NSLinkAttributeName:comment.userName}
                                    range:[likeString rangeOfString:comment.userName]];
        } else {
            NSString *likeString  = [NSString stringWithFormat:@"%@：%@",comment.userName,comment.text];
            attributedText = [[NSMutableAttributedString alloc] initWithString:likeString];
            [attributedText setAttributes:@{NSFontAttributeName:kComHLTextFont,NSLinkAttributeName:comment.userName}
                                    range:[likeString rangeOfString:comment.userName]];
        }
    }
    if ([object isKindOfClass:[NSString class]])
    {
        NSString *content = (NSString *)object;
        NSString *likeString = [NSString stringWithFormat:@"[赞] %@",content];
        attributedText = [[NSMutableAttributedString alloc] initWithString:likeString];
        NSArray *nameList = [content componentsSeparatedByString:@"，"];
        for (NSString *name in nameList) {
            [attributedText setAttributes:@{NSFontAttributeName:kComHLTextFont,NSLinkAttributeName:name}
                                    range:[likeString rangeOfString:name]];
        }
        
        //添加'赞'的图片
        NSRange range = NSMakeRange(0, 3);
        NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
        textAttachment.image = [UIImage imageNamed:@"moment_like_hl"];
        textAttachment.bounds = CGRectMake(0, -3, textAttachment.image.size.width, textAttachment.image.size.height);
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
        [attributedText replaceCharactersInRange:range withAttributedString:imageStr];
    }
    return attributedText;
}


@end
