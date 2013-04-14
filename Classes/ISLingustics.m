//
//  ISLingustics.m
//  ISLingustics
//
//  Created by Iain Smith on 13/04/2013.
//  Copyright (c) 2013 mountain23. All rights reserved.
//

#import "ISLingustics.h"
@interface ISLingustics ()
{
    NSLinguisticTagger *_tagger;
    NSString *_currentLanguage;
}

@property (strong, nonatomic) NSLinguisticTagger *tagger;
- (NSLinguisticTaggerOptions)options;
- (NSArray *)stringsFromString:(NSString *)string limitedToType:(NSString *)NSLingusticTagConstant forLanguague:(NSString *)languageStandardAbbreviation;
- (NSArray *)stringsFromString:(NSString *)string delimitedByUnit:(NSStringEnumerationOptions)unit;

@end

@implementation ISLingustics

- (id)init
{
    return [self initWithString:nil];
}

- (id)initWithString:(NSString *)string
{
    self = [super init];
    if (self) {
        self.string = string;
    }
    return self;
}

- (void)setString:(NSString *)string
{
    if (string != _string && string) {
        _string = string;
        _currentLanguage = CFBridgingRelease(CFStringTokenizerCopyBestStringLanguage((CFStringRef)(_string), CFRangeMake(0, string.length)));
        [self.tagger setString:_string];
    }
}

- (NSLinguisticTagger *)tagger
{
    if (!_tagger) {
        _tagger = [[NSLinguisticTagger alloc] initWithTagSchemes:[NSLinguisticTagger availableTagSchemesForLanguage:_currentLanguage] options:[self options]];
    }
    return _tagger;
}

- (NSLinguisticTaggerOptions)options {
    return NSLinguisticTaggerOmitPunctuation | NSLinguisticTaggerOmitWhitespace | NSLinguisticTaggerJoinNames;
}

- (NSString *)languageStandardAbbreviationFromString:(NSString *)string
{
    return _currentLanguage;
}

- (NSArray *)rootLowerCaseNounsForString;
{
    __block NSMutableArray *nouns = [NSMutableArray array];
    __block NSMutableArray *matchedNouns = [NSMutableSet set];
    __block NSMutableDictionary *matchedLemmas = [NSMutableDictionary dictionary];
    
    
    [self.tagger enumerateTagsInRange:NSMakeRange(0, self.string.length) scheme:NSLinguisticTagSchemeLemma options:[self options] usingBlock:^(NSString *tag, NSRange tokenRange, NSRange sentenceRange, BOOL *stop) {
        if (tag) {
            [matchedLemmas setObject:tag forKey:[NSValue valueWithRange:tokenRange]];
        }
    }];
    
    [self.tagger enumerateTagsInRange:NSMakeRange(0, self.string.length) scheme:NSLinguisticTagSchemeLexicalClass options:[self options] usingBlock:^(NSString *tag, NSRange tokenRange, NSRange sentenceRange, BOOL *stop) {
        if (tag == NSLinguisticTagNoun) {
            [matchedNouns addObject:[NSValue valueWithRange:tokenRange]];
        }
    }];
    
    [matchedNouns enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([matchedLemmas objectForKey:obj] ) {
            [nouns addObject:matchedLemmas[obj]];
        } else {
            [nouns addObject:[self.string substringWithRange:[(NSValue *)obj rangeValue]]];
        }
    }];
    
    return nouns;
}

- (NSArray *)stringsFromString:(NSString *)string delimitedByUnit:(NSStringEnumerationOptions)unit;
{
    __block NSMutableArray *words = [NSMutableArray array];
    
    [string enumerateSubstringsInRange:NSMakeRange(0, string.length) options:unit usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        substring = [substring stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [words addObject:substring];
    }];
    
    return words;
}

- (NSArray *)stringsFromString:(NSString *)string limitedToType:(NSString *)NSLingusticTagConstant forLanguague:(NSString *)languageStandardAbbreviation
{
    __block NSMutableArray *matches = [NSMutableArray array];
    
    [self.tagger enumerateTagsInRange:NSMakeRange(0, string.length) scheme:NSLinguisticTagSchemeNameTypeOrLexicalClass options:[self options] usingBlock:^(NSString *tag, NSRange tokenRange, NSRange sentenceRange, BOOL *stop) {
        if (tag == NSLingusticTagConstant) {
            NSString *match = [string substringWithRange:tokenRange];
            [matches addObject:match];
        }
    }];
    
    return matches;
}

- (NSArray *)wordsFromString;
{
    return [[[ISLingustics alloc] init] stringsFromString:self.string delimitedByUnit:NSStringEnumerationByWords];
}

- (NSArray *)sentencesFromString;
{
    return [[[ISLingustics alloc] init] stringsFromString:self.string delimitedByUnit:NSStringEnumerationBySentences];
}

- (NSArray *)nounsForString;
{
    return [self stringsFromString:self.string limitedToType:NSLinguisticTagNoun forLanguague:_currentLanguage];
}

- (NSArray *)verbsForString;
{
    return [self stringsFromString:self.string limitedToType:NSLinguisticTagVerb forLanguague:_currentLanguage];
}

- (NSArray *)placeNamesForString;
{
    return [self stringsFromString:self.string limitedToType:NSLinguisticTagPlaceName forLanguague:_currentLanguage];
}

- (NSArray *)personalNamesFromString;
{
    return [self stringsFromString:self.string limitedToType:NSLinguisticTagPersonalName forLanguague:_currentLanguage];
}

@end
