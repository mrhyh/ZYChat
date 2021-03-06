//
//  GJGCInformationPhotoBox.m
//  GJGroupChat
//
//  Created by ZYVincent QQ:1003081775 on 14-11-6.
//  Copyright (c) 2014年 ZYV. All rights reserved.
//

#import "GJGCInformationPhotoBox.h"
#import "GJCUImageBrowserNavigationViewController.h"

#define GJGCInformationPhotoBoxBaseTag 113344550

@interface GJGCInformationPhotoBox ()

@property (nonatomic,strong)NSArray *mPhotoUrls;

@end

@implementation GJGCInformationPhotoBox

- (void)setContentPhotoBoxUrls:(NSArray *)photoUrls
{
    
    [self setupSubViewsWithImageUrls:photoUrls];
}

- (void)setupSubViewsWithImageUrls:(NSArray *)imageUrls
{
    if (![imageUrls isKindOfClass:[NSArray class]]) {
        return;
    }
    if (!imageUrls || imageUrls.count == 0) {
        return;
    }
    
    self.mPhotoUrls = imageUrls;
    
    self.contentMargin = 4.f;
    
    CGFloat itemWidth = ((GJCFSystemScreenWidth - 8*2) - 3*self.contentMargin)/4;
    

    for (int i = 0; i < imageUrls.count; i++) {
        
        NSInteger columnIndex = i%4;
        NSInteger rowIndex = i/4;
        
        CGFloat originX =  columnIndex*self.contentMargin  + columnIndex*itemWidth;
        CGFloat originY =  rowIndex*self.contentMargin + rowIndex*itemWidth;
        
        CGRect itemFrame = (CGRect){originX,originY,itemWidth,itemWidth};
        
        GJCUAsyncImageView *itemImgView = (GJCUAsyncImageView *)[self viewWithTag:GJGCInformationPhotoBoxBaseTag + i];
        itemImgView.hidden = NO;
        if (!itemImgView) {
            itemImgView = [[GJCUAsyncImageView alloc]initWithFrame:itemFrame];
            itemImgView.userInteractionEnabled = YES;
            itemImgView.contentMode = UIViewContentModeScaleAspectFill;
            itemImgView.clipsToBounds = YES;
            itemImgView.tag = GJGCInformationPhotoBoxBaseTag + i;
            [self addSubview:itemImgView];
            
            UITapGestureRecognizer *tapR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImageSendView:)];
            [itemImgView addGestureRecognizer:tapR];
        }
        
        NSString *imageUrl = [imageUrls objectAtIndex:i];
        
        [itemImgView setUrl:imageUrl];
        
        if (i == imageUrls.count - 1) {
            self.gjcf_height = itemImgView.gjcf_bottom;
        }
    }
    
    /* 隐藏没用到的 */
    for (NSUInteger i = imageUrls.count ; i < 2*4; i++) {
        
        GJCUAsyncImageView *itemImgView = (GJCUAsyncImageView *)[self viewWithTag:GJGCInformationPhotoBoxBaseTag + i];
        itemImgView.hidden = YES;
    }
        
}

#pragma mark - 查看大图

- (void)showBigImageSendView:(UITapGestureRecognizer *)tapR
{
    NSInteger index = tapR.view.tag - GJGCInformationPhotoBoxBaseTag;
    if (self.delegate && [self.delegate respondsToSelector:@selector(photoBoxDidTapAtIndex:)]) {
        [self.delegate photoBoxDidTapAtIndex:index];
    }
}



@end
