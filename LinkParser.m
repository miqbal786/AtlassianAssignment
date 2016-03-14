//
//  LinkParser.m
//  AtlassianAssignment
//
//  Created by Muddsar on 14/3/16.
//  Copyright © 2016 Atlassian. All rights reserved.
//

#import "LinkParser.h"

@implementation LinkParser
-(NSArray*)parse:(NSString*)inputText
{
    NSArray *matches = [super parseContents:inputText parserType:ContentTypeLinks];
    
    if(!matches)
        return nil;
    
    NSMutableArray *result=[NSMutableArray new];
    
    for ( NSString* url in matches )
    {

        NSString *htmlString=[NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSASCIIStringEncoding error:nil];
        if (!htmlString)
            continue;
        
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<title>(.*)<\\/title>"
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:nil];
        NSTextCheckingResult *match = [regex firstMatchInString:htmlString options:NSMatchingReportProgress range:NSMakeRange(0, [htmlString length])];
        
        if(match)
        {            
            NSMutableDictionary *linkInfo=[NSMutableDictionary new];
            [linkInfo setObject:url forKey:@"url"];
            [linkInfo setObject:[htmlString substringWithRange:[match rangeAtIndex:1]] forKey:@"title"];
            [result addObject:linkInfo];
        }
        
    }

    return result;

}

@end
