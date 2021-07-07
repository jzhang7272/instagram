//
//  LoginViewController.m
//  instagram
//
//  Created by Josey Zhang on 7/6/21.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "User.h"

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
            [User createUser:@"Add a bio!" withCompletion:^(BOOL succeeded, NSError * error) {
                if (succeeded) {
                    NSLog(@"User created.");
                } else {
                    NSLog(@"Problem creating user: %@", error.localizedDescription);
                }
            }];
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
