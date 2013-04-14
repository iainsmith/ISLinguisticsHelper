# ISLinguisticHelper

A simple helper class for analysing text on iOS and OS X. Category extensions on NSString to block enumerate through verbs, nouns, words and sentences.

Methods to return Arrays of verbs, nouns, placenames, personalNames, words and sentences. Great for building search indexes in your apps.

``` objective-c
NSString *yourText = ..;

ISLingusticHelper *helper = [ISLinguisticHelper alloc] initWithString:yourText];
NSArray *rootLowerCaseNouns = [helper rootLowerCaseNouns];
NSArray *verbs = [helper verbs];
```

### To do
- ~~Add to Cocoapods~~ (pull request pending)
- ~~Add MIT License~~
- Upload AppleDoc to gihub pages
- Add some NSData detector Methods
