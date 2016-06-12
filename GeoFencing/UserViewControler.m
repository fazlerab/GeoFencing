//
//  UserViewController.m
//  GeoLocation
//
//  Created by Fazle Rab on 10/13/15.
//  Copyright © 2015 Fazle Rab. All rights reserved.
//

#import "UserViewControler.h"
#import "UserView.h"
#import "LocationManagerDelegate.h"

@interface UserViewControler () <UITextFieldDelegate, NSURLConnectionDataDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) NSURLConnection *urlConnection;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSMutableData *urlData;
@property BOOL isUrlDataJson;

@end

@implementation UserViewControler

- (void) loadView {
    UserView *userView = [[UserView alloc] init];
    self.view = userView;
    
    userView.userIdTextField.delegate = self;
    userView.longitudeTextField.delegate = self;
    userView.latitudeTextField.delegate = self;
    userView.radiusTextField.delegate = self;
    
    [userView.createUserButton addTarget:self
                                  action:@selector(handleButtonAction:)
                        forControlEvents:UIControlEventTouchDown];
    
    [userView.updateUserButton addTarget:self
                               action:@selector(handleButtonAction:)
                     forControlEvents:UIControlEventTouchDown];

    [userView.getUserButton addTarget:self
                               action:@selector(handleButtonAction:)
                     forControlEvents:UIControlEventTouchDown];

    [userView.updateChildLocationButton addTarget:self
                                  action:@selector(handleButtonAction:)
                        forControlEvents:UIControlEventTouchDown];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupLocationManager];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UserView *) userView {
    return (UserView *)self.view;
}

// MARK: TextField Delegate methods
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return YES;
}
    

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    //NSLog(@"textFieldShouldReturn: %@=%@", textField.placeholder, textField.text);
    [textField resignFirstResponder];
    return YES;
}

// MARK: Button Action
- (void) handleButtonAction:(UIButton *)sender {
    if (sender == self.userView.createUserButton) {
        [self createUser];
    }
    else if (sender == self.userView.updateUserButton) {
        [self updateUser];
    }
    else if (sender == self.userView.getUserButton) {
        [self getUser];
    }
    else if (sender == self.userView.updateChildLocationButton) {
        [self updateChildLocation];
    }
}

- (void) createUser {
    NSString *userId = self.userView.userIdTextField.text;
    NSString *longitudeStr = self.userView.longitudeTextField.text;
    NSString *latitudeStr = self.userView.latitudeTextField.text;
    NSString *radiusStr = self.userView.radiusTextField.text;
    
    longitudeStr = [longitudeStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([longitudeStr isEqualToString:@""]) {
        longitudeStr = self.userView.longitudeTextField.placeholder;
        self.userView.longitudeTextField.text = longitudeStr;
    }
    
    latitudeStr = [latitudeStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([latitudeStr isEqualToString:@""]) {
        latitudeStr = self.userView.latitudeTextField.placeholder;
        self.userView.latitudeTextField.text = latitudeStr;
    }
    
    NSLog(@"createUser: userId=%@, longitude=%@, latitude=%@, radius=%@",
          userId, longitudeStr, latitudeStr, radiusStr);

    double longitude = [longitudeStr doubleValue];
    double latitude = [latitudeStr doubleValue];
    double radius = [radiusStr doubleValue];
    
    NSDictionary *user = @{@"username"  : userId,
                           @"latitude"  : [NSNumber numberWithDouble: latitude],
                           @"longitude" : [NSNumber numberWithDouble: longitude],
                           @"radius"    : [NSNumber numberWithDouble: radius]};
    
    NSDictionary *userDetail = @{@"utf8"               : @"✓",
                                 @"authenticity_token" : @"EvZva3cKnzo3Y0G5R3NktucCr99o/2UWOPVAmJYdBOc=",
                                 @"user"               : user,
                                 @"commit"             : @"CreateUser",
                                 @"action"             : @"update",
                                 @"controller"         : @"users"};
    
    [self doURLRequest:@"/users"
            HTTPMethod:@"POST"
              jsonData:[self convertToJSON:userDetail]];
}

- (void) updateUser {
    NSString *userId = self.userView.userIdTextField.text;
    NSString *longitudeStr = self.userView.longitudeTextField.text;
    NSString *latitudeStr = self.userView.latitudeTextField.text;
    NSString *radiusStr = self.userView.radiusTextField.text;
    
    longitudeStr = [longitudeStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([longitudeStr isEqualToString:@""]) {
        longitudeStr = self.userView.longitudeTextField.placeholder;
        self.userView.longitudeTextField.text = longitudeStr;
    }
    
    latitudeStr = [latitudeStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([latitudeStr isEqualToString:@""]) {
        latitudeStr = self.userView.latitudeTextField.placeholder;
        self.userView.latitudeTextField.text = latitudeStr;
    }
    
    NSLog(@"updateUser: userId=%@, longitude=%@, latitude=%@, radius=%@",
          userId, longitudeStr, latitudeStr, radiusStr);
    
    double longitude = [longitudeStr doubleValue];
    double latitude = [latitudeStr doubleValue];
    double radius = [radiusStr doubleValue];
    
    NSDictionary *user = @{@"username"  : userId,
                           @"latitude"  : [NSNumber numberWithDouble: latitude],
                           @"longitude" : [NSNumber numberWithDouble: longitude],
                           @"radius"    : [NSNumber numberWithDouble: radius]};
    
    NSDictionary *userDetail = @{@"utf8"               : @"✓",
                                 @"authenticity_token" : @"EvZva3cKnzo3Y0G5R3NktucCr99o/2UWOPVAmJYdBOc=",
                                 @"user"               : user,
                                 @"commit"             : @"CreateUser",
                                 @"action"             : @"update",
                                 @"controller"         : @"users"};
    
    [self doURLRequest:[@"/users/" stringByAppendingString:userId]
            HTTPMethod:@"PATCH"
              jsonData:[self convertToJSON:userDetail]];
}

- (void) setUser {
    if (self.isUrlDataJson) {
        NSDictionary *dict = [self convertToDictionary:self.urlData];
        
        self.userView.longitudeTextField.text = [NSString stringWithFormat:@"%@",
                                                 [dict objectForKey:@"longitude"]];
        
        self.userView.latitudeTextField.text = [NSString stringWithFormat:@"%@",
                                                [dict objectForKey:@"latitude"]];
        
        self.userView.radiusTextField.text = [NSString stringWithFormat:@"%@",
                                              [dict objectForKey:@"radius"]];
        
        id object = [dict objectForKey:@"is_in_zone"];
        if (object != [NSNull null]) {
            BOOL status = ((NSNumber *)object).boolValue;
            self.userView.statusTextField.text = [NSString stringWithFormat:@"%@",
                                                  status ? @"Is in Zone" : @"Not in Zone"];
        }
        else {
            self.userView.statusTextField.text = @"Unknown";
        }
    }
}

- (void) getUser {
    NSString *userId = self.userView.userIdTextField.text;
    
    [self doURLRequest:[NSString stringWithFormat:@"/users/%@.json", userId]
            HTTPMethod:@"GET"
              jsonData:nil];
    
}

- (void) updateChildLocation {
    NSString *userId = self.userView.userIdTextField.text;
    NSString *longitudeStr = self.userView.currLongitudeTextField.text;
    NSString *latitudeStr = self.userView.currLatitudeTextField.text;
    
    double longitude = [longitudeStr doubleValue];
    double latitude = [latitudeStr doubleValue];
    
    NSDictionary *user = @{@"username"          : userId,
                           @"current_lat"       : [NSNumber numberWithDouble: latitude],
                           @"current_longitude" : [NSNumber numberWithDouble: longitude]};
    
    NSDictionary *childDict = @{@"utf8"               : @"",
                                @"authenticity_token" : @"EvZva3cKnzo3Y0G5R3NktucCr99o/2UWOPVAmJYdBOc=",
                                @"user"               : user,
                                @"commit"             : @"CreateUser",
                                @"action"             : @"update",
                                @"controller"         : @"users"};
    
    NSData *json = [self convertToJSON:childDict];
    [self doURLRequest:[@"/users/" stringByAppendingString: userId]
            HTTPMethod:@"PATCH"
              jsonData:json];
}


// MARK: NSURLConnection Methods
- (void) doURLRequest:(NSString *)action HTTPMethod:(NSString *)method jsonData:(NSData *)jsonData {
    
    NSString *urlStr = [@"http://protected-wildwood-8664.herokuapp.com" stringByAppendingString:action];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = method;
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    if (jsonData) {
        request.HTTPBody = jsonData;
    }
    
    NSLog(@"doURLRequest: %@", request);
    
    self.urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (!self.urlConnection) {
        NSLog(@"Error initializing URLConnection.");
    }
}


- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    //NSLog(@"connection:didReceiveResponse: %@", response);
    NSLog(@"connection:didReceiveResponse: URL: %@", response.URL);
    NSLog(@"connection:didReceiveResponse: textEncodingName: %@", response.textEncodingName);
    NSLog(@"connection:didReceiveResponse: MIMEType: %@", response.MIMEType);
    NSLog(@"connection:didReceiveResponse: suggestedFilename: %@", response.suggestedFilename);
    NSLog(@"connection:didReceiveResponse: expectedContentLength: %lld", response.expectedContentLength);
    
    self.isUrlDataJson = [response.MIMEType isEqualToString:@"application/json"];
    
    if (self.isUrlDataJson) {
        self.urlData = [NSMutableData dataWithCapacity:0];
    }
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"connection:didReciveData: data: %lu bytes", (unsigned long)data.length);
    if (self.isUrlDataJson) {
        [self.urlData appendData:data];
    }
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"connection:didFailWithError: %@ %@", [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    
    self.urlConnection = nil;
    self.urlData = nil;
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading: ");
    if (self.isUrlDataJson) {
        [self setUser];
    }
}

// MARK: JSON - NSDictionary methods;
- (NSData *) convertToJSON:(NSDictionary *)dictionary {
    NSData *jsonData;
    
    if ([NSJSONSerialization isValidJSONObject:dictionary]) {
        NSError *error;
        jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
        if (error) {
            NSLog(@"Error: %@", [error localizedDescription]);
        }
        else {
            NSString *jsonStr  = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"JSON: %@", jsonStr);
        }
    }
    
    return jsonData;
}

- (NSDictionary *) convertToDictionary:(NSData *)jsonData {
    NSDictionary *jsonDict;
    
    NSError *error;
    id object = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    if (error) {
        NSLog(@"convertToDictionary: Error: %@", [error localizedDescription]);
    }
    else if (![NSJSONSerialization isValidJSONObject:object]){
        NSLog(@"convertToDictionary: Error: object is not json");
    }
    else if ([object isKindOfClass:[NSDictionary class]]) {
        jsonDict = (NSDictionary *)object;
    }
    
    return jsonDict;
}


// MARK: CLLocationManagerDelegate methods
- (void) setupLocationManager {
    BOOL enabled = [CLLocationManager locationServicesEnabled];
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    if (enabled
        && status != kCLAuthorizationStatusDenied
        && status != kCLAuthorizationStatusRestricted) {
        
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        
        if (status == kCLAuthorizationStatusNotDetermined) {
            [self.locationManager requestWhenInUseAuthorization];
        }
    }
}

- (void) locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status != kCLAuthorizationStatusNotDetermined) {
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.locationManager startUpdatingLocation];
    }
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *loc = [locations lastObject];
    self.userView.currLongitudeTextField.text = [NSString stringWithFormat:@"%f", loc.coordinate.longitude];
    self.userView.currLatitudeTextField.text = [NSString stringWithFormat:@"%f", loc.coordinate.latitude];
    self.userView.longitudeTextField.placeholder = [NSString stringWithFormat:@"%f", loc.coordinate.longitude];
    self.userView.latitudeTextField.placeholder = [NSString stringWithFormat:@"%f", loc.coordinate.latitude];
    [self.view setNeedsDisplay];
}

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"locationManager:didFailWithError: %@", error.localizedDescription);
}

@end
