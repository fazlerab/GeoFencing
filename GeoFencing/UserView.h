//
//  UserView.h
//  GeoLocation
//
//  Created by Fazle Rab on 10/13/15.
//  Copyright © 2015 Fazle Rab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserView : UIView

@property (strong, nonatomic) UITextField *userIdTextField;
@property (strong, nonatomic) UITextField *longitudeTextField;
@property (strong, nonatomic) UITextField *latitudeTextField;
@property (strong, nonatomic) UITextField *radiusTextField;
@property (strong, nonatomic) UITextField *statusTextField;

@property (strong, nonatomic) UIButton *createUserButton;
@property (strong, nonatomic) UIButton *getUserButton;
@property (strong, nonatomic) UIButton *updateUserButton;

@property (strong, nonatomic) UITextField *currLongitudeTextField;
@property (strong, nonatomic) UITextField *currLatitudeTextField;

@property (strong, nonatomic) UIButton *updateChildLocationButton;

@end
