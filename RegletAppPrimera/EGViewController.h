//
//  EGViewController.h
//  RegletAppPrimera
//
//  Created by Esther Gordo Ramos on 17/12/13.
//  Copyright (c) 2013 RegletApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EGViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *unoButtonOutlet;
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

@end
