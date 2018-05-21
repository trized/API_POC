//
//  InfoTableViewController.m
//  APIPOC
//
//  Created by tavant_sreejit on 5/19/18.
//  Copyright © 2018 tavant_sreejit. All rights reserved.
//

#import "InfoTableViewController.h"
#import "CustomTableViewCell.h"
#import "APIManager.h"


@interface InfoTableViewController ()
//    @property (strong,nonatomic) NSMutableArray<CountryData *> *content;
@end

@implementation InfoTableViewController

static NSString *cellID = @"Cell";
static NSString *K_PLACEHOLDER_NAVBAR_TITLE = @"--Loading--";

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

// MARK: TableView DELEGATE & DATASOURCE Methods
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
    
    // Load default/placeholder image until the API retreives and updates the data
    UIImage* tempImage = [UIImage imageNamed:@"placeholder"];
    cell.topicImageView.image = tempImage;
    
    // Download the image asynchronously
    NSURL *url = [NSURL URLWithString:cellData.imageURL];
    [self downloadImageWithURL:url completionBlock:^(BOOL succeeded, UIImage *image) {
        if (succeeded && image != nil) {
            // Change the image in the cell
            cell.topicImageView.image = image;
        }
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    CountryData *cellData = [_content objectAtIndex:indexPath.row];
    NSLog(@"title of cell %@-%li", cellData.title, indexPath.row);
}


// MARK: Basic UI and Data Setup methods
// Basic Setup helper method to be called from viewdidload
- (void) setupData{
    //Initalizing the content dictionary
    self.content = NSMutableArray.new;
    
    // register the custom UITableViewCell
    [self.tableView registerClass:CustomTableViewCell.class forCellReuseIdentifier:cellID];
    
    // Handling for self sizing cells
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // Set the backgroundview to hold a simple label
    UILabel* backgroundLabel = [UILabel.new initWithFrame:CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.frame.size.height)];
    backgroundLabel.text = @"--FETCHING DATA--";
    backgroundLabel.font = [UIFont fontWithName:@"Arial-Bold" size:13.0f];
    backgroundLabel.textAlignment = NSTextAlignmentCenter;
    self.tableView.backgroundView = backgroundLabel;
}
- (void) setupNavBar {
    
    // Setup default values to show before the API is complete
    self.navigationItem.title = K_PLACEHOLDER_NAVBAR_TITLE;
    
    // add the UIBarButton to the NavBar
    UIBarButtonItem *refreshButton = [UIBarButtonItem.new initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshButtonPressed:)];
    self.navigationItem.rightBarButtonItem = refreshButton;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
}


// Method fetches the json data from the API call and returns a NSDictionary
-(void) fetchCountryData {
    [APIManager.new fetchCountryDataWithBlock:^(NSDictionary *jsonDic, NSURLResponse *response) {
        
        // fetch the title which needs to be displayed on the navbar
        if(jsonDic[@"title"]){
            self.navigationItem.title = jsonDic[@"title"];
        }
        
        // fetch the row data which is used to create the NSDictionary (_content) of CountryData
        if(jsonDic[@"rows"]){
            self.content = NSMutableArray.new;
            for (NSDictionary *itemData in jsonDic[@"rows"]){
                [self.content addObject:[CountryData.new initWithDictionary:itemData]];
            }
        }
        [self.tableView reloadData];
    }];
}

// MARK: Method to handle refresh button press
-(void) refreshButtonPressed: (UIButton*) sender {
    
    // fetch the latest data from th API
    [self fetchCountryData];
}

// MARK: Method to fetch image ascyhronously
/**
 - Parameters:
    -url: (NSURL *)url - urlrequest (url) of the image to load
    -completionBlock: The completion block which gets the loaded UIImage object from the asynchronous call
 */
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


// MARK: Delegate Method to handle orientation changes
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
    }];
}


@end
