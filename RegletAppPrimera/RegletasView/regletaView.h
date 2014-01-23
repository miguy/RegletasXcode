//
//  ZDStickerView.h
//
//  Created by Seonghyun Kim on 5/29/13.
//  Copyright (c) 2013 scipi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "regletaViewBorderView.h"

typedef enum {
    ZDSTICKERVIEW_BUTTON_NULL,
    ZDSTICKERVIEW_BUTTON_DEL,
    ZDSTICKERVIEW_BUTTON_RESIZE,
    ZDSTICKERVIEW_BUTTON_CUSTOM,
    ZDSTICKERVIEW_BUTTON_MAX
} ZDSTICKERVIEW_BUTTONS;

@protocol ZDStickerViewDelegate;

@interface regletaView : UIView
{
    regletaViewBorderView *borderView;
}

@property (assign, nonatomic) UIView *contentView;
@property (nonatomic) BOOL preventsPositionOutsideSuperview; //default = YES
@property (nonatomic) BOOL preventsResizing; //default = NO
@property (nonatomic) BOOL preventsDeleting; //default = NO
@property (nonatomic) BOOL preventsCustomButton; //default = YES
@property (nonatomic) CGFloat minWidth;
@property (nonatomic) CGFloat minHeight;
@property (nonatomic) BOOL botonesRegleta;
@property  (nonatomic)  BOOL bloquearRegleta;

@property (strong, nonatomic) id <ZDStickerViewDelegate> delegate;

- (void)hideDelHandle;
- (void)showEditingHandlesmoved;
- (void)hideEditingHandles;
- (void)showEditingHandles;
- (void)showCustmomHandle;
- (void)hideCustomHandle;
- (void)setButton:(ZDSTICKERVIEW_BUTTONS)type image:(UIImage*)image;

@end

@protocol ZDStickerViewDelegate <NSObject>
@required
@optional
- (void)stickerViewDidBeginEditing:(regletaView *)sticker;
- (void)stickerViewDidEndEditing:(regletaView *)sticker;
- (void)stickerViewDidCancelEditing:(regletaView *)sticker;
- (void)stickerViewDidClose:(regletaView *)sticker;
#ifdef ZDSTICKERVIEW_LONGPRESS
- (void)stickerViewDidLongPressed:(regletaView *)sticker;
#endif
- (void)stickerViewDidCustomButtonTap:(regletaView *)sticker;
@end


