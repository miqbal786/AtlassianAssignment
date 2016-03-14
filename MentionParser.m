//
//  MentionParser.m
//  AtlassianAssignment
//
//  Created by Muddsar on 14/3/16.
//  Copyright © 2016 Atlassian. All rights reserved.
//

#import "MentionParser.h"

@implementation MentionParser

-(NSArray*)parse:(NSString*)inputText
{
    return [super parseContents:inputText parserType:ContentTypeMentions];
}

@end
