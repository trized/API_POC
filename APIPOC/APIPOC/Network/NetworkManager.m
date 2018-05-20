//
//  NetworkManager.m
//  APIPOC
//
//  Created by tavant_sreejit on 5/20/18.
//  Copyright © 2018 tavant_sreejit. All rights reserved.
//

#import "NetworkManager.h"

@interface NetworkManager ()

@end

@implementation NetworkManager:NSObject

+(void) handleRequestWithBlock: (NSString *) url completionHandler: (completionBlock)completionBlock{
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:completionBlock
     ];
                            
}

@end
