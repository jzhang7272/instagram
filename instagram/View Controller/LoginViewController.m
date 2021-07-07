//
//  LoginViewController.m
//  instagram
//
//  Created by Josey Zhang on 7/6/21.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end

@implementation LoginViewController

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.gradientLayer.frame = self.view.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:76.0/255.0 green:104.0/255.0 blue:215.0/255.0 alpha:0.50] CGColor],(id)[[UIColor colorWithRed:138.0/255.0 green:58.0/255.0 blue:185.0/255.0 alpha:0.50] CGColor],(id)[[UIColor colorWithRed:205/255.0 green:72.0/255.0 blue:107/255.0 alpha:0.50] CGColor],(id)[[UIColor colorWithRed:252/255.0 green:204/255.0 blue:99/255.0 alpha:0.50] CGColor], nil];
    [self.view.layer insertSublayer:self.gradientLayer atIndex:0];
    
//    UIView *gradientView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.frame = gradientView.bounds;
//    gradient.colors = @[(id)[UIColor whiteColor].CGColor, (id)[UIColor blackColor].CGColor];
//    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:34.0/255.0 green:211/255.0 blue:198/255.0 alpha:1.0] CGColor],(id)[[UIColor colorWithRed:145/255.0 green:72.0/255.0 blue:203/255.0 alpha:1.0] CGColor], nil];
//    [gradientView.layer insertSublayer:gradient atIndex:1];
//    if (PFUser.currentUser){
//        [self performSegueWithIdentifier:@"loginSegue" sender:nil];
//    }

}
- (IBAction)onLogIn:(id)sender {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
        
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Login Failed" message:@"Username or password incorrect." preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else {
            NSLog(@"User logged in successfully");
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
            
        }
    }];
}

- (IBAction)onSignUp:(id)sender {
    PFUser *newUser = [PFUser user];
    
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Sign Up Failed" message:@"Try a different username and password." preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            NSLog(@"User registered successfully");
            
        }
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
