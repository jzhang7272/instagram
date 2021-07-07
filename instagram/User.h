//
//  User.h
//  instagram
//
//  Created by Josey Zhang on 7/7/21.
//

#import "Parse/Parse.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) PFUser *author;

@property (nonatomic, strong) NSString *biography;
@property (nonatomic, strong) PFFileObject *image;
@property (nonatomic, strong) NSMutableArray *posts;

+ (void) createUser: (NSString *_Nullable)bio withCompletion: (PFBooleanResultBlock  _Nullable)completion;

+ (void)setProfileImage:(User *)user :(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
