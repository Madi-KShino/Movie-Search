//
//  MKSMovie.m
//  Movie(ObjC)
//
//  Created by Madison Kaori Shino on 7/5/19.
//  Copyright © 2019 Madi S. All rights reserved.
//
#import "MKSMovie.h"

//STRINGS FOR KEYS
static NSString * const titleKey = @"original_title";
static NSString * const dateKey = @"release_date";
static NSString * const summaryKey = @"overview";
static NSString * const imageKey = @"poster_path";
static NSString * const ratingKey = @"vote_average";

//INITIALIZE MOVIE PROPERTIES
@implementation MKSMovie

- (instancetype)initMovieWithTitle:(NSString *)movieTitle movieDate:(NSString *)movieDate movieSummary:(NSString *)movieSummary movieImage:(NSString *)movieImage movieRating:(float)movieRating
{
    self = [super init];
    if (self)
    {
        _movieTitle = movieTitle;
        _movieDate = movieDate;
        _movieSummary = movieSummary;
        _movieImage = movieImage;
        _movieRating = movieRating;
    }
    return self;
}

@end

//INITIALIZE CONVENIENCE INIT
@implementation MKSMovie (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString *title = dictionary[titleKey];
    NSString *date = dictionary[dateKey];
    NSString *summary = dictionary[summaryKey];
    NSString *image = dictionary[imageKey];
    float rating = [dictionary[ratingKey]floatValue];
    
    //HANDLE OPTIONAL IMAGES
    if ([image isKindOfClass:[NSNull class]])
    {
        image = nil;
    }
    
    return [self initMovieWithTitle:title movieDate:date movieSummary:summary movieImage:image movieRating:rating];
}

@end
