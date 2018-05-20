//
//  CountryData.h
//  APIPOC
//
//  Created by tavant_sreejit on 5/20/18.
//  Copyright © 2018 tavant_sreejit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountryData : NSObject

@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *topicDescription;
@property (strong,nonatomic) NSString *imageURL;
-(id)initWithDictionary: (NSDictionary*) countryDic;
@end
