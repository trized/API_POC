//
//  APIManager.h
//  APIPOC
//
//  Created by tavant_sreejit on 5/21/18.
//  Copyright © 2018 tavant_sreejit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIManager : NSObject

typedef void (^ completionBlockWithDictionary)(NSDictionary*);

-(void) fetchCountryDataWithBlock: (completionBlockWithDictionary)jsonDictionary;

@end
