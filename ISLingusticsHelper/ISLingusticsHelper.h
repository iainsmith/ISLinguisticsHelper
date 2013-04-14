//
//  ISLingusticsHelper.h
//  ISLingusticsHelper
//
//  Created by Iain Smith on 13/04/2013.
//  Copyright (c) 2013 mountain23. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 The ISLingusitcsHelper class provides a simple api for extracting different lingustic properties from strings for languages supported by NSLingustic tagger. This is useful for building search indexes and analysing patterns in user data. 
 
 An instance of ISLingusticsHelper holds a string to be analysed to reduce overhead in processing the same string for different properties.
 */

@interface ISLingusticsHelper : NSObject

/**
 The string to be analyzed.
 
 If you call init you must call setString yourself.
 
    ISLingusticsHelper *helper = [[ISLingusticsHelper alloc] init];
    [helper setString:(@"The string to be analysed")];
 */
@property (copy, nonatomic) NSString *string;

/**
 The designated initializer.
 
 @param string The string to be analyzed.
 
 If you call init, you must call setString youself.
 */
- (id)initWithString:(NSString *)string;

/**
 Creates and returns an array of nouns from the string.
 */
- (NSArray *)nouns;

/**
 Creates and returns an array containing the root word for each nouns from the string.
 */
- (NSArray *)rootLowerCaseNouns;

/**
 Creates and returns an array of verbs from the string.
 */
- (NSArray *)verbs;

/**
 Creates and returns an array of place names from the string.
 */
- (NSArray *)placeNames;

/**
 Creates and returns an array of personal names from the string.
 */
- (NSArray *)personalNames;

/**
 Creates and returns an array of words from the string.
 */
- (NSArray *)words;

/**
 Creates and returns an array of sentences from the string.
 */
- (NSArray *)sentences;

/**
 returns the standard abbreviation for the language of the string.
 */
- (NSString *)languageStandardAbbreviation;

@end
