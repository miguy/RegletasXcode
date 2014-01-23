//
//  EGViewControlleriPad.m
//  RegletAppPrimera
//
//  Created by Esther Gordo Ramos on 17/12/13.
//  Copyright (c) 2013 RegletApp. All rights reserved.
//

#import "EGViewControlleriPad.h"
#import "regletaView.h"

@interface EGViewControlleriPad ()<ZDStickerViewDelegate>

@end

@implementation EGViewControlleriPad{
    CALayer *regleta;
    UIPanGestureRecognizer *panMoverRegleta;
    UITapGestureRecognizer *tapMoverRegleta;
    UIPinchGestureRecognizer *pinchGirarRegleta;
    NSArray *botonesArray;
    BOOL semaforoMenuButton;
}
@synthesize regleta3, regleta6;

- (void)viewDidLoad
{
    [super viewDidLoad];
    botonesArray = [[NSArray alloc]initWithObjects:_unoButtonOutlet, _dosButtonOutlet, _tresButtonOutlet,_cuatroButtonOutlet,_cincoButtonOutlet,_seisButtonOutlet,_sieteButtonOutlet,_ochoButtonOutlet,_nueveButtonOutlet,_diezButtonOutlet, nil];
    for (UIButton *boton in botonesArray) {
        boton.tintColor = [UIColor whiteColor];
    }
    _unoButtonOutlet.tintColor = [UIColor lightGrayColor];
    _cincoButtonOutlet.tintColor = [UIColor lightGrayColor];
    
    regleta3 =[UIImage imageNamed:@"3.png"];
    regleta6 =[UIImage imageNamed:@"6.png"];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.774 green:0.772 blue:0.730 alpha:1.000];
	// Do any additional setup after loading the view, typically from a nib.
    _unoButtonOutlet.backgroundColor = [UIColor whiteColor];
    _dosButtonOutlet.backgroundColor = [UIColor colorWithRed:1 green:0.2 blue:0.3 alpha:1];
    //_tresButtonOutlet.backgroundColor = [UIColor colorWithRed:0.287 green:0.661 blue:0.136 alpha:1.000];
    _cuatroButtonOutlet.backgroundColor = [UIColor colorWithRed:0.4 green:0.2 blue:0.3 alpha:1];
    _cincoButtonOutlet.backgroundColor = [UIColor yellowColor];
    _seisButtonOutlet.backgroundColor = [UIColor colorWithRed:0 green:0.4 blue:0.3 alpha:1];
    _sieteButtonOutlet.backgroundColor = [UIColor blackColor];
    _ochoButtonOutlet.backgroundColor = [UIColor colorWithRed:0.55 green:0.4 blue:0.35 alpha:1.000];
    _nueveButtonOutlet.backgroundColor = [UIColor colorWithRed:0.000 green:0.334 blue:0.654 alpha:1.000];
    _diezButtonOutlet.backgroundColor = [UIColor colorWithRed:1.000 green:0.385 blue:0.000 alpha:1.000];

    regleta = [CALayer layer];
   // panMoverRegleta = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moverRegleta:)];
   // tapMoverRegleta = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moverRegleta:)];

    //[self.view addGestureRecognizer:panMoverRegleta];
    //[self.view addGestureRecognizer:tapMoverRegleta];
    //[self.view addGestureRecognizer:pinchGirarRegleta];

    
    //-----dibujar rejilla -----
    int maxXPantallaInt = [NSNumber numberWithFloat:CGRectGetMaxY(self.view.bounds)].floatValue;
    int maxYPantallaInt = [NSNumber numberWithFloat:CGRectGetMaxX(self.view.bounds)].floatValue;
    for (int i = 0; i<maxXPantallaInt; i=i+40) {
        for (int j = 0; j<maxYPantallaInt; j=j+40){
            CALayer *mark = [CALayer layer];
            float diametro = 3;
            float coordXAleatoriaFloat = i;
            float coordYAleatoriaFloat = j;
            
            mark.bounds = CGRectMake(0, 0, diametro, diametro);
            mark.position = CGPointMake(coordXAleatoriaFloat,coordYAleatoriaFloat);
            //mark.anchorPoint = CGPointMake(0.5,0.5);
            mark.backgroundColor = [UIColor whiteColor].CGColor;
            mark.cornerRadius = diametro/2;
            [self.view.layer addSublayer:mark];
            
        }
    }
    
    semaforoMenuButton = 1;
    
    
    [self latir:_menuButtonOutlet.layer];
    _compartirButtonOutlet.alpha = 0;
    _salirButtonOutlet.alpha = 0;
    _nuevaHojaButtonOutlet.alpha = 0;
    _visualizacionButtonOutlet.alpha = 0;
    _arcoMenuView.alpha = 0;


    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)moverRegleta: (UIGestureRecognizer *)recognizer //withRegleta:(CALayer*)localRegleta
{
    regleta.position = [recognizer locationInView:self.view];
    int recognizerX = [recognizer locationInView:self.view].x;
    int posicionX = recognizerX - recognizerX%40;
    int recognizerY = [recognizer locationInView:self.view].y;
    int posicionY = recognizerY - recognizerY%40;
    if (recognizer.state == UIGestureRecognizerStateEnded)
            {
                regleta.position = CGPointMake(posicionX, posicionY);
            }
}



-(void)crearRegleta: (UIButton *)button conAncho:(float)ancho conAlto:(float)alto conImagen:(UIImage *)imagen
{
    
    CGRect dimensionesRegleta = CGRectMake(button.center.x,button.center.y, ancho, alto);
    UIImageView * regletaImagenView = [[UIImageView alloc] initWithImage:imagen];
    
    regletaView *regletaVista = [[regletaView alloc] initWithFrame:dimensionesRegleta];
    regletaVista.delegate = self;
    regletaVista.contentView = regletaImagenView;//contentView;
    [regletaVista hideEditingHandles];
    [self.view addSubview:regletaVista];
    
}

- (IBAction)unoAction:(id)sender
{
    //[self crearRegleta:sender conAncho:40 conAlto:40];
    }
- (IBAction)dosAction:(id)sender
{
    //[self crearRegleta:sender conAncho:80 conAlto:40];
}
- (IBAction)tresAction:(id)sender
{
    [self crearRegleta:sender conAncho:120 conAlto:40 conImagen:regleta3];
    
}
- (IBAction)cuatroAction:(id)sender
{
    //[self crearRegleta:sender conAncho:160 conAlto:40];
}
- (IBAction)cincoAction:(id)sender
{
    //[self crearRegleta:sender conAncho:200 conAlto:40];
}
- (IBAction)seisAction:(id)sender
{
    [self crearRegleta:sender conAncho:240 conAlto:40 conImagen:regleta6];
}
- (IBAction)sieteAction:(id)sender
{
    //[self crearRegleta:sender conAncho:280 conAlto:40];
}
- (IBAction)ochoAction:(id)sender
{
    //[self crearRegleta:sender conAncho:320 conAlto:40];
}
- (IBAction)nueveAction:(id)sender
{
    //[self crearRegleta:sender conAncho:360 conAlto:40];
}
- (IBAction)diezAction:(id)sender
{
    //[self crearRegleta:sender conAncho:400 conAlto:40];
}


- (IBAction)menuButtonAction:(id)sender
{
    if (semaforoMenuButton == 1) {
        [self apareceMenu];
    }
    else [self desapareceMenu];
    
    

}
#pragma mark - Animations

-(void)apareceMenu
{
    CABasicAnimation *aparecer = [CABasicAnimation animationWithKeyPath:@"opacity"];
    CABasicAnimation *escalar = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    CABasicAnimation *desaparecer = [CABasicAnimation animationWithKeyPath:@"opacity"];
    desaparecer.duration = 1;
    aparecer.duration = 0.5;
    escalar.duration = 0.2;
    semaforoMenuButton = 0;
    
    aparecer.fromValue = 0;
    aparecer.toValue = [NSNumber numberWithFloat:1];
    escalar.fromValue = [NSNumber numberWithFloat:0.5];
    escalar.toValue =[NSNumber numberWithFloat:1];
    _arcoMenuView.layer.anchorPoint = CGPointMake(0, 0);
    _arcoMenuView.layer.position = CGPointMake(0, 0);
    _arcoMenuView.layer.opacity = 1;
    
    [_arcoMenuView.layer addAnimation:escalar forKey:@"scale2"];
    [_arcoMenuView.layer addAnimation:aparecer forKey:@"opacity2"];
    [_arcoMenuView.layer addAnimation:desaparecer forKey:@"opacity2"];
    
    [self aparecerBotonMenu:_nuevaHojaButtonOutlet withDuration:0.1];
    [self aparecerBotonMenu:_visualizacionButtonOutlet withDuration:0.2];
    [self aparecerBotonMenu:_salirButtonOutlet withDuration:0.3];
    [self aparecerBotonMenu:_compartirButtonOutlet withDuration:0.4];
    
    
}

-(void)desapareceMenu
{
    CABasicAnimation *escalar = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    CABasicAnimation *desaparecer = [CABasicAnimation animationWithKeyPath:@"opacity"];
    desaparecer.duration = 0.2;
    escalar.duration = 0.2;
    semaforoMenuButton = 1;
    
    desaparecer.fromValue = [NSNumber numberWithFloat:1];
    desaparecer.toValue = 0;
    escalar.fromValue = [NSNumber numberWithFloat:1];
    escalar.toValue = [NSNumber numberWithFloat:0.5];
    _arcoMenuView.layer.opacity = 0;

    [_arcoMenuView.layer addAnimation:desaparecer forKey:@"opacity2"];
    [_arcoMenuView.layer addAnimation:escalar forKey:@"scale"];
    
    [self desaparecerBotonMenu:_visualizacionButtonOutlet];
    [self desaparecerBotonMenu:_nuevaHojaButtonOutlet];
    [self desaparecerBotonMenu:_salirButtonOutlet];
    [self desaparecerBotonMenu:_compartirButtonOutlet];
    
    

}

-(void)aparecerBotonMenu:(UIButton *)boton withDuration:(CFTimeInterval)duracion
{
    [boton.layer removeAllAnimations];
    CABasicAnimation *escalarButton = [CABasicAnimation animationWithKeyPath:@"transform.scale"];

    escalarButton.toValue = @1.7;
    escalarButton.duration = duracion;
    escalarButton.autoreverses = YES;
    boton.layer.opacity = 1;
    [boton.layer addAnimation:escalarButton forKey:@"transformAnimation"];
    
    [self temblar:boton.layer];
}

-(void)desaparecerBotonMenu:(UIButton *)boton
{
    [boton.layer removeAllAnimations];
    CABasicAnimation *escalarButton2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    CABasicAnimation *desaparecer = [CABasicAnimation animationWithKeyPath:@"opacity"];
    desaparecer.fromValue = [NSNumber numberWithFloat:1];
    desaparecer.toValue = 0;
    desaparecer.duration = 0.2;

    escalarButton2.toValue = @0.2;
    escalarButton2.duration = 0.2;
    boton.layer.opacity = 0;
    [boton.layer addAnimation:escalarButton2 forKey:@"transformAnimation2"];
    [boton.layer addAnimation:desaparecer forKey:@"opacity2"];


}
-(void)latir:(CALayer *)sender
{
    CABasicAnimation *latir = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    latir.fromValue = @1;
    latir.toValue = @1.08;
    latir.duration = 1;
    latir.repeatCount = 2000;
    latir.autoreverses = YES;
    [sender addAnimation:latir forKey:@"latir"];
}
-(void)temblar:(CALayer *)sender
{
    CABasicAnimation *temblarX = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    temblarX.fromValue = @1;
    temblarX.toValue = @1.1;
    temblarX.duration = 1;
    temblarX.repeatCount = 2000;
    temblarX.autoreverses = YES;
    [sender addAnimation:temblarX forKey:@"temblarX"];
    CABasicAnimation *temblarY = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    temblarY.fromValue = @1;
    temblarY.toValue = @1.1;
    temblarY.duration = 1;
    temblarY.beginTime = 1;
    temblarY.repeatCount = 2000;
    temblarY.autoreverses = YES;
    [sender addAnimation:temblarX forKey:@"temblarY"];
    
    CAAnimationGroup *agrupacionAnimaciones = [CAAnimationGroup animation];
    agrupacionAnimaciones.animations = [NSArray arrayWithObjects:temblarX,temblarY, nil];
    agrupacionAnimaciones.duration = 4.0;
    [sender addAnimation:agrupacionAnimaciones forKey:@"temblar"];
}

@end
