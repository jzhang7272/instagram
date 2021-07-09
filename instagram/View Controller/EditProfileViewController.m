//
//  EditProfileViewController.m
//  instagram
//
//  Created by Josey Zhang on 7/8/21.
//

#import "EditProfileViewController.h"
#import "User.h"
#import <Parse/Parse.h>
#import "UIImageView+AFNetworking.h"

const int RADIUS = 15;

@interface EditProfileViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UITextView *bioText;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (strong, nonatomic) UIImagePickerController *imagePickerVC;
@property (strong, nonatomic) User *user;

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.saveButton.layer.cornerRadius = RADIUS;
    self.saveButton.clipsToBounds = YES;
    self.cancelButton.layer.cornerRadius = RADIUS;
    self.cancelButton.clipsToBounds = YES;
    self.user = PFUser.currentUser;
    
    self.bioText.delegate = self;
    self.bioText.text = @"Change your bio!";
    self.bioText.textColor = [UIColor lightGrayColor];
    
    if (self.user.image != nil) {
        NSURL *imageURL = [NSURL URLWithString:self.user.image.url];
        [self.photoView setImageWithURL:imageURL];
    }
    
    self.imagePickerVC = [UIImagePickerController new];
    self.imagePickerVC.delegate = self;
    self.imagePickerVC.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera not available so we will use photo library instead");
        self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    // User taps on photo to upload photo
    UITapGestureRecognizer *photoTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(uploadTakePhoto:)];
    [self.photoView addGestureRecognizer:photoTapGestureRecognizer];
    [self.photoView setUserInteractionEnabled:YES];
}

- (void)uploadTakePhoto:(UITapGestureRecognizer *)sender{
    [self presentViewController:self.imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    self.photoView.image = (editedImage != nil) ? editedImage : originalImage;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"Change your bio!"]) {
         textView.text = @"";
         textView.textColor = [UIColor blackColor];
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Change your bio!";
        textView.textColor = [UIColor lightGrayColor];
    }
    [textView resignFirstResponder];
}

- (IBAction)onTapSave:(id)sender {
//    NSLog(@"%d", [self.bioText.text isEqualToString:@"Change your bio!"]);
    if ([self.bioText.text isEqualToString:@""] == false && [self.bioText.text isEqualToString:@"Change your bio!"] == false){
        self.user.bio = self.bioText.text;
    }
    if (self.photoView.image != nil) {
        [User setProfileImage:self.user :self.photoView.image];
    }
    NSLog(@"%@", self.user.image);
    [self.delegate didUpdate:self.user :self.photoView];
    [self.user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (succeeded) {
            NSLog(@"User information updated.");
        } else {
            NSLog(@"Problem saving user info: %@", error.localizedDescription);
        }}];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)onTapCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
