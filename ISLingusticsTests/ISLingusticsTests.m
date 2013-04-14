//
//  ISLingusticsTests.m
//  ISLingusticsTests
//
//  Created by Iain Smith on 13/04/2013.
//  Copyright (c) 2013 mountain23. All rights reserved.
//

#import "ISLingusticsTests.h"
#import "ISLingustics.h"

@interface ISLingusticsTests ()
{
    NSString *_text;
    NSString *_simpleText;
    NSString *_shortText;
    NSString *_nameText;
}
@end

@implementation ISLingusticsTests

- (void)setUp
{
    _simpleText = @"The man read a newspaper";
    _text = @"I'm planning to go to London, after I visit Washington. This is awesome. Did you see the fox?";
    _shortText = @"This is awesome.";
    _nameText = @"David went to see Sam at the pub";
    
}

- (void)testWordsFromString
{
    NSArray *words = [[[ISLingustics alloc] initWithString:_shortText] wordsFromString];
    STAssertTrue(words.count == 3, @"should contain 3 words");
    STAssertTrue([words[0] isEqualToString:@"This"], @"first words should be: This");
}

- (void)testSentencesFromString
{
    NSArray *sentences =[[[ISLingustics alloc] initWithString:_text] sentencesFromString];
    STAssertTrue(sentences.count == 3, @"should contain 3 sentences");
    STAssertTrue([sentences[0] isEqualToString:@"I'm planning to go to London, after I visit Washington."], @"first sentence was incorrect");
}

- (void)testNounsFromString
{
    NSArray *nouns = [[[ISLingustics alloc] initWithString:_simpleText] nounsForString];
    STAssertTrue(nouns.count == 2, @"expected 2 nouns, found %i nouns:%@", nouns.count, nouns);
    STAssertTrue([nouns[0] isEqualToString:@"man"], @"first noun should be man, Was:%@", nouns[0]);
}

- (void)testPlaceNamesFromString
{
    NSArray *placeNames = [[[ISLingustics alloc] initWithString:_text] placeNamesForString];
    STAssertTrue([placeNames[0] isEqualToString:@"London"], @"first place name should be London: Was:%@", placeNames[0]);
    STAssertTrue([placeNames[1] isEqualToString:@"Washington"], @"second place name should be Nottingham: Was:%@", placeNames[1]);
}

- (void)testPersonalNamesFromString
{
    NSArray *personalNames = [[[ISLingustics alloc] initWithString:_nameText] personalNamesFromString];
    STAssertTrue([personalNames[0] isEqualToString:@"David"], @"first name should be: Dave Was:%@", personalNames[0]);
    STAssertTrue([personalNames[1] isEqualToString:@"Sam"], @"second place name should be Samuel: Was:%@", personalNames[1]);
}

- (void)testRootNounsFromString
{
    NSArray *nouns = [[[ISLingustics alloc] initWithString:@"these are mountains. There is my friends."] rootLowerCaseNounsForString];
    STAssertTrue([nouns[0] isEqualToString:@"mountain"], @"first noun should be: mountain Was:%@", nouns[0]);
    STAssertTrue([nouns[1] isEqualToString:@"friend"], @"first noun should be: cat Was:%@", nouns[1]);
}

@end
