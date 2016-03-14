//
//  DefaultParser.m
//  AtlassianAssignment
//
//  Created by Muddsar on 14/3/16.
//  Copyright © 2016 Atlassian. All rights reserved.
//

#import "DefaultParser.h"

#define REGEX_MENTIONS  @"@((\\w)+)"
#define REGEX_EMOTICONS @"\\(([a-z0-9]{1,15})\\)"
#define REGEX_LINKS     @"@(\\w)+"

@implementation DefaultParser

-(NSArray*)parseContents:(NSString*)inputText parserType:(ContentType)parser
{
    switch (parser) {
        case ContentTypeMentions:
            return [self parseMentions:inputText];
            break;
        case ContentTypeEmoticons:
            return [self parseEmoticons:inputText];
            break;
        case ContentTypeLinks:
           return [self parseLinks:inputText];
            break;
            
        default:
            break;
    }
    
    return nil;
}

-(NSArray*)parseMentions:(NSString*)inputText
{
    NSMutableArray *result=[NSMutableArray new];
    NSError  *error  = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:REGEX_MENTIONS
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    if(error)
    {
        NSLog(@"ERROR: %@",error.description);
        return nil;
    }

    NSArray *matches = [regex matchesInString:inputText
                                      options:0
                                        range:NSMakeRange(0, [inputText length])];
    
    for ( NSTextCheckingResult* match in matches )
    {
        NSString* matchText = [inputText substringWithRange:[match rangeAtIndex:1]];
        [result addObject:matchText];
    }
    
    return result;
}

-(NSArray*)parseEmoticons:(NSString*)inputText
{
    NSMutableArray *result=[NSMutableArray new];
    NSError  *error  = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:REGEX_EMOTICONS
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    if(error)
    {
        NSLog(@"ERROR: %@",error.description);
        return nil;
    }

    NSArray *matches = [regex matchesInString:inputText
                                      options:0
                                        range:NSMakeRange(0, [inputText length])];
    
    for ( NSTextCheckingResult* match in matches )
    {
        NSString* matchText = [inputText substringWithRange:[match rangeAtIndex:1]];
        [result addObject:matchText];
    }
    
    return result;
}


-(NSArray*)parseLinks:(NSString*)inputText
{
    NSMutableArray *result=[NSMutableArray new];
    NSError  *error  = nil;
   
    NSDataDetector *linkDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:&error];
    if(error)
    {
        NSLog(@"ERROR: %@",error.description);
        return nil;
    }

    
    NSArray *matches = [linkDetector matchesInString:inputText options:0 range:NSMakeRange(0, [inputText length])];

    for ( NSTextCheckingResult* match in matches )
    {
        NSString* matchText = [inputText substringWithRange:[match range]];
        [result addObject:matchText];
    }
 
    
    
    return result;
}


-(NSArray*)parse:(NSString*)inputText
{
    //default behaviour
    return [self parseMentions:inputText];
}


@end
