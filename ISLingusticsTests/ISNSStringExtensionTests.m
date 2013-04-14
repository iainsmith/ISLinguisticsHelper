//
//  ISNSStringExtensionTests.m
//  ISLingustics
//
//  Created by Iain Smith on 14/04/2013.
//  Copyright (c) 2013 mountain23. All rights reserved.
//

#import "ISNSStringExtensionTests.h"
#import "NSString+ISLingustics.h"

@implementation ISNSStringExtensionTests

- (void)testEnumerationByWords
{
    __block NSMutableArray *words = [NSMutableArray array];
    [@"this string has five words" enumerateWordsUsingBlock_is:^(NSString *word, BOOL *stop) {
        [words addObject:word];
    }];
    
    STAssertTrue(words.count == 5, nil);
    STAssertTrue([words[0] isEqualToString:@"this"], nil);
}

- (void)testEnumerationBySentences
{
    __block NSMutableArray *sentences = [NSMutableArray array];
    [@"this string has Two sentences. Check this out." enumerateSentencesUsingBlock_is:^(NSString *word, BOOL *stop) {
        [sentences addObject:word];
    }];
    
    STAssertTrue(sentences.count == 2, @"count should be 2, was:%i", sentences.count);
    STAssertTrue([sentences[0] isEqualToString:@"this string has Two sentences."], nil);

}

- (void)testEnumerationByNouns
{
    __block NSMutableArray *nouns = [NSMutableArray array];
    [@"this string has two nouns." enumerateNounsUsingBlock_is:^(NSString *word, BOOL *stop) {
        [nouns addObject:word];
    }];
    
    STAssertTrue(nouns.count == 2, @"count should be 2, was:%i", nouns.count);
    STAssertTrue([nouns[0] isEqualToString:@"string"], @"Expected noun to be: string , was :%@", nouns[0]);
    STAssertTrue([nouns[1] isEqualToString:@"nouns"], @"Expected noun to be: noun , was :%@", nouns[0]);

}

- (void)testEnumerationByVerbs
{
    __block NSMutableArray *verbs = [NSMutableArray array];
    [@"this string has three verbs. I am playing football." enumerateVerbsUsingBlock_is:^(NSString *word, BOOL *stop) {
        [verbs addObject:word];
    }];
    
    STAssertTrue(verbs.count == 3, @"count should be 3, was:%i", verbs.count);
    STAssertTrue([verbs[0] isEqualToString:@"has"], nil);
    STAssertTrue([verbs[1] isEqualToString:@"am"], nil);
    STAssertTrue([verbs[2] isEqualToString:@"playing"], nil);

}


@end
