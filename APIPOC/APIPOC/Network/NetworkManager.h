//
//  NetworkManager.h
//  APIPOC
//
//  Created by tavant_sreejit on 5/20/18.
//  Copyright © 2018 tavant_sreejit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

typedef void (^ completionBlock)(NSURLResponse*, NSData*, NSError*);

+(void) handleRequestWithBlock: (NSString *) url completionHandler: (completionBlock)completionBlock;
@end
