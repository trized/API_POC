//
//  InfoTableViewController.m
//  APIPOC
//
//  Created by tavant_sreejit on 5/19/18.
//  Copyright © 2018 tavant_sreejit. All rights reserved.
//

#import "InfoTableViewController.h"
#import "CountryData.h"

@interface InfoTableViewController ()
    @property (strong,nonatomic) NSMutableArray<CountryData *> *content;
@end

@implementation InfoTableViewController

static NSString *cellID = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Placeholder";
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
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        
    }
    CountryData *cellData = [_content objectAtIndex:indexPath.row];
    cell.textLabel.text =  [NSString.new stringByAppendingFormat:@"%@ %d",cellData.title, indexPath.row ];
    cell.detailTextLabel.text = cellData.topicDescription;
    cell.imageView.image = [UIImage imageNamed:@"placeholder"];
    
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
    temp.title = @"test";
    temp.topicDescription = @"khnaknsfn s nsf nsdn sdk nsd kendf ksdf sdk nsdkf sd ksdn skdn aekdlf ndkn sdkf sndf ksndf sldkn sdk nsdklf nsd knsdf mdnsf sdknf sdkf ndsf knsdvhfbvouehrgnksmvdvn sd nsdk seefwijsidhnsd;b edhnsdvnsjj n";
    temp.imageURL = @"http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg";
    self.content = NSMutableArray.new;
    [self.content addObjectsFromArray:@[temp, temp, temp, temp, temp]];
    
    //    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:cellID];
}

@end
