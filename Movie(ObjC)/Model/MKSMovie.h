//
//  MKSMovie.h
//  Movie(ObjC)
//
//  Created by Madison Kaori Shino on 7/5/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//DECLARE CLASS PROPERTIES
@interface MKSMovie : NSObject

@property (nonatomic, readonly, copy) NSString *movieTitle;
@property (nonatomic, readonly, copy) NSString *movieDate;
@property (nonatomic, readonly, copy) NSString *movieSummary;
@property (nonatomic, readonly, copy, nullable) NSString *movieImage;
@property (nonatomic, readonly) NSNumber *movieRating;

-(instancetype)initMovieWithTitle:(NSString *)movieTitle
                        movieDate:(NSString *)movieDate
                     movieSummary:(NSString *)movieSummary
                       movieImage:(NSString *)movieImage
                      movieRating:(NSNumber *)movieRating;

@end

//DECLARE DICTIONARY CONVENIENCE INITIALIZER
@interface MKSMovie (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary;

@end


NS_ASSUME_NONNULL_END

