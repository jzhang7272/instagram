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

const int ROUNDED_RADIUS = 10;
const int SPACING = 5;
const CGFloat POSTS_PER_ROW = 3;
const int QUERY = 20;
const float HEADER_SPACING = 8 + 15 + 5 + 10;

@interface ProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *postArray;
@property (strong, nonatomic) User *user;
@property (nonatomic) CGSize headerSize;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.user = PFUser.currentUser;
    
    [self fetchUser];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;
//    layout.headerReferenceSize = CGSizeMake(0, 150);
    layout.minimumLineSpacing = SPACING;
    layout.minimumInteritemSpacing = SPACING;
    CGFloat itemWidth = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing * (POSTS_PER_ROW - 1)) / POSTS_PER_ROW;
    CGFloat itemHeight = itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section{
    self.headerSize = CGSizeMake(0, 150);
    return self.headerSize;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchUser];
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
            headerView.profilePictureView.layer.cornerRadius = headerView.profilePictureView.frame.size.width / 2;;
            headerView.profilePictureView.layer.masksToBounds = YES;
        }
        headerView.userLabel.text = self.user.username;
        headerView.bioLabel.text = self.user.bio;
        
        int height = headerView.userLabel.frame.size.height + headerView.bioLabel.frame.size.height + headerView.editButton.frame.size.height + HEADER_SPACING;
        NSLog(@"hi");
        NSLog(@"height: %i", height);
        self.headerSize = CGSizeMake(0, height);
        
        reusableview = headerView;
    }
    return reusableview;
}

- (void)editProfile{
    [self performSegueWithIdentifier:@"editSegue" sender:nil];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
