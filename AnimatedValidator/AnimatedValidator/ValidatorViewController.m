//
//  ValidatorViewController.m
//  AnimatedValidator
//
//  Created by Al Tyus on 5/12/14.
//  Copyright (c) 2014 al-tyus.com. All rights reserved.
//

#import "ValidatorViewController.h"
#import "Constants.h" 

@interface ValidatorViewController ()

@property (nonatomic, weak) IBOutlet UITextField *emailTextField;
@property (nonatomic, weak) IBOutlet UITextField *emailConfirmTextField;
@property (nonatomic, weak) IBOutlet UITextField *phoneTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordConfirmTextField;

@end

@implementation ValidatorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.emailTextField.accessibilityLabel = EMAILTEXTFIELD;
    self.emailConfirmTextField.accessibilityLabel = EMAILCONFIRMTEXTFIELD;
    self.phoneTextField.accessibilityLabel = PHONETEXTFIELD;
    self.passwordTextField.accessibilityLabel = PASSWORDTEXTFIELD;
    self.passwordConfirmTextField.accessibilityLabel = PASSWORDCONFIRMTEXTFIELD;
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
