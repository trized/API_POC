//
//  APIManager.m
//  APIPOC
//
//  Created by tavant_sreejit on 5/21/18.
//  Copyright © 2018 tavant_sreejit. All rights reserved.
//

#import "APIManager.h"
#import "NetworkManager.h"

static NSString *K_API_URL = @"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json";

@implementation APIManager

-(void) fetchCountryDataWithBlock: (completionBlockWithDictionary)jsonDictionary{
    [NetworkManager handleRequestWithBlock:K_API_URL completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if ([data length] > 0 && error == nil){
            // do your work here
            NSLog(@"GOT SOME DATA");
            NSError *err;
            NSString *dataString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
            if(err){
                NSLog(@"FAILED TO PROCESS JSON");
                return;
            }
            jsonDictionary(jsonDic, response);
        }else if ([data length] == 0 && error == nil){
            NSLog(@"NO DATA TO PROCESS");
        }else if (error != nil) {
            NSLog(@"%@",error.description);
        }
    }];
}

@end
