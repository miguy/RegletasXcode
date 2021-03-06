//
//  ZDStickerView.m
//
//  Created by Seonghyun Kim on 5/29/13.
//  Copyright (c) 2013 scipi. All rights reserved.
//

#import "regletaView.h"
#import <QuartzCore/QuartzCore.h>

#define kSPUserResizableViewGlobalInset 20.0
#define kSPUserResizableViewDefaultMinWidth 48.0
#define kSPUserResizableViewInteractiveBorderSize 0.0
#define kZDStickerViewControlSize 48.0


@interface regletaView ()

@property (strong, nonatomic) UIImageView *resizingControl;
@property (strong, nonatomic) UIImageView *deleteControl;
@property (strong, nonatomic) UIImageView *customControl;

@property (nonatomic) BOOL preventsLayoutWhileResizing;

@property (nonatomic) float deltaAngle;
@property (nonatomic) CGPoint prevPoint;
@property (nonatomic) CGAffineTransform startTransform;

@property (nonatomic) CGPoint touchStart;

@end

@implementation regletaView
@synthesize contentView, touchStart, botonesRegleta, bloquearRegleta, valorRegleta;

@synthesize prevPoint;
@synthesize deltaAngle, startTransform; //rotation
@synthesize resizingControl, deleteControl, customControl;
@synthesize preventsPositionOutsideSuperview;
@synthesize preventsResizing;
@synthesize preventsDeleting;
@synthesize preventsCustomButton;
@synthesize minWidth, minHeight;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#ifdef ZDSTICKERVIEW_LONGPRESS
-(void)longPress:(UIPanGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        if([_delegate respondsToSelector:@selector(stickerViewDidLongPressed:)]) {
            [_delegate stickerViewDidLongPressed:self];
        }
    }
    

}
#endif

//Metodo para el boton eliminar la regleta

-(void)TapBorrar:(UITapGestureRecognizer *)recognizer
{
    if (NO == self.preventsDeleting) {
        UIView * close = (UIView *)[recognizer view];
        [close.superview removeFromSuperview];
    }
    
    if([_delegate respondsToSelector:@selector(stickerViewDidClose:)]) {
        [_delegate stickerViewDidClose:self];
    }
}

//Metodo para el boton seleccionar o deseleccionar la regleta
-(void)regletaSeleccionadaTap:(UITapGestureRecognizer *)recognizer
{
    
    if (self.botonesRegleta == YES) {
        //Cuando deseleccionamos: le quitamos los botones
        [self hideEditingHandles];
        self.botonesRegleta = NO;
    }else{
        //cuando seleccionamos: la traemos al frente y le ponemos los botones
        [self.superview bringSubviewToFront:self];
        [self showEditingHandles];
        
        self.botonesRegleta = YES;
        

    }
    [self setNeedsDisplay];
}

//Metodo para el boton bloquear o desbloquear la regleta
-(void)customTap:(UITapGestureRecognizer *)recognizer
{
    if (NO == self.preventsCustomButton) {
        
        if (self.bloquearRegleta == NO) {
            //Cuando esta bloqueada: no mostramos los botones y cambiamos el boton de bloqueo
            self.preventsResizing = YES;
            self.preventsDeleting = YES;
            self.bloquearRegleta = YES;
            customControl.image = [UIImage imageNamed:@"block.png" ];
            [self showCustmomHandle];
        }else{
            //Cuando esta desbloqueada: mostramos los botones y cambiamos el boton de bloqueo
            self.preventsResizing = NO;
            self.preventsDeleting = NO;
            self.bloquearRegleta = NO;
            customControl.image = [UIImage imageNamed:@"unblock.png" ];
        }
        if([_delegate respondsToSelector:@selector(stickerViewDidCustomButtonTap:)]) {
            [_delegate stickerViewDidCustomButtonTap:self];
        }
    }
}

//Metodo para boton girar la regleta
-(void)resizeTranslate:(UIPanGestureRecognizer *)recognizer
{
    
    if ([recognizer state]== UIGestureRecognizerStateBegan)
    {
        prevPoint = [recognizer locationInView:self];
        [self setNeedsDisplay];
    }
    else if ([recognizer state] == UIGestureRecognizerStateChanged)
    {
        if (self.bounds.size.width < minWidth || self.bounds.size.height < minHeight)
        {
            self.bounds = CGRectMake(self.bounds.origin.x,
                                     self.bounds.origin.y,
                                     minWidth+1,
                                     minHeight+1);
            resizingControl.frame =CGRectMake(self.bounds.size.width+kZDStickerViewControlSize,
                                       self.bounds.size.height+kZDStickerViewControlSize,
                                              kZDStickerViewControlSize,
                                              kZDStickerViewControlSize);
            deleteControl.frame = CGRectMake(-21, -21,
                                             40, 40);
            customControl.frame =CGRectMake(self.bounds.size.width-kZDStickerViewControlSize,
                                              0,
                                              kZDStickerViewControlSize,
                                              kZDStickerViewControlSize);
            prevPoint = [recognizer locationInView:self];
             
        }
        
        /* Rotation */
        float ang = atan2([recognizer locationInView:self.superview].y - self.center.y,
                          [recognizer locationInView:self.superview].x - self.center.x);
        
        float angGrados =roundf((deltaAngle - ang)*180/M_PI);
        
        float angleDiff = angGrados*M_PI/180;
        
        if (NO == preventsResizing) {
            self.transform = CGAffineTransformMakeRotation(-angleDiff);
        }
        
        borderView.frame = CGRectInset(self.bounds, kSPUserResizableViewGlobalInset, kSPUserResizableViewGlobalInset);
        [borderView setNeedsDisplay];
        
        [self setNeedsDisplay];
        [self.superview bringSubviewToFront:self];
    }
    else if ([recognizer state] == UIGestureRecognizerStateEnded)
    {
        prevPoint = [recognizer locationInView:self];
        [self setNeedsDisplay];
    }
}

//Iniciamos todos los valores

- (void)setupDefaultAttributes {
    borderView = [[regletaViewBorderView alloc] initWithFrame:CGRectInset(self.bounds, kSPUserResizableViewGlobalInset, kSPUserResizableViewGlobalInset)];
    [borderView setHidden:NO];
    [self addSubview:borderView];
    
    if (kSPUserResizableViewDefaultMinWidth > self.bounds.size.width*0.5) {
        self.minWidth = kSPUserResizableViewDefaultMinWidth;
        self.minHeight = self.bounds.size.height * (kSPUserResizableViewDefaultMinWidth/self.bounds.size.width);
    } else {
        self.minWidth = self.bounds.size.width*0.5;
        self.minHeight = self.bounds.size.height*0.5;
    }
    self.preventsPositionOutsideSuperview = YES;
    self.preventsLayoutWhileResizing = YES;
    self.preventsResizing = NO;
    self.preventsDeleting = NO;
    self.preventsCustomButton = NO;
    self.bloquearRegleta = NO;
#ifdef ZDSTICKERVIEW_LONGPRESS
    UILongPressGestureRecognizer* longpress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(longPress:)];
    [self addGestureRecognizer:longpress];
#endif                            
    
   
    
    //Inicializamos la posicion del boton borrar
    deleteControl = [[UIImageView alloc]initWithFrame:CGRectMake(-10, -10,
                                                                 40, 40)];
    deleteControl.backgroundColor = [UIColor clearColor];
    deleteControl.image = [UIImage imageNamed:@"cerrar.png" ];
    deleteControl.userInteractionEnabled = YES;
    UITapGestureRecognizer * singleTapBorrar = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(TapBorrar:)];
    [deleteControl addGestureRecognizer:singleTapBorrar];
    
    [self addSubview:deleteControl];
    
    //Inicializamos la posicion del boton girar
    resizingControl = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-30,
                                                                   self.frame.size.height-30,
                                                                   40, 40)];
    resizingControl.backgroundColor = [UIColor clearColor];
    resizingControl.userInteractionEnabled = YES;
    resizingControl.image = [UIImage imageNamed:@"girar.png" ];
    UIPanGestureRecognizer* panResizeGesture = [[UIPanGestureRecognizer alloc]
                                                initWithTarget:self
                                                action:@selector(resizeTranslate:)];
    [resizingControl addGestureRecognizer:panResizeGesture];
    [self addSubview:resizingControl];
    
    //Inicializamos la posicion del boton bloquear
    customControl = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-30,
                                                                   -10,
                                                                   40, 40)];
    customControl.backgroundColor = [UIColor clearColor];
    customControl.userInteractionEnabled = YES;
    customControl.image = [UIImage imageNamed:@"unblock.png" ];
    UITapGestureRecognizer * customTapGesture = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(customTap:)];
    [customControl addGestureRecognizer:customTapGesture];
    [self addSubview:customControl];
    
    //Iniciamos el valor de la regleta
    valorRegleta = [[UILabel alloc] init];
    valorRegleta.frame = CGRectMake(30, 20, 40, 40);
    valorRegleta.textColor = [UIColor whiteColor];
    valorRegleta.text = [NSString stringWithFormat:@""];
    [self addSubview:valorRegleta];
    
    
    deltaAngle = atan2(self.frame.origin.y+self.frame.size.height - self.center.y,
                       self.frame.origin.x+self.frame.size.width - self.center.x);

}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self setupDefaultAttributes];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self setupDefaultAttributes];
    }
    return self;
}

//Configuramos el contenido de la regleta
- (void)setContentView:(UIView *)newContentView {
    [contentView removeFromSuperview];
    contentView = newContentView;
    contentView.frame = CGRectInset(self.bounds, kSPUserResizableViewGlobalInset + kSPUserResizableViewInteractiveBorderSize/2, kSPUserResizableViewGlobalInset + kSPUserResizableViewInteractiveBorderSize/2);
    contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:contentView];
    
    UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(regletaSeleccionadaTap:)];
    [self addGestureRecognizer:singleTap];
    
    for (UIView* subview in [contentView subviews]) {
        [subview setFrame:CGRectMake(0, 0,
                                     contentView.frame.size.width,
                                     contentView.frame.size.height)];
        subview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    
    [self bringSubviewToFront:borderView];
    [self bringSubviewToFront:resizingControl];
    [self bringSubviewToFront:deleteControl];
    [self bringSubviewToFront:customControl];
    [self bringSubviewToFront:valorRegleta];
}

- (void)setFrame:(CGRect)newFrame {
    [super setFrame:newFrame];
    contentView.frame = CGRectInset(self.bounds, kSPUserResizableViewGlobalInset + kSPUserResizableViewInteractiveBorderSize/2, kSPUserResizableViewGlobalInset + kSPUserResizableViewInteractiveBorderSize/2);
    contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    for (UIView* subview in [contentView subviews]) {
        [subview setFrame:CGRectMake(0, 0,
                                     contentView.frame.size.width,
                                     contentView.frame.size.height)];
        subview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    
    borderView.frame = CGRectInset(self.bounds,
                                   kSPUserResizableViewGlobalInset,
                                   kSPUserResizableViewGlobalInset);
    resizingControl.frame =CGRectMake(self.bounds.size.width-18,
                                      self.bounds.size.height-18,
                                      kZDStickerViewControlSize,
                                      kZDStickerViewControlSize);
    deleteControl.frame = CGRectMake(0, 0,
                                     kZDStickerViewControlSize, kZDStickerViewControlSize);
    customControl.frame =CGRectMake(self.bounds.size.width-kZDStickerViewControlSize,
                                      0,
                                      kZDStickerViewControlSize,
                                      kZDStickerViewControlSize);
    [borderView setNeedsDisplay];
}


//Cuando momenzamos a mover la regleta
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    touchStart = [touch locationInView:self.superview];
    if([_delegate respondsToSelector:@selector(stickerViewDidBeginEditing:)]) {
        [_delegate stickerViewDidBeginEditing:self];
    }
    //pasamos la regleta que estamos moviendo al frente
    [self.superview bringSubviewToFront:self];
}

//Cuando la movemos
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touchLocation = [[touches anyObject] locationInView:self];
    if (CGRectContainsPoint(resizingControl.frame, touchLocation)) {
        return;
    }
    //Cuando no esta bloqueda, permite moverla
    if (self.bloquearRegleta == NO)
    {
        CGPoint touch = [[touches anyObject] locationInView:self.superview];
        [self translateUsingTouchLocation:touch];
        touchStart = touch;
        [self showEditingHandlesmoved];
    }
    
}

//Cuando finaliza de mover
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    // Notify the delegate we've ended our editing session.
    if([_delegate respondsToSelector:@selector(stickerViewDidEndEditing:)]) {
        [_delegate stickerViewDidEndEditing:self];
    }
    [self showEditingHandles];
    [self hideEditingHandles];
    botonesRegleta = NO;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    // Notify the delegate we've ended our editing session.
    if([_delegate respondsToSelector:@selector(stickerViewDidCancelEditing:)]) {
        [_delegate stickerViewDidCancelEditing:self];
    }
    
}

- (void)translateUsingTouchLocation:(CGPoint)touchPoint {
    CGPoint newCenter = CGPointMake(self.center.x + touchPoint.x - touchStart.x,
                                    self.center.y + touchPoint.y - touchStart.y);
    if (self.preventsPositionOutsideSuperview) {
        // Para prevenir que se salga de la pantalla.
        CGFloat midPointX = CGRectGetMidX(self.bounds);
        if (newCenter.x > self.superview.bounds.size.width - midPointX) {
            newCenter.x = self.superview.bounds.size.width - midPointX;
        }
        if (newCenter.x < midPointX) {
            newCenter.x = midPointX;
        }
        CGFloat midPointY = CGRectGetMidY(self.bounds);
        if (newCenter.y > self.superview.bounds.size.height - midPointY) {
            newCenter.y = self.superview.bounds.size.height - midPointY;
        }
        if (newCenter.y < midPointY) {
            newCenter.y = midPointY;
        }
    }
    self.center = newCenter;
}


//Botones de la regleta
- (void)hideValor
{
    valorRegleta.hidden = YES;
}
- (void)showValor
{
    valorRegleta.hidden = NO;
}

- (void)showEditingHandlesmoved
{
    if (NO == preventsCustomButton) {
        customControl.hidden = NO;
        customControl.alpha=0.3;
    } else {
        customControl.hidden = YES;
    }
    if (NO == preventsDeleting) {
        deleteControl.hidden = NO;
        deleteControl.alpha=0.3;
    } else {
        deleteControl.hidden = YES;
    }
    if (NO == preventsResizing) {
        resizingControl.hidden = NO;
        resizingControl.alpha=0.3;
    } else {
        resizingControl.hidden = YES;
    }
    [borderView setHidden:NO];
}

- (void)hideEditingHandles
{
    resizingControl.hidden = YES;
    deleteControl.hidden = YES;
    customControl.hidden = YES;
    [borderView setHidden:YES];
}

- (void)showEditingHandles
{
    if (NO == preventsCustomButton) {
        customControl.hidden = NO;
        customControl.alpha=1;
    } else {
        customControl.hidden = YES;
    }
    if (NO == preventsDeleting) {
        deleteControl.hidden = NO;
        deleteControl.alpha=1;
    } else {
        deleteControl.hidden = YES;
    }
    if (NO == preventsResizing) {
        resizingControl.hidden = NO;
        resizingControl.alpha=1;
    } else {
        resizingControl.hidden = YES;
    }
    [borderView setHidden:NO];

}

- (void)showCustmomHandle
{
    customControl.hidden = NO;
}

- (void)hideCustomHandle
{
    customControl.hidden = YES;
}

- (void)setButton:(ZDSTICKERVIEW_BUTTONS)type image:(UIImage*)image
{
    switch (type) {
        case ZDSTICKERVIEW_BUTTON_RESIZE:
            resizingControl.image = image;
            break;
        case ZDSTICKERVIEW_BUTTON_DEL:
            deleteControl.image = image;
            break;
        case ZDSTICKERVIEW_BUTTON_CUSTOM:
            customControl.image = image;
            break;
            
        default:
            break;
    }
}


@end
