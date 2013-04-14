//
//  ISLingustics.h
//  ISLingustics
//
//  Created by Iain Smith on 13/04/2013.
//  Copyright (c) 2013 mountain23. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 The `ISLingusitcs' class provides a nice api for extracting different lingustic properties from strings for languages supported by nslingustic tagger. This is useful for building search indexes and analysing patterns in user data. ISLingustics holds the last previous  string for a specific country to reduce overhead in processing the same string for different properties.
 */

@interface ISLingustics : NSObject

@property (copy, nonatomic) NSString *string;

/**
 designated initializer
 */
- (id)initWithString:(NSString *)string;

/**
 creates and returns an array of nouns from the string, for the given language.
 
 @param string The string you want to get the nouns from. This arguments must not be nil

 @param languageStandardAbbreviation
 
 @return 
 */

- (NSArray *)nounsForString;

- (NSArray *)rootLowerCaseNounsForString;

- (NSArray *)verbsForString;

- (NSArray *)placeNamesForString;

- (NSArray *)personalNamesFromString;

- (NSArray *)wordsFromString;

- (NSArray *)sentencesFromString;

- (NSString *)languageStandardAbbreviationFromString:(NSString *)string;

@end
