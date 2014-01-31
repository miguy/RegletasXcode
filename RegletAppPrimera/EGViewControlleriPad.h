//
//  EGViewControlleriPad.h
//  RegletAppPrimera
//
//  Created by Esther Gordo Ramos on 17/12/13.
//  Copyright (c) 2013 RegletApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EGViewControlleriPad : UIViewController

@property (weak, nonatomic) IBOutlet UIView *unoButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *dosButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *tresButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *cuatroButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *cincoButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *seisButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *sieteButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *ochoButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *nueveButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *diezButtonOutlet;

- (IBAction)unoAction:(id)sender;
- (IBAction)dosAction:(id)sender;
- (IBAction)tresAction:(id)sender;
- (IBAction)cuatroAction:(id)sender;
- (IBAction)cincoAction:(id)sender;
- (IBAction)seisAction:(id)sender;
- (IBAction)sieteAction:(id)sender;
- (IBAction)ochoAction:(id)sender;
- (IBAction)nueveAction:(id)sender;
- (IBAction)diezAction:(id)sender;

- (IBAction)SwitchValor:(id)sender;


@property (weak, nonatomic) IBOutlet UIImageView *arcoMenuView;
- (IBAction)menuButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *nuevaHojaButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *visualizacionButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *salirButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *menuButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *compartirButtonOutlet;

@property (strong, nonatomic) UIImage * regleta3;
@property (strong, nonatomic) UIImage * regleta6;
@end
