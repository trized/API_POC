//
//  CountryData.m
//  APIPOC
//
//  Created by tavant_sreejit on 5/20/18.
//  Copyright © 2018 tavant_sreejit. All rights reserved.
//

#import "CountryData.h"

@implementation CountryData

-(id)initWithDictionary: (NSDictionary*) countryDic{
    self = [super init];
    if(self) {
        self.title = countryDic[@"title"] == [NSNull null] ?  @"--N/A--" : countryDic[@"title"];
        self.topicDescription = countryDic[@"description"] == [NSNull null] ?  @"--N/A--" : countryDic[@"description"];
//        if(countryDic[@"imageHref"] == [NSNull null]){
//            NSLog(@"NO DATA");
//        }
        self.imageURL = countryDic[@"imageHref"] == [NSNull null] ?  @"placeholder" : countryDic[@"imageHref"];
    }
    return self;
}

@end
