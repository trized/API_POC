//
//  CustomTableViewCell.m
//  APIPOC
//
//  Created by tavant_sreejit on 5/20/18.
//  Copyright © 2018 tavant_sreejit. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "CountryData.h"

@interface CustomTableViewCell ()
    @property (strong,nonatomic) CountryData *cellData;
@end

@implementation CustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // configure control(s)
        
        self.topicImageView = [UIImageView.new initWithImage:[UIImage imageNamed:@"placeholder"]];
        self.topicImageView.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.topicDescription = [UILabel.new init];
        self.topicDescription.textColor = [UIColor blackColor];
//        self.topicDescription.backgroundColor = [UIColor redColor];
        self.topicDescription.font = [UIFont fontWithName:@"Arial" size:12.0f];
        self.topicDescription.translatesAutoresizingMaskIntoConstraints = NO;
        self.topicDescription.numberOfLines = 0;
//        self.topicDescription.preferredMaxLayoutWidth = 125.0;
        
        self.title = [UILabel.new init];
        self.title.textColor = [UIColor blackColor];
//        self.title.backgroundColor = [UIColor redColor];
        self.title.font = [UIFont fontWithName:@"Arial" size:12.0f];
        self.title.translatesAutoresizingMaskIntoConstraints = NO;
        
        UIView *holderView = [UIView.new init];
        holderView.translatesAutoresizingMaskIntoConstraints = NO;
        holderView.backgroundColor = [UIColor grayColor];
        
        [self.contentView addSubview:self.topicImageView];
        [self.contentView addSubview:holderView];
        
        [holderView addSubview:self.title];
        [holderView addSubview:self.topicDescription];
        
        
        NSDictionary *viewsDictionary = @{@"imageView":self.topicImageView,@"holder":holderView, @"title":self.title, @"desc":self.topicDescription};
        NSDictionary *metrics = @{
                                  @"imageViewHeight":@50,
                                  @"MPadding": @16,
                                  @"mPadding": @8,
                                  @"childPadding": @5
                                  };

        [self.contentView addConstraints:[NSLayoutConstraint
                                   constraintsWithVisualFormat:@"V:|-mPadding-[imageView(imageViewHeight)]-mPadding-|"
                                   options:NSLayoutFormatDirectionLeadingToTrailing
                                   metrics:metrics
                                          views:viewsDictionary]];
        [self.contentView addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"V:|[holder]|"
                                          options:NSLayoutFormatDirectionLeadingToTrailing
                                          metrics:metrics
                                          views:viewsDictionary]];
        [self.contentView addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"H:|-mPadding-[imageView(imageViewHeight)]-mPadding-[holder]-mPadding-|"
                                          options:NSLayoutFormatDirectionLeadingToTrailing
                                          metrics:metrics
                                          views:viewsDictionary]];
        [holderView addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"V:|-mPadding-[title]-childPadding-[desc]-mPadding-|"
                                          options:NSLayoutFormatDirectionLeadingToTrailing
                                          metrics:metrics
                                          views:viewsDictionary]];
        [holderView addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"H:|[title]|"
                                          options:NSLayoutFormatDirectionLeadingToTrailing
                                          metrics:metrics
                                          views:viewsDictionary]];
        [holderView addConstraints:[NSLayoutConstraint
                                    constraintsWithVisualFormat:@"H:|[desc]|"
                                    options:NSLayoutFormatDirectionLeadingToTrailing
                                    metrics:metrics
                                    views:viewsDictionary]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
