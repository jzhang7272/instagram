//
//  PostDetailsViewController.m
//  instagram
//
//  Created by Josey Zhang on 7/7/21.
//

#import "PostDetailsViewController.h"
#import <Parse/Parse.h>
#import "Post.h"
#import "PostDetailsCell.h"
#import "UIImageView+AFNetworking.h"
#import "DateTools.h"

@interface PostDetailsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PostDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView reloadData];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostDetailsCell"];
    if (indexPath.row == 0){
        cell.usernameLabel.text = self.post.author.username;
        NSURL *imageURL = [NSURL URLWithString:self.post.image.url];
        [cell.photoView setImageWithURL:imageURL];
        cell.likeCountLabel.text = [NSString stringWithFormat:@"%@ likes", self.post.likeCount];
        cell.captionLabel.text = self.post.caption;
        cell.timestampLabel.text = [self getTimeStamp:self.post.createdAt];
    }
    return cell;
}

- (NSString *)getTimeStamp:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDate *current = [NSDate date];
    NSInteger yearsApart = [date yearsFrom:current];
    NSInteger monthsApart = [date monthsFrom:current];
    NSInteger daysApart = [date daysFrom:current];
    NSInteger hoursApart = [date hoursFrom:current];
    NSInteger minutesApart = [date minutesFrom:current];
    NSInteger secondsApart = [date secondsFrom:current];
    if (yearsApart > 0){
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        return [formatter stringFromDate:date];
    }
    else if (monthsApart > 0){
        NSDate *timeAgoDate = [NSDate dateWithTimeIntervalSinceNow:monthsApart];
        return timeAgoDate.shortTimeAgoSinceNow;
    }
    else if (daysApart > 0){
        NSDate *timeAgoDate = [NSDate dateWithTimeIntervalSinceNow:daysApart];
        return timeAgoDate.shortTimeAgoSinceNow;
    }
    else if (hoursApart > 0){
        NSDate *timeAgoDate = [NSDate dateWithTimeIntervalSinceNow:hoursApart];
        return timeAgoDate.shortTimeAgoSinceNow;
    }
    else if (minutesApart > 0){
        NSDate *timeAgoDate = [NSDate dateWithTimeIntervalSinceNow:minutesApart];
        return timeAgoDate.shortTimeAgoSinceNow;
    }
    else{
        NSDate *timeAgoDate = [NSDate dateWithTimeIntervalSinceNow:secondsApart];
        return timeAgoDate.shortTimeAgoSinceNow;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
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
