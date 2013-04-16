//
//  NSString+ISLingusitics.m
//  ISLingusitics
//
//  Created by Iain Smith on 14/04/2013.
//  Copyright (c) 2013 mountain23. All rights reserved.
//

#import "NSString+ISLinguistics.h"

@implementation NSString (ISLinguistics)

#pragma mark - Interanl Methods

- (void)enumerateByUnit:(NSEnumerationOptions)unit UsingBlock_is:(void (^)(NSString *string, BOOL *stop))block {
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:unit usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        substring = [substring stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        block(substring, stop);
    }];
}

- (void)enumerateByWordType:(NSString *)type withBlock_is:(void (^)(NSString *word, BOOL *stop))block;
{
    NSLinguisticTaggerOptions options = NSLinguisticTaggerOmitPunctuation | NSLinguisticTaggerOmitWhitespace | NSLinguisticTaggerJoinNames;
    
    NSString *language =  CFBridgingRelease(CFStringTokenizerCopyBestStringLanguage((CFStringRef)self, CFRangeMake(0, MIN(self.length, 100))));
    
    NSLinguisticTagger *tagger = [[NSLinguisticTagger alloc] initWithTagSchemes:[NSLinguisticTagger availableTagSchemesForLanguage:language] options:options];
    [tagger setString:self];
    [tagger enumerateTagsInRange:NSMakeRange(0, self.length) scheme:NSLinguisticTagSchemeLexicalClass options:options usingBlock:^(NSString *tag, NSRange tokenRange, NSRange sentenceRange, BOOL *stop) {
        if ([tag isEqualToString:type]) {
            block([self substringWithRange:tokenRange], stop);
        }
    }];
}

#pragma mark - Public Methods

- (void)enumerateWordsUsingBlock_is:(void (^)(NSString *word, BOOL *stop))block {
    [self enumerateByUnit:NSStringEnumerationByWords UsingBlock_is:block];
}

- (void)enumerateSentencesUsingBlock_is:(void (^)(NSString *sentence, BOOL *stop))block {
    [self enumerateByUnit:NSStringEnumerationBySentences UsingBlock_is:block];
}

- (void)enumerateNounsUsingBlock_is:(void (^)(NSString *noun, BOOL *stop))block
{
    [self enumerateByWordType:NSLinguisticTagNoun withBlock_is:block];
}

- (void)enumerateVerbsUsingBlock_is:(void (^)(NSString *verb, BOOL *stop))block;
{
    [self enumerateByWordType:NSLinguisticTagVerb withBlock_is:block];
}

@end
