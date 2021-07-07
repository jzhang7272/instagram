//
//  User.m
//  instagram
//
//  Created by Josey Zhang on 7/7/21.
//

#import "User.h"

@implementation User

@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic biography;
@dynamic image;

+ (nonnull NSString *)parseClassName {
    return @"User";
}

+ (void) createUser: (NSString *_Nullable)bio withCompletion: (PFBooleanResultBlock  _Nullable)completion{
    User *newUser = [User new];
    newUser.author = [PFUser currentUser];
    newUser.biography = bio;
    
    [newUser saveInBackgroundWithBlock: completion];
}

+ (void)setProfileImage:(User *)user :(UIImage *)image{
    NSData *imageData = UIImagePNGRepresentation(image);
    user.image = [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

@end


