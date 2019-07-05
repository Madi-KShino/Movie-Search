//
//  MKSMovieController.m
//  Movie(ObjC)
//
//  Created by Madison Kaori Shino on 7/5/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

#import "MKSMovieController.h"

//SET URL STRINGS
static NSString * const baseURLString = @"https://api.themoviedb.org";
static NSString * const pathString = @"3";
static NSString * const pathSearchString = @"search";
static NSString * const pathSearchTypeString = @"movie";
static NSString * const apiKeyString = @"api_key";
static NSString * const apiValueString = @"2edd94ba9756a40627eea1eddc4d0007";
static NSString * const searchQueryString = @"query";
static NSString * const imageUrlString = @"https://image.tmdb.org/t/p/w500";

@implementation MKSMovieController

//SHARED INSTANCE IMPLEMENTATION
+ (instancetype)sharedInstance
{
    static MKSMovieController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [MKSMovieController new];
    });
    return sharedInstance;
}

//IMPLEMENT FETCH MOVIE
- (void)fetchMovieFromSearch:(NSString *)searchTerm completion:(void (^)(NSArray<MKSMovie *> *))completion
{
    //BUILD URL
    NSURL *url = [NSURL URLWithString:baseURLString];
    NSURL *urlWithPathComponents = [[[url URLByAppendingPathComponent:pathString] URLByAppendingPathComponent:pathSearchString] URLByAppendingPathComponent:pathSearchTypeString];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:urlWithPathComponents resolvingAgainstBaseURL:true];
    NSURLQueryItem *urlWithApiKey = [[NSURLQueryItem alloc] initWithName:apiKeyString value:apiValueString];
    NSURLQueryItem *urlWithQuery = [[NSURLQueryItem alloc] initWithName:searchQueryString value:searchTerm];
    urlComponents.queryItems = @[urlWithApiKey, urlWithQuery];
    NSURL *finalURL = urlComponents.URL;
    NSLog(@"%@", finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
      {
          if (error)
          {
              NSLog(@"There was an issue with the URL: %@, %@", error, [error localizedDescription]);
              completion(nil);
              return;
          }
          
          if (data)
          {
              NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
              NSArray *secondLevel = topLevelDictionary[@"results"];
              
              if (!topLevelDictionary)
              {
                  NSLog(@"There was an issue parsing the JSON: %@, %@", error, [error localizedDescription]);
                  completion(nil);
                  return;
              }
              
              NSMutableArray *movieArray = [NSMutableArray new];
              
              for (NSDictionary *movieDictionary in secondLevel)
              {
                  MKSMovie *movie = [[MKSMovie alloc] initWithDictionary:movieDictionary];
                  [movieArray addObject:movie];
                  completion(movieArray);
              }
          }
      }]resume];
}


//IMPLEMENT FETCH IMAGE
- (void)fetchImageForMovie:(MKSMovie *)movie completion:(void (^)(UIImage *))completion
{
    //BUILD URL
    NSURL *baseURL = [NSURL URLWithString:imageUrlString];
    NSURL *imageURL = [baseURL URLByAppendingPathComponent:movie.movieImage];
    NSLog(@"%@", imageURL);
    
    //FETCH IMAGE
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
      {
          if (error)
          {
              NSLog(@"Error fetching post: %@, %@", error, [error localizedDescription]);
              completion(nil);
              return;
          }
          
          if (!data)
          {
              NSLog(@"Error with post data: %@, %@", error, [error localizedDescription]);
              completion(nil);
              return;
          }
          
          UIImage *image = [UIImage imageWithData:data];
          completion(image);
          
      }]resume];
}


@end
