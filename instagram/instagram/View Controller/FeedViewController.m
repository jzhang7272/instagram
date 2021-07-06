//
//  FeedViewController.m
//  instagram
//
//  Created by Josey Zhang on 7/6/21.
//

#import "FeedViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "PostCell.h"
#import "Post.h"
#import "UIImageView+AFNetworking.h"

@interface FeedViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *postArray;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self fetchPosts];
}

- (void)fetchPosts {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    query.limit = 20;

    [query findObjectsInBackgroundWithBlock:^(NSArray<Post *> *posts, NSError *error) {
        if (posts != nil) {
            self.postArray = [posts copy];
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}
- (IBAction)onLogOut:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"User log out failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged out successfully. PFUser.current() will now be nil.");
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            [self presentViewController:loginVC animated:TRUE completion:nil];
        }
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    Post *post = self.postArray[indexPath.row];
    
//    [post fetchIfNeededInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
    cell.usernameLabel.text = post.author.username;
    NSURL *imageURL = [NSURL URLWithString:post.image.url];
    [cell.photoView setImageWithURL:imageURL];
    cell.likeCountLabel.text = [NSString stringWithFormat:@"%@ likes", post.likeCount];
    cell.captionLabel.text = post.caption;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
