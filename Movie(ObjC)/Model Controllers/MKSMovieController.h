//
//  MKSMovieController.h
//  Movie(ObjC)
//
//  Created by Madison Kaori Shino on 7/5/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MKSMovie.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKSMovieController : NSObject

//SINGLETON - SHARED INSTANCE
+(instancetype)sharedInstance;

//CREATE MOVIES (FETCH DATA & IMAGE)
-(void)fetchMovieFromSearch:(NSString *)searchTerm completion:(void (^)(NSArray<MKSMovie *> * _Nullable movie))completion;
-(void)fetchImageForMovie:(MKSMovie *)movie completion:(void(^) (UIImage * _Nullable))completion;

@end

NS_ASSUME_NONNULL_END
