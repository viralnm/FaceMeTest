//
//  AppDelegate.h
//  FaceMe
//
//  Created by Oneclick IT Solution on 9/14/17.
//  Copyright © 2017 One Click IT Consultancy Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LoginVC.h"
#import "RegisterVC.h"
#import "DashboardVC.h"
#import "InfoScreensVC.h"
#import "MBProgressHUD.h"


NSString * deviceTokenStr;
NSString * appLatitude;
NSString * appLongitude;

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>
{
    CLLocationManager * locationManager;
    
    UIView * viewNetworkConnectionPopUp;
    NSTimer * timerNetworkConnectionPopUp;
    
    MBProgressHUD *HUD;
}

#pragma mark - Helper Methods
-(UIColor *) colorWithHexString:(NSString *)stringToConvert;
-(BOOL)validateEmail:(NSString*)email;
- (UIImage *)imageFromColor:(UIColor *)color;

-(void)hudForprocessMethod;
-(void)hudEndProcessMethod;

-(void)getLocationMethod;
-(void)askPushNotificationPermission;

-(CGFloat)getHeightForText:(NSString*)givenText andWidth:(CGFloat)givenWidth andFontSize:(CGFloat)fontSize andFontWeight:(CGFloat)fontWeight;

-(void)ShowErrorPopUpWithErrorCode:(NSInteger)errorCode andMessage:(NSString*)errorMessage;

-(NSString*)getCurrentTimeAndDate;
-(NSString*)getCurrentDateOnly;

-(void)checkInternetConnectionAvailability;



@property (strong, nonatomic) UIWindow *window;


@end

