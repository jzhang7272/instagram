//
//  ProfileViewController.m
//  instagram
//
//  Created by Josey Zhang on 7/7/21.
//

#import "ProfileViewController.h"
#import "ProfilePostCell.h"
#import <Parse/Parse.h>
#import "Post.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *profilePictureView;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (strong, nonatomic) NSMutableArray *postArray;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self fetchPosts];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    CGFloat postsPerRow = 3;
    CGFloat itemWidth = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing * (postsPerRow - 1)) / postsPerRow;
    CGFloat itemHeight = itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
    self.profilePictureView.image = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchPosts];
}

- (void)fetchPosts {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query whereKey:@"author" equalTo:PFUser.currentUser];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    query.limit = 20;

    [query findObjectsInBackgroundWithBlock:^(NSArray<Post *> *posts, NSError *error) {
        if (posts != nil) {
            self.postArray = [posts copy];
            [self.collectionView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ProfilePostCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"profilePostCell" forIndexPath:indexPath];
    Post *post = self.postArray[indexPath.row];
    cell.post = post;
    NSURL *imageURL = [NSURL URLWithString:post.image.url];
    [cell.photoView setImageWithURL:imageURL];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.postArray.count;
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
