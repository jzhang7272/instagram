//
//  ProfileHeaderView.h
//  instagram
//
//  Created by Josey Zhang on 7/8/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileHeaderView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIImageView *profilePictureView;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;
@property (weak, nonatomic) IBOutlet UIButton *addProfileButton;

@end

NS_ASSUME_NONNULL_END
