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
#import <QuartzCore/QuartzCore.h>
#import "ProfileHeaderView.h"
#import "EditProfileViewController.h"

const int ROUNDED_RADIUS = 10;
const int SPACING = 5;
const CGFloat POSTS_PER_ROW = 3;
const int QUERY = 20;
const float HEADER_SPACING = 8 + 15 + 5 + 10;

@interface ProfileViewController () <UIPageViewControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *postArray;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) UIImageView *tempimage;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.user = PFUser.currentUser;
    
    [self fetchUser];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;
    layout.minimumLineSpacing = SPACING;
    layout.minimumInteritemSpacing = SPACING;
    CGFloat itemWidth = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing * (POSTS_PER_ROW - 1)) / POSTS_PER_ROW;
    CGFloat itemHeight = itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchUser];
}

- (void)didUpdate:(User *)user :(UIImageView *)image{
    self.user = user;
    self.tempimage = image;
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 1)]];

}

- (void)fetchUser {
    PFQuery *postQuery = [PFQuery queryWithClassName:@"Post"];
    [postQuery whereKey:@"author" equalTo:PFUser.currentUser];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = QUERY;

    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> *posts, NSError *error) {
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

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        ProfileHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        headerView.editButton.layer.cornerRadius = ROUNDED_RADIUS;
        headerView.editButton.clipsToBounds = YES;
        [headerView.editButton addTarget:self
                     action:@selector(editProfile)
           forControlEvents:UIControlEventTouchUpInside];
        
        NSURL *imageURL = [NSURL URLWithString:self.user.image.url];
        if (imageURL != nil){
            [headerView.profilePictureView setImageWithURL:imageURL];
        }
        if (self.tempimage != nil){
            headerView.profilePictureView.image = self.tempimage.image;
        }
        headerView.profilePictureView.layer.cornerRadius = headerView.profilePictureView.frame.size.width / 2;;
        headerView.profilePictureView.layer.masksToBounds = YES;
        headerView.userLabel.text = self.user.username;
        headerView.bioLabel.text = self.user.bio;
        
        reusableview = headerView;
    }
    return reusableview;
}

- (void)editProfile{
    [self performSegueWithIdentifier:@"editSegue" sender:nil];
}



#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"editSegue"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        EditProfileViewController *editController = (EditProfileViewController*)navigationController.topViewController;
        editController.delegate = self;
    }
}


@end
