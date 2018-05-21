//
//  InfoTableViewController.m
//  APIPOC
//
//  Created by tavant_sreejit on 5/19/18.
//  Copyright © 2018 tavant_sreejit. All rights reserved.
//

#import "InfoTableViewController.h"
#import "CountryData.h"
#import "CustomTableViewCell.h"
#import "APIManager.h"


@interface InfoTableViewController ()
    @property (strong,nonatomic) NSMutableArray<CountryData *> *content;
@end

@implementation InfoTableViewController

static NSString *cellID = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavBar];
    [self fetchCountryData];
    
    [self setupData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: TableView Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _content.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = (CustomTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:cellID];    
    if(cell == nil) {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    CountryData *cellData = [_content objectAtIndex:indexPath.row];
    cell.title.text = cellData.title;
    cell.topicDescription.text = cellData.topicDescription;
    UIImage* tempImage = [UIImage imageNamed:@"placeholder"];
    cell.topicImageView.image = tempImage;
    
    // download the image asynchronously
    NSURL *url = [NSURL URLWithString:cellData.imageURL];
    [self downloadImageWithURL:url completionBlock:^(BOOL succeeded, UIImage *image) {
        if (succeeded) {
            // change the image in the cell
            cell.topicImageView.image = image;
        }
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    CountryData *cellData = [_content objectAtIndex:indexPath.row];
    NSLog(@"title of cell %@-%d", cellData.title, indexPath.row);
}

// MARK: Basic Setup
// Basic Setup helper method to be called from viewdidload
- (void) setupData{
    self.content = NSMutableArray.new;
    [self.tableView registerClass:CustomTableViewCell.class forCellReuseIdentifier:cellID];
    
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}
- (void) setupNavBar {
    
    self.navigationItem.title = @"--Loading--";
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Refresh"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                      action:@selector(refreshButtonPressed:)];
    self.navigationItem.rightBarButtonItem = refreshButton;
}

-(void) refreshButtonPressed: (UIButton*) sender {
    NSLog(@"Refresh Button pressed");
    [self fetchCountryData];
}

-(void) fetchCountryData {
    [APIManager.new fetchCountryDataWithBlock:^(NSDictionary *jsonDic) {
        if(jsonDic[@"title"]){
            self.navigationItem.title = jsonDic[@"title"];
        }
        if(jsonDic[@"rows"]){
            self.content = NSMutableArray.new;
            for (NSDictionary *itemData in jsonDic[@"rows"]){
                [self.content addObject:[CountryData.new initWithDictionary:itemData]];
            }
        }
        [self.tableView reloadData];
    }];
}

- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image);
                               } else{
                                   completionBlock(NO,nil);
                               }
                           }];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    // Code here will execute before the rotation begins.
    // Equivalent to placing it in the deprecated method -[willRotateToInterfaceOrientation:duration:]
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        // Place code here to perform animations during the rotation.
        // You can pass nil or leave this block empty if not necessary.
        [self.tableView reloadData];
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        // Code here will execute after the rotation has finished.
        // Equivalent to placing it in the deprecated method -[didRotateFromInterfaceOrientation:]
        
//        NSArray *cells = [self.tableView visibleCells];
//        [self.tableView beginUpdates];
//        for (CustomTableViewCell *cell in cells) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [cell.contentView sizeToFit];
//                [cell layoutSubviews];
//                [cell.contentView layoutIfNeeded];
//                [cell.contentView setNeedsDisplay];
//                [cell.contentView setNeedsLayout];
//            });
//            
//        }
//        [self.tableView endUpdates];
        
//        [self.tableView reloadData];
    }];
}


@end
