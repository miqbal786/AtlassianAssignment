//
//  ViewController.m
//  AtlassianAssignment
//
//  Created by Muddsar on 9/3/16.
//  Copyright © 2016 Atlassian. All rights reserved.
//

#import "ViewController.h"
#import "EmoticonParser.h"
#import "LinkParser.h"
#import "MentionParser.h"

#define  MENTIONS   @"mentions"
#define  EMOTICONS  @"emoticons"
#define  LINKS      @"links"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

/*
 parses the user input and prints the json
 */
- (IBAction)parseMessage:(id)sender {
    
    NSString *string = _tf_messageBox.text;
    if(!string || string.length==0 || [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0)
    {
        _lbl_message.text=@"Please enter valid input";
        return;
    }
    
    [NSThread detachNewThreadSelector:@selector(startAnimating) toTarget:_activityIndicator withObject:nil];

    [self parse:string];
    _lbl_message.text=@"Json printed to console";

    [_activityIndicator stopAnimating];
    
}

-(void)parse:(NSString*)string
{
    NSMutableDictionary*    parsedContents = [NSMutableDictionary new];
    NSArray*                results        = nil;
    
    DefaultParser *parser = [MentionParser new];
    results = [parser parse:string];
    if(results && results.count>0)
        [parsedContents setObject:results forKey:MENTIONS];
    
    parser = [EmoticonParser new];
    results = [parser parse:string];
    if(results && results.count>0)
        [parsedContents setObject:results forKey:EMOTICONS];
    
    parser = [LinkParser new];
    results = [parser parse:string];
    if(results && results.count>0)
        [parsedContents setObject:results forKey:LINKS];
    
    if(parsedContents.allKeys.count>0)
    {
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:parsedContents options:0 error:nil];
        NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",jsonString);
    }
    else
        NSLog(@"%@",string);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
