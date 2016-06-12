//
//  UserView.m
//  GeoLocation
//
//  Created by Fazle Rab on 10/13/15.
//  Copyright © 2015 Fazle Rab. All rights reserved.
//

#import "UserView.h"
@interface UserView()

@property (strong, nonatomic) UILabel *userIdLabel;
@property (strong, nonatomic) UILabel *longitudeLabel;
@property (strong, nonatomic) UILabel *latitudeLabel;
@property (strong, nonatomic) UILabel *radiusLabel;
@property (strong, nonatomic) UILabel *statusLabel;

@property (strong, nonatomic) UILabel *currLongitudeLabel;
@property (strong, nonatomic) UILabel *currLatitudeLabel;


@end

@implementation UserView

- (instancetype) init {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self buildUI];
    }
    
    return self;
}

- (void) buildUI {
    // User Fields
    self.userIdLabel = [[UILabel alloc] init];
    self.userIdLabel.text = @"User ID";
    [self addSubview:self.userIdLabel];
    
    self.userIdTextField = [self makeTextField:@"Enter User ID"];
    self.userIdTextField.returnKeyType = UIReturnKeyDone;
    self.userIdTextField.enablesReturnKeyAutomatically = YES;
    [self addSubview:self.userIdTextField];
    
    
    self.longitudeLabel = [[UILabel alloc] init];
    self.longitudeLabel.text = @"Longitude";
    [self addSubview:self.longitudeLabel];
    
    self.longitudeTextField = [self makeTextField:@"Enter Longitude"];
    self.longitudeTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.longitudeTextField.returnKeyType = UIReturnKeyDone;
    self.longitudeTextField.enablesReturnKeyAutomatically = YES;
    [self addSubview:self.longitudeTextField];
    
    
    self.latitudeLabel = [[UILabel alloc] init];
    self.latitudeLabel.text = @"Latitude";
    [self addSubview:self.latitudeLabel];
    
    self.latitudeTextField = [self makeTextField:@"Enter Latitude"];
    self.latitudeTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.latitudeTextField.returnKeyType = UIReturnKeyDone;
    self.latitudeTextField.enablesReturnKeyAutomatically = YES;
    [self addSubview:self.latitudeTextField];
    
    
    self.radiusLabel = [[UILabel alloc] init];
    self.radiusLabel.text = @"Tracking Radius";
    [self addSubview:self.radiusLabel];
    
    self.radiusTextField = [self makeTextField:@"Enter Tracking Radius"];
    self.radiusTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.radiusTextField.returnKeyType = UIReturnKeyDone;
    self.radiusTextField.enablesReturnKeyAutomatically = YES;
    [self addSubview:self.radiusTextField];

    self.statusLabel = [[UILabel alloc] init];
    self.statusLabel.text = @"Child Location Status";
    [self addSubview:self.statusLabel];
    
    self.statusTextField = [self makeTextField:@""];
    self.statusTextField.enabled = NO;
    [self addSubview:self.statusTextField];

    // User Buttons
    self.createUserButton = [self makeButton:@"Create User"];
    [self addSubview:self.createUserButton];
    
    self.updateUserButton = [self makeButton:@"Update User"];
    [self addSubview:self.updateUserButton];

    self.getUserButton = [self makeButton:@"Get User"];
    [self addSubview:self.getUserButton];

    // Child fields
    self.currLatitudeLabel = [[UILabel alloc] init];
    self.currLatitudeLabel.text = @"Current Latitude";
    [self addSubview:self.currLatitudeLabel];
    
    self.currLatitudeTextField = [self makeTextField:@""];
    self.currLatitudeTextField.enabled = NO;
    [self addSubview:self.currLatitudeTextField];
    
    
    self.currLongitudeLabel = [[UILabel alloc] init];
    self.currLongitudeLabel.text = @"Current Longitude";
    [self addSubview:self.currLongitudeLabel];
    
    self.currLongitudeTextField = [self makeTextField:@""];
    self.currLongitudeTextField.enabled = NO;
    [self addSubview:self.currLongitudeTextField];
    
    self.updateChildLocationButton = [self makeButton:@"Update Child Location"];
    [self addSubview:self.updateChildLocationButton];
}

- (void) layoutUI {
    static const CGFloat LABEL_TEXT_SPACING = 3;
    static const CGFloat FIELDS_SPACING = 10;
    static const CGFloat EDGE_SPACING = 25;
    
    CGFloat x = EDGE_SPACING;
    CGFloat y = EDGE_SPACING * 2;
    CGFloat width = self.bounds.size.width - 2 * EDGE_SPACING;

    UILabel *label;
    UITextField *textField;
    CGRect frame;
    
    label = self.userIdLabel;
    [label sizeToFit];
    frame = label.frame;
    frame.origin = CGPointMake(x, y);
    label.frame = frame;
    
    y += frame.size.height + LABEL_TEXT_SPACING;
    
    textField = self.userIdTextField;
    [textField sizeToFit];
    frame = textField.frame;
    frame = CGRectMake(x, y, width, frame.size.height);
    textField.frame = frame;
    
    y += frame.size.height + FIELDS_SPACING;
    
    label = self.longitudeLabel;
    [label sizeToFit];
    frame = label.frame;
    frame.origin = CGPointMake(x, y);
    label.frame = frame;
    
    y += frame.size.height + LABEL_TEXT_SPACING;

    textField = self.longitudeTextField;
    [textField sizeToFit];
    frame = textField.frame;
    frame = CGRectMake(x, y, width, frame.size.height);
    textField.frame = frame;

    y += frame.size.height + FIELDS_SPACING;
    
    label = self.latitudeLabel;
    [label sizeToFit];
    frame = label.frame;
    frame.origin = CGPointMake(x, y);
    label.frame = frame;
    
    y += frame.size.height + LABEL_TEXT_SPACING;

    textField = self.latitudeTextField;
    [textField sizeToFit];
    frame = textField.frame;
    frame = CGRectMake(x, y, width, frame.size.height);
    textField.frame = frame;
    
    y += frame.size.height + FIELDS_SPACING;
    
    label = self.radiusLabel;
    [label sizeToFit];
    frame = label.frame;
    frame.origin = CGPointMake(x, y);
    label.frame = frame;
    
    y += frame.size.height + LABEL_TEXT_SPACING;
    
    textField = self.radiusTextField;
    [textField sizeToFit];
    frame = textField.frame;
    frame = CGRectMake(x, y, width, frame.size.height);
    textField.frame = frame;
    
    y += frame.size.height + FIELDS_SPACING;
    
    label = self.statusLabel;
    [label sizeToFit];
    frame = label.frame;
    frame.origin = CGPointMake(x, y);
    label.frame = frame;
    
    y += frame.size.height + LABEL_TEXT_SPACING;
    
    textField = self.statusTextField;
    [textField sizeToFit];
    frame = textField.frame;
    frame = CGRectMake(x, y, width, frame.size.height);
    textField.frame = frame;
    
    y += frame.size.height + FIELDS_SPACING * 1.5;
    
    [self.createUserButton sizeToFit];
    frame = self.createUserButton.frame;
    frame = CGRectMake(x, y, frame.size.width + 10, frame.size.height);
    self.createUserButton.frame = frame;

    x += frame.size.width + FIELDS_SPACING;
    
    [self.updateUserButton sizeToFit];
    frame = self.updateUserButton.frame;
    frame = CGRectMake(x, y, frame.size.width + 10, frame.size.height);
    self.updateUserButton.frame = frame;

    x += frame.size.width + FIELDS_SPACING;
    
    [self.getUserButton sizeToFit];
    frame = self.getUserButton.frame;
    frame = CGRectMake(x, y, frame.size.width + 10, frame.size.height);
    self.getUserButton.frame = frame;
    
    // Child fields
    x = EDGE_SPACING;
    y += frame.size.height + FIELDS_SPACING * 2;
    
    label = self.currLongitudeLabel;
    [label sizeToFit];
    frame = label.frame;
    frame.origin = CGPointMake(x, y);
    label.frame = frame;
    
    y += frame.size.height + LABEL_TEXT_SPACING;
    
    textField = self.currLongitudeTextField;
    [textField sizeToFit];
    frame = textField.frame;
    frame = CGRectMake(x, y, width, frame.size.height);
    textField.frame = frame;
    
    y += frame.size.height + FIELDS_SPACING;

    label = self.currLatitudeLabel;
    [label sizeToFit];
    frame = label.frame;
    frame.origin = CGPointMake(x, y);
    label.frame = frame;
    
    y += frame.size.height + LABEL_TEXT_SPACING;
    
    textField = self.currLatitudeTextField;
    [textField sizeToFit];
    frame = textField.frame;
    frame = CGRectMake(x, y, width, frame.size.height);
    textField.frame = frame;

    y += frame.size.height + FIELDS_SPACING * 1.5;
    
    [self.updateChildLocationButton sizeToFit];
    frame = self.updateChildLocationButton.frame;
    frame = CGRectMake(x, y, frame.size.width + 10, frame.size.height);
    self.updateChildLocationButton.frame = frame;
    
}

- (UITextField *) makeTextField:(NSString *)text {
    UITextField *textField = [[UITextField alloc] init];
    textField.placeholder = text;
    textField.backgroundColor = [UIColor whiteColor];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    return textField;
}

- (UIButton *) makeButton:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor  = [UIColor grayColor];
    button.tintColor = [UIColor whiteColor];
    button.enabled = YES;
    return button;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    [self layoutUI];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
