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
//#import "NetworkManager.h"
#import "APIManager.h"


@interface InfoTableViewController ()
    @property (strong,nonatomic) NSMutableArray<CountryData *> *content;
@end

@implementation InfoTableViewController

static NSString *cellID = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Placeholder";
    [self fetchCountryData];
    [self setupNavBarButton];
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
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        
    }
    CountryData *cellData = [_content objectAtIndex:indexPath.row];
//    cell.title.text = [NSString.new stringByAppendingFormat:@"%@ %d",cellData.title, indexPath.row ];
    cell.title.text = cellData.title;
//    cell.topicDescription.text = [NSString.new stringByAppendingFormat:@"%@ %d",cellData.title, indexPath.row ];
    cell.topicDescription.text = cellData.topicDescription;
    
    if(cellData.imageURL.length != 0){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSURL *url = [NSURL URLWithString:cellData.imageURL];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage* image = [[UIImage alloc] initWithData:data];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.topicImageView.image = image;
            });
        });
    }
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
    CountryData *temp = CountryData.new;
    self.content = NSMutableArray.new;
    [self.tableView registerClass:CustomTableViewCell.class forCellReuseIdentifier:cellID];
    
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}
- (void) setupNavBarButton {
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

@end
