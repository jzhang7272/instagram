//
//  PostViewController.m
//  instagram
//
//  Created by Josey Zhang on 7/6/21.
//

#import "PostViewController.h"
#import "Post.h"

const int resize = 100;

@interface PostViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (strong, nonatomic) UIImagePickerController *imagePickerVC;
@property (weak, nonatomic) IBOutlet UITextView *postText;

@end

@implementation PostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(uploadTakePhoto:)];
    [self.view addGestureRecognizer:profileTapGestureRecognizer];
    [self.view setUserInteractionEnabled:YES];
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
    [Post postUserImage:[self resizeImage:self.photoView.image withSize:CGSizeMake(resize, resize)] withCaption:self.postText.text withCompletion:^(BOOL succeeded, NSError * error) {
        if (succeeded) {
            NSLog(@"The post was saved.");
        } else {
            NSLog(@"Problem saving post: %@", error.localizedDescription);
        }
    }];
    
    [self dismissViewControllerAnimated:true completion:nil];
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
