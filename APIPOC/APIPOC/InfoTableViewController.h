//
//  InfoTableViewController.h
//  APIPOC
//
//  Created by tavant_sreejit on 5/19/18.
//  Copyright © 2018 tavant_sreejit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountryData.h"

@interface InfoTableViewController : UITableViewController
    @property (strong,nonatomic) NSMutableArray<CountryData *> *content;

- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock;

@end
