//
//  SPGripViewBorderView.m
//
//  Created by Seonghyun Kim on 6/3/13.
//  Copyright (c) 2013 scipi. All rights reserved.
//

#import "regletaViewBorderView.h"

@implementation regletaViewBorderView

#define kSPUserResizableViewGlobalInset 5.0
#define kSPUserResizableViewDefaultMinWidth 48.0
#define kSPUserResizableViewDefaultMinHeight 48.0
#define kSPUserResizableViewInteractiveBorderSize 0.2


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Clear background to ensure the content view shows through.
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGFloat longitud[]={4.0, 2.0};
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextSetLineDash(context, 0.0,longitud, 2.0);
    CGContextAddRect(context, rect);
    //CGContextAddRect(context, CGRectInset(self.bounds, kSPUserResizableViewInteractiveBorderSize, kSPUserResizableViewInteractiveBorderSize));
    CGContextStrokePath(context);
    
    CGContextRestoreGState(context);
}

@end
