//
//  KFXLogFileTVCell.m
//  Pods
//
//  Created by Leu on 03/10/2016.
//
//

#import "KFXLogFileTVCell.h"



@implementation KFXLogFileTVCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self sharedInitilisation];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self sharedInitilisation];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self sharedInitilisation];
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
    {
        [self sharedInitilisation];
    }
    return self;
}


-(void)sharedInitilisation{
    
    self.fileNameLabel = [[UILabel alloc]init];
    self.creationDateLabel = [[UILabel alloc]init];
    self.modificationDateLabel = [[UILabel alloc]init];
    self.fileNameLabel.minimumScaleFactor = 0.5;
    self.creationDateLabel.minimumScaleFactor = 0.5;
    self.modificationDateLabel.minimumScaleFactor = 0.5;
    self.fileNameLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.creationDateLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    self.modificationDateLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
    self.fileNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.creationDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.modificationDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.fileNameLabel];
    [self.contentView addSubview:self.creationDateLabel];
    [self.contentView addSubview:self.modificationDateLabel];

    [self layoutLabels];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)layoutLabels{
    
    NSDictionary *viewsDict = @{
                                @"nameLabel":self.fileNameLabel,
                                @"creationLabel":self.creationDateLabel,
                                @"modificationLabel":self.modificationDateLabel
                                };
    NSDictionary *metrics = @{
                              @"leftMargin":@20.0,
                              @"rightMargin":@20.0,
                              @"verticalMargin":@4.0,
                              @"labelHeight":@22
                              };
    
    //                          @"V:|-verticalMargin-[nameLabel(labelHeight)]-20-[creationLabel(labelHeight)]-20-[modificationLabel(labelHeight)]-verticalMargin-|"

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:
                          @"V:|-verticalMargin-[nameLabel(labelHeight)][creationLabel(labelHeight)][modificationLabel(labelHeight)]-verticalMargin-|"
                                                                 options:kNilOptions
                                                                 metrics:metrics
                                                                   views:viewsDict]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.fileNameLabel
                                                     attribute:NSLayoutAttributeLeading
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.contentView
                                                     attribute:NSLayoutAttributeLeading
                                                    multiplier:1.0
                                                      constant:[metrics[@"leftMargin"] doubleValue]]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.creationDateLabel
                                                     attribute:NSLayoutAttributeLeading
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.contentView
                                                     attribute:NSLayoutAttributeLeading
                                                    multiplier:1.0
                                                      constant:[metrics[@"leftMargin"] doubleValue]]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.modificationDateLabel
                                                     attribute:NSLayoutAttributeLeading
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.contentView
                                                     attribute:NSLayoutAttributeLeading
                                                    multiplier:1.0
                                                      constant:[metrics[@"leftMargin"] doubleValue]]];

}



-(void)prepareForReuse{
    [super prepareForReuse];
}



@end
