//
//  PostDetailsCell.m
//  instagram
//
//  Created by Josey Zhang on 7/7/21.
//

#import "PostDetailsCell.h"

@implementation PostDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)onTapLike:(id)sender {
    if ([self.post.likesArray containsObject:PFUser.currentUser.objectId]){
        [self.likeButton setSelected:NO];
        [self.post removeObject:PFUser.currentUser.objectId forKey:@"likesArray"];
        self.post.likeCount = [NSNumber numberWithInt:([self.post.likeCount intValue] - 1)];
    }
    else{
        [self.likeButton setSelected:YES];
        [self.post addObject:PFUser.currentUser.objectId forKey:@"likesArray"];
        self.post.likeCount = [NSNumber numberWithInt:([self.post.likeCount intValue] + 1)];
    }
    self.likeCountLabel.text = [NSString stringWithFormat:@"%@ likes", self.post.likeCount];
    [self.post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (succeeded) {
            NSLog(@"The post was saved.");
        } else {
            NSLog(@"Problem saving post: %@", error.localizedDescription);
        }}];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
