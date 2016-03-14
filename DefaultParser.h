//
//  DefaultParser.h
//  AtlassianAssignment
//
//  Created by Muddsar on 14/3/16.
//  Copyright © 2016 Atlassian. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 enum to define content type for parsing
 */
typedef enum : NSUInteger {
    ContentTypeMentions=0,
    ContentTypeEmoticons=1,
    ContentTypeLinks=2,
} ContentType;


@interface DefaultParser : NSObject
/*
 parse input test for given parse type
 */
-(NSArray*)parseContents:(NSString*)inputText parserType:(ContentType)parser;
/*
 default parser
 */
-(NSArray*)parse:(NSString*)inputText;

@end
