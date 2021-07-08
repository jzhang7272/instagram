//
//  User.m
//  instagram
//
//  Created by Josey Zhang on 7/7/21.
//

#import "User.h"

@implementation User

@dynamic username;
@dynamic bio;
@dynamic image;

+ (void)setProfileImage:(User *)user :(UIImage *)image{
    NSData *imageData = UIImagePNGRepresentation(image);
    user.image = [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

@end


