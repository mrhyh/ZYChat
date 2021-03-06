//
//  GJGCInformationFeedListCell.m
//  GJGroupChat
//
//  Created by ZYVincent QQ:1003081775 on 15/7/1.
//  Copyright (c) 2015年 ZYV. All rights reserved.
//

#import "GJGCInformationFeedListCell.h"
#import "GJCFCoreTextFrame.h"

@interface GJGCInformationFeedListCell ()

@property (nonatomic,strong)GJCUAsyncImageView *contentImageView;

@property (nonatomic,strong)GJCFCoreTextContentView *feedCountLabel;

@end

@implementation GJGCInformationFeedListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentImageView = [[GJCUAsyncImageView alloc]init];
        self.contentImageView.gjcf_size = (CGSize){60,60};
        [self.baseContentView addSubview:self.contentImageView];
        
        self.feedCountLabel = [[GJCFCoreTextContentView alloc]init];
        self.feedCountLabel.contentBaseSize = self.tagLabel.contentBaseSize;
        [self.baseContentView addSubview:self.feedCountLabel];
        
        self.contentLabel.numberOfLines = 3;
        
    }
    return self;
}

- (void)setContentInformationModel:(GJGCInformationBaseModel *)contentModel
{
    [super setContentInformationModel:contentModel];
    
    GJGCInformationCellContentModel *informationModel = (GJGCInformationCellContentModel *)contentModel;
    
    CGSize tagSize = [GJCFCoreTextContentView contentSuggestSizeWithAttributedString:informationModel.tag forBaseContentSize:self.tagLabel.contentBaseSize];
    self.tagLabel.gjcf_size = tagSize;
    self.tagLabel.contentAttributedString = informationModel.tag;
    
    CGSize feedCountSize = [GJCFCoreTextContentView contentSuggestSizeWithAttributedString:informationModel.feedListCount forBaseContentSize:self.feedCountLabel.contentBaseSize];
    self.feedCountLabel.gjcf_size = feedCountSize;
    self.feedCountLabel.contentAttributedString = informationModel.feedListCount;
    self.feedCountLabel.gjcf_top = self.tagLabel.gjcf_bottom + 8.f;
    self.feedCountLabel.gjcf_right = self.tagLabel.gjcf_right;
    
    self.contentImageView.gjcf_left = self.tagLabel.gjcf_right + self.contentMargin;
    self.contentImageView.gjcf_top = self.tagLabel.gjcf_top;
    [self.contentImageView setImage:GJCFQuickImage(@"图片占位-创建群组")];
    [self.contentImageView setUrl:informationModel.feedListImageUrl];
    
    self.contentLabel.gjcf_top = self.tagLabel.gjcf_top;
    self.contentLabel.gjcf_left = self.contentImageView.gjcf_right + 12.f;
    CGFloat contentBaseWidth = GJCFSystemScreenWidth - self.contentLabel.gjcf_left - 12.f;
    self.contentLabel.contentBaseWidth = contentBaseWidth;
    self.contentLabel.contentBaseHeight = 10.f;
    
    CGSize contentSize = [GJCFCoreTextContentView contentSuggestSizeWithAttributedString:informationModel.baseContent forBaseContentSize:self.contentLabel.contentBaseSize maxNumberOfLine:self.contentLabel.numberOfLines];
    self.contentLabel.gjcf_size = contentSize;
    self.contentLabel.gjcf_height =  MIN(self.contentImageView.gjcf_height, contentSize.height);
    self.contentLabel.contentAttributedString = informationModel.baseContent;

    //取省略号
    if (contentSize.height > self.contentImageView.gjcf_height) {
        
        GJCFCoreTextFrame *ctFrame = [[GJCFCoreTextFrame alloc]initWithAttributedString:informationModel.baseContent withDrawRect:(CGRect){0,0,self.contentLabel.gjcf_width,self.contentLabel.gjcf_height} isNeedSetupLine:YES];

        NSRange visiableStringRange = ctFrame.visiableStringRange;
        NSRange longestRange = NSMakeRange(0, 0);
        
        NSString *limitString = [informationModel.baseContent.string substringWithRange:visiableStringRange];
        
        NSMutableString *mLimitString = [NSMutableString stringWithString:limitString];
        
        [mLimitString replaceCharactersInRange:NSMakeRange(limitString.length-1, 1) withString:@"..."];
        
        NSDictionary *attributesDict = [self.contentLabel.contentAttributedString attributesAtIndex:visiableStringRange.location longestEffectiveRange:&longestRange inRange:visiableStringRange];
        
        NSAttributedString *resetContentString = [[NSAttributedString alloc]initWithString:mLimitString attributes:attributesDict];
        
        self.contentLabel.contentAttributedString = resetContentString;
        
    }
    
    self.contentLabel.gjcf_top = self.tagLabel.gjcf_top;
    self.contentLabel.gjcf_left = self.contentImageView.gjcf_right + 12.f;
    
    self.baseContentView.gjcf_height = 92.f;

    self.topSeprateLine.gjcf_top = informationModel.topLineMargin;
    self.baseContentView.gjcf_top = self.topSeprateLine.gjcf_bottom-0.5;
    self.baseSeprateLine.gjcf_bottom = self.baseContentView.gjcf_bottom;
    
    self.accessoryIndicatorView.gjcf_centerY = self.topLineToCellTopMargin + self.baseContentView.gjcf_height/2;
}

@end
