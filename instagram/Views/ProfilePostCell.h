//
//  ProfilePostCell.h
//  instagram
//
//  Created by Josey Zhang on 7/7/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfilePostCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@property (strong, nonatomic) Post *post;
@end

NS_ASSUME_NONNULL_END
