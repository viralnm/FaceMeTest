//
//  AppDelegate.m
//  FaceMe
//
//  Created by Oneclick IT Solution on 9/14/17.
//  Copyright © 2017 One Click IT Consultancy Pvt Ltd. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //    [Fabric with:@[[Crashlytics class]]];
    
    deviceTokenStr = @"1234";
    
    appLatitude = @"0";
    appLongitude = @"0";
    
    /*-------------Push Notitications------------*/
    [self askPushNotificationPermission];
    /*-------------------------------------------*/
    
    
    /*-----------Start Location Manager----------*/
    [self getLocationMethod];
    /*-------------------------------------------*/
    
    InfoScreensVC * splash = [[InfoScreensVC alloc] init];
    UINavigationController * navControl = [[UINavigationController alloc] initWithRootViewController:splash];
    navControl.navigationBarHidden=YES;
    self.window.rootViewController = navControl;
    
    [_window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Location manager delegate
-(void)getLocationMethod
{
    NSLog(@"%s",__FUNCTION__);
    /*-----------Start Location Manager----------*/
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; // 100 m
    if(IS_OS_8_OR_LATER) {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
    /*-------------------------------------------*/
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil)
    {
        if ([appLatitude isEqualToString:@"0"] && [appLongitude isEqualToString:@"0"])
        {
            NSLog(@"%s",__FUNCTION__);
            appLatitude =[NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
            appLongitude =[NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadRestaurantListNotification" object:nil];
        }
        else
        {
            appLatitude =[NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
            appLongitude =[NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
        }
    }
    
    NSLog(@"appLatitude===%@,appLongitude====%@",appLatitude,appLongitude);
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error===%@",error);
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark - Orientation
-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - Remote notification
-(void)askPushNotificationPermission
{
    /*-------------Push Notitications------------*/
    // Register for Push Notitications, if running iOS 8
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        // Register for Push Notifications before iOS 8
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
        //        [application enabledRemoteNotificationTypes];
    }
    /*-------------------------------------------*/
}

#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:   (UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString   *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
    }
}

#endif

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    deviceTokenStr = [[[[deviceToken description]
                        stringByReplacingOccurrencesOfString: @"<" withString: @""]
                       stringByReplacingOccurrencesOfString: @">" withString: @""]
                      stringByReplacingOccurrencesOfString: @" " withString: @""] ;
    NSLog(@"My device token ============================>>>>>>>>>>>%@",deviceTokenStr);
    
    // Pass device token to auth.
    //    [[FIRAuth auth] setAPNSToken:deviceToken type:FIRAuthAPNSTokenTypeProd];
    // Further handling of the device token if needed by the app.
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}


#pragma mark - Error Message
-(void)ShowErrorPopUpWithErrorCode:(NSInteger)errorCode andMessage:(NSString*)errorMessage
{
    NSString * strErrorMessage;
    if (errorCode == -1004){
        strErrorMessage = @"Could not connect to the server";
    }    else if (errorCode == -1009){
        strErrorMessage = @"No Network Connection";
    }else if (errorCode == -1005){
        strErrorMessage = @"Network Connection Lost";
        //        strErrorMessage = @"";
    }else if (errorCode == -1001){
        strErrorMessage = @"Request Timed Out";
    }else if (errorCode == customErrorCodeForMessage){//custom message
        strErrorMessage = errorMessage;
    }
    
    
    [viewNetworkConnectionPopUp removeFromSuperview];
    [viewNetworkConnectionPopUp setAlpha:0.0];
    
    if (![strErrorMessage isEqualToString:@""])
    {
        viewNetworkConnectionPopUp = [[UIView alloc] initWithFrame:CGRectMake(0, -64, DEVICE_WIDTH, 64)];
        [viewNetworkConnectionPopUp setBackgroundColor:[UIColor clearColor]];
        [self.window addSubview:viewNetworkConnectionPopUp];
        
        UIView * viewTrans = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewNetworkConnectionPopUp.frame.size.width, viewNetworkConnectionPopUp.frame.size.height)];
        [viewTrans setBackgroundColor:[self colorWithHexString:dark_red_color]];
        [viewTrans setAlpha:0.9];
        [viewNetworkConnectionPopUp addSubview:viewTrans];
        
        UIImageView * imgProfile = [[UIImageView alloc] initWithFrame:CGRectMake(50, 24, 16, 16)];
        [imgProfile setImage:[UIImage imageNamed:@"cross.png"]];
        imgProfile.contentMode = UIViewContentModeScaleAspectFit;
        imgProfile.clipsToBounds = YES;
        //[viewNetworkConnectionPopUp addSubview:imgProfile];
        
        UILabel * lblMessage = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, DEVICE_WIDTH-40, 44)];
        [lblMessage setBackgroundColor:[UIColor clearColor]];
        [lblMessage setTextColor:[UIColor whiteColor]];
        [lblMessage setTextAlignment:NSTextAlignmentCenter];
        [lblMessage setNumberOfLines:2];
        [lblMessage setText:[NSString stringWithFormat:@"%@",strErrorMessage]];
        [lblMessage setFont:[UIFont systemFontOfSize:14]];
        [viewNetworkConnectionPopUp addSubview:lblMessage];
        
        
        [UIView transitionWithView:viewNetworkConnectionPopUp duration:0.3
                           options:UIViewAnimationOptionCurveEaseIn
                        animations:^{
                            [viewNetworkConnectionPopUp setFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
                        }
                        completion:^(BOOL finished) {
                        }];
    }
    
    [timerNetworkConnectionPopUp invalidate];
    timerNetworkConnectionPopUp = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(removeNetworkConnectionPopUp:) userInfo:nil repeats:NO];
}

-(void)removeNetworkConnectionPopUp:(NSTimer*)timer
{
    [UIView transitionWithView:viewNetworkConnectionPopUp duration:0.3
                       options:UIViewAnimationOptionCurveEaseIn
                    animations:^{
                        [viewNetworkConnectionPopUp setFrame:CGRectMake(0, -64, DEVICE_WIDTH, 64)];
                    }
                    completion:^(BOOL finished)
     {
         [viewNetworkConnectionPopUp removeFromSuperview];
     }];
}

#pragma mark - Hud Method
-(void)hudForprocessMethod
{
    [self hudEndProcessMethod];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.window];
    [self.window addSubview:HUD];
    [HUD show:YES];
}

-(void)hudEndProcessMethod
{
    [HUD hide:YES];
    [HUD removeFromSuperview];
    HUD=nil;
}


#pragma mark - Global Helper Functions
-(BOOL)validateEmail:(NSString*)email
{
    if( (0 != [email rangeOfString:@"@"].length) &&  (0 != [email rangeOfString:@"."].length) )
    {
        NSMutableCharacterSet *invalidCharSet = [[[NSCharacterSet alphanumericCharacterSet] invertedSet]mutableCopy];
        [invalidCharSet removeCharactersInString:@"_-"];
        
        NSRange range1 = [email rangeOfString:@"@" options:NSCaseInsensitiveSearch];
        
        // If username part contains any character other than "."  "_" "-"
        
        NSString *usernamePart = [email substringToIndex:range1.location];
        NSArray *stringsArray1 = [usernamePart componentsSeparatedByString:@"."];
        for (NSString *string in stringsArray1)
        {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet: invalidCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
                return FALSE;
        }
        
        NSString *domainPart = [email substringFromIndex:range1.location+1];
        NSArray *stringsArray2 = [domainPart componentsSeparatedByString:@"."];
        
        for (NSString *string in stringsArray2)
        {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet:invalidCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
                return FALSE;
        }
        
        return TRUE;
    }
    else {// no '@' or '.' present
        return FALSE;
    }
}

-(UIColor *) colorWithHexString:(NSString *)stringToConvert
{
    // NSLog(@"ColorCode -- %@",stringToConvert);
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    
    // strip 0X if it appears
    
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
            
                           green:((float) g / 255.0f)
            
                            blue:((float) b / 255.0f)
            
                           alpha:1.0f];
}

- (UIImage *)imageFromColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(CGFloat)getHeightForText:(NSString*)givenText andWidth:(CGFloat)givenWidth andFontSize:(CGFloat)fontSize andFontWeight:(CGFloat)fontWeight
{
    CGSize boundingSize = CGSizeMake(givenWidth, 0);
    
    CGSize itemTextSize = [givenText boundingRectWithSize:boundingSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize weight:UIFontWeightRegular]} context:nil].size;
    
    float textHeight = itemTextSize.height+5;
    
    return textHeight;
}

-(NSString*)getCurrentTimeAndDate
{
    NSDate* date = [NSDate date];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * currentdate = [df stringFromDate:date];
    return currentdate;
}

-(NSString*)getCurrentDateOnly
{
    NSDate* date = [NSDate date];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString * currentdate = [df stringFromDate:date];
    return currentdate;
}

#pragma mark - Check Internet Connection
-(void)checkInternetConnectionAvailability
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    //    NSLog(@"status===%ld",(long)status);
    
    NSString * strStatus = [NSString stringWithFormat:@"%ld",(long)status];
    [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateInternetAvailabilityNotification object:strStatus];
    
    /*if(status == NotReachable)
     {
     
     //No internet
     NSLog(@"NotReachable");
     [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateInternetAvailabilityNotification object:strStatus];
     }
     else if (status == ReachableViaWiFi || status == ReachableViaWWAN)
     {
     //WiFi
     NSLog(@"ReachableViaWiFi");
     
     }*/
}


@end
