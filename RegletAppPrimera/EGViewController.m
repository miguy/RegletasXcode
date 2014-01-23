//
//  EGViewController.m
//  RegletAppPrimera
//
//  Created by Esther Gordo Ramos on 17/12/13.
//  Copyright (c) 2013 RegletApp. All rights reserved.
//

#import "EGViewController.h"

@interface EGViewController ()

@end

@implementation EGViewController{
    CALayer *regleta;
    UIPanGestureRecognizer *panMoverRegleta;
    UITapGestureRecognizer *tapMoverRegleta;
    UIPinchGestureRecognizer *pinchGirarRegleta;
    NSArray *botonesArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    botonesArray = [[NSArray alloc]initWithObjects:_unoButtonOutlet, _dosButtonOutlet, _tresButtonOutlet,_cuatroButtonOutlet,_cincoButtonOutlet,_seisButtonOutlet,_sieteButtonOutlet,_ochoButtonOutlet,_nueveButtonOutlet,_diezButtonOutlet, nil];
    for (UIButton *boton in botonesArray) {
        boton.tintColor = [UIColor whiteColor];
    }
    _unoButtonOutlet.tintColor = [UIColor lightGrayColor];
    _cincoButtonOutlet.tintColor = [UIColor lightGrayColor];

    
    self.view.backgroundColor = [UIColor colorWithRed:0.774 green:0.772 blue:0.730 alpha:1.000];
	// Do any additional setup after loading the view, typically from a nib.
    _unoButtonOutlet.backgroundColor = [UIColor whiteColor];
    _dosButtonOutlet.backgroundColor = [UIColor colorWithRed:1.000 green:0.103 blue:0.146 alpha:1.000];
    _tresButtonOutlet.backgroundColor = [UIColor colorWithRed:0.287 green:0.661 blue:0.136 alpha:1.000];
    _cuatroButtonOutlet.backgroundColor = [UIColor colorWithRed:0.4 green:0.2 blue:0.3 alpha:1];
    _cincoButtonOutlet.backgroundColor = [UIColor yellowColor];
    _seisButtonOutlet.backgroundColor = [UIColor colorWithRed:0 green:0.4 blue:0.3 alpha:1];
    _sieteButtonOutlet.backgroundColor = [UIColor blackColor];
    _ochoButtonOutlet.backgroundColor = [UIColor colorWithRed:0.55 green:0.4 blue:0.35 alpha:1.000];
    _nueveButtonOutlet.backgroundColor = [UIColor colorWithRed:0.000 green:0.334 blue:0.654 alpha:1.000];
    _diezButtonOutlet.backgroundColor = [UIColor colorWithRed:1.000 green:0.385 blue:0.000 alpha:1.000];

    regleta = [CALayer layer];
    panMoverRegleta = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moverRegleta:)];
    tapMoverRegleta = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moverRegleta:)];
    pinchGirarRegleta = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(girarRegleta:)];
    [self.view addGestureRecognizer:panMoverRegleta];
    [self.view addGestureRecognizer:tapMoverRegleta];
    [self.view addGestureRecognizer:pinchGirarRegleta];

    
    //-----dibujar rejilla -----
    int maxXPantallaInt = [NSNumber numberWithFloat:CGRectGetMaxX(self.view.bounds)].floatValue;
    int maxYPantallaInt = [NSNumber numberWithFloat:CGRectGetMaxY(self.view.bounds)].floatValue;
    for (int i = 0; i<maxXPantallaInt; i=i+28) {
        for (int j = 0; j<maxYPantallaInt; j=j+28){
            CALayer *mark = [CALayer layer];
            float diametro = 1.5;
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
    int posicionX = recognizerX - recognizerX%28;
    int recognizerY = [recognizer locationInView:self.view].y;
    int posicionY = recognizerY - recognizerY%28;
    NSLog(@"recognizer x: %f recognizer Y: %f",[recognizer locationInView:self.view].x, [recognizer locationInView:self.view].y );
    NSLog(@"posicion x: %i posicion Y: %i",posicionX,posicionY);
    if (recognizer.state == UIGestureRecognizerStateEnded)
            {
                regleta.position = CGPointMake(posicionX, posicionY);
            }
}

-(void)girarRegleta: (UIPinchGestureRecognizer *)recognizer
{
    
}


-(void)crearRegleta: (UIButton *)button
{
    regleta.bounds = CGRectMake(button.center.x,button.center.y, button.frame.size.width, button.frame.size.height);
    regleta.position = CGPointMake(button.center.x,button.center.y);
    regleta.anchorPoint = CGPointMake(0,0);
    regleta.backgroundColor = button.backgroundColor.CGColor;

    [self.view.layer addSublayer:regleta];
    
}

- (IBAction)unoAction:(id)sender
{
    [self crearRegleta:sender];
    }
- (IBAction)dosAction:(id)sender
{
    [self crearRegleta:sender];
}
- (IBAction)tresAction:(id)sender
{
    [self crearRegleta:sender];
}
- (IBAction)cuatroAction:(id)sender
{
    [self crearRegleta:sender];
}
- (IBAction)cincoAction:(id)sender
{
    [self crearRegleta:sender];
}
- (IBAction)seisAction:(id)sender
{
    [self crearRegleta:sender];
}
- (IBAction)sieteAction:(id)sender
{
    [self crearRegleta:sender];
}
- (IBAction)ochoAction:(id)sender
{
    [self crearRegleta:sender];
}
- (IBAction)nueveAction:(id)sender
{
    [self crearRegleta:sender];
}
- (IBAction)diezAction:(id)sender
{
    [self crearRegleta:sender];
}
@end
