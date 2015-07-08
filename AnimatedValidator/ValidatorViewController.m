//
//  ValidatorViewController.m
//  AnimatedValidator
//
//  Created by Al Tyus on 5/12/14.
//  Copyright (c) 2014 al-tyus.com. All rights reserved.
//

#import "ValidatorViewController.h"
#import "Constants.h"

@interface ValidatorViewController ()<UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *emailTextField;
@property (nonatomic, weak) IBOutlet UITextField *emailConfirmTextField;
@property (nonatomic, weak) IBOutlet UITextField *phoneTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordConfirmTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (nonatomic) NSInteger count;
@property (nonatomic, strong) NSArray *arrayOfFields;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *submitButtonSpaceConstant;



@end

@implementation ValidatorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.submitButton.accessibilityLabel = SUBMITBUTTON;
    self.emailTextField.accessibilityLabel = EMAILTEXTFIELD;
    self.emailConfirmTextField.accessibilityLabel = EMAILCONFIRMTEXTFIELD;
    self.phoneTextField.accessibilityLabel = PHONETEXTFIELD;
    self.passwordTextField.accessibilityLabel = PASSWORDTEXTFIELD;
    self.passwordConfirmTextField.accessibilityLabel = PASSWORDCONFIRMTEXTFIELD;
    
    self.count = 0;
    self.emailTextField.delegate = self;
    self.emailConfirmTextField.delegate = self;
    self.phoneTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.passwordConfirmTextField.delegate = self;
    
    self.arrayOfFields = @[self.emailTextField, self.emailConfirmTextField, self.phoneTextField, self.passwordTextField, self.passwordConfirmTextField];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.emailTextField)
    {
        if ([self validateEmail:textField.text])
        {
            [textField resignFirstResponder];
            self.count ++;
            [self nextTextField];
        }
        else
        {
            [self pulseTextFieldIfInvalid:textField];
        }
    }
    else if (textField == self.emailConfirmTextField)
    {
        if ([self confirmEmail:textField.text])
        {
            [textField resignFirstResponder];
            self.count ++;
            [self nextTextField];
        }
        else
        {
            [self pulseTextFieldIfInvalid:textField];
        }
    }
    else if (textField == self.phoneTextField)
    {
        if ([self validatePhone:textField.text])
        {
            [textField resignFirstResponder];
            self.count ++;
            [self nextTextField];
        }
        else
        {
            [self pulseTextFieldIfInvalid:textField];
        }
    }
    else if (textField == self.passwordTextField)
    {
        if ([self validatePassword:textField.text])
        {
            [textField resignFirstResponder];
            self.count ++;
            [self nextTextField];
        }
        else
        {
            [self pulseTextFieldIfInvalid:textField];
        }
    }
    else if (textField == self.passwordConfirmTextField)
    {
        if ([self confirmPassword:textField.text])
        {
            [textField resignFirstResponder];
            [self animateSubmitButton];
        }
        else
        {
            [self pulseTextFieldIfInvalid:textField];
        }
    }
    return NO;
}

-(void)nextTextField
{
    UITextField *nextField = self.arrayOfFields[self.count];
    nextField.enabled = YES;
    [nextField becomeFirstResponder];
}

-(BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    //  return 0;
    return [emailTest evaluateWithObject:email];
}

-(BOOL)confirmEmail:(NSString *)emailToConfirm
{
    if ([emailToConfirm isEqualToString:self.emailTextField.text])
    {
        return YES;
    }
    return NO;
}

-(BOOL)validatePhone:(NSString *)phone
{
    NSCharacterSet *phoneValidatorSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789+"]invertedSet];
    
    if ([phone rangeOfCharacterFromSet:phoneValidatorSet].location != NSNotFound || phone.length < 7)
    {
        return NO;
    }
    return YES;
}

-(BOOL)validatePassword:(NSString *)password
{
    if (self.passwordTextField.text.length > 6)
    {
        return YES;
    }
    return NO;
}

-(BOOL)confirmPassword:(NSString *)passwordToConfirm
{
    if ([passwordToConfirm isEqualToString:self.passwordTextField.text])
    {
        return YES;
    }
    return NO;
}

-(void)pulseTextFieldIfInvalid:(UITextField *)textField
{
    [UIView animateWithDuration:1.0 animations:^{
        textField.transform = CGAffineTransformMakeScale(1.1, 1.1);
        
        textField.layer.cornerRadius = 8.0f;
        textField.layer.borderWidth = 1.0f;
        textField.layer.borderColor = [[UIColor redColor]CGColor];
    }
    completion:^(BOOL finished)
    {
        [UIView animateWithDuration:1.0 animations:^{
            textField.transform = CGAffineTransformMakeScale(1.0, 1.0);
            textField.layer.cornerRadius = 0.0f;
            textField.layer.borderColor = [[UIColor clearColor]CGColor];
        }];
        
    }];
}

-(void)animateSubmitButton
{
    [UIView animateWithDuration:2 animations:^{
        self.submitButtonSpaceConstant.constant = -150.0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.submitButton.hidden = NO;
        self.submitButton.enabled = YES;
    }];
}

@end
