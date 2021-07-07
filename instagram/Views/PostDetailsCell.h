//
//  PostDetailsCell.h
//  instagram
//
//  Created by Josey Zhang on 7/7/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

//@protocol PostDetailsDelegate;

@interface PostDetailsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;

@property (strong, nonatomic) Post *post;

//@property (nonatomic, weak) id<PostDetailsDelegate> delegate;

@end

//@protocol PostDetailsDelegate
//- (void)updateFeed;
//@end

NS_ASSUME_NONNULL_END
