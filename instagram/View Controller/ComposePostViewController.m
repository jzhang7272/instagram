//
//  PostViewController.m
//  instagram
//
//  Created by Josey Zhang on 7/6/21.
//

#import "ComposePostViewController.h"
#import "Post.h"

const int RESIZE = 350;

@interface ComposePostViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (strong, nonatomic) UIImagePickerController *imagePickerVC;
@property (weak, nonatomic) IBOutlet UITextView *postText;

@end

@implementation ComposePostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.postText.delegate = self;
    self.postText.text = @"Add a caption!";
    self.postText.textColor = [UIColor lightGrayColor];
    
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
    if ([textView.text isEqualToString:@"Add a caption!"]) {
         textView.text = @"";
         textView.textColor = [UIColor blackColor];
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Add a caption!";
        textView.textColor = [UIColor lightGrayColor];
    }
    [textView resignFirstResponder];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (IBAction)closePost:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)sharePost:(id)sender {
    [Post postUserImage:[self resizeImage:self.photoView.image withSize:CGSizeMake(RESIZE, RESIZE)] withCaption:self.postText.text withCompletion:^(BOOL succeeded, NSError * error) {
        if (succeeded) {
            NSLog(@"The post was saved.");
        } else {
            NSLog(@"Problem saving post: %@", error.localizedDescription);
        }
    }];
    
    [self dismissViewControllerAnimated:true completion:nil];
}


@end
