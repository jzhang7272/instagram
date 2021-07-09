//
//  EditProfileViewController.h
//  instagram
//
//  Created by Josey Zhang on 7/8/21.
//

#import <UIKit/UIKit.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@protocol EditProfileViewControllerDelegate

- (void)didUpdate:(User *)user :(UIImageView *)image;

@end

@interface EditProfileViewController : UIViewController

@property (nonatomic, weak) id<EditProfileViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
