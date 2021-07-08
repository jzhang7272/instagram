//
//  User.h
//  instagram
//
//  Created by Josey Zhang on 7/7/21.
//

#import "Parse/Parse.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : PFUser

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *bio;
@property (nonatomic, strong) PFFileObject *image;

+ (void)setProfileImage:(User *)user :(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
