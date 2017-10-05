//
//  Constant.h
//  ibeacon stores
//
//  Created by One Click IT Consultancy  on 5/14/14.
//  Copyright (c) 2014 One Click IT Consultancy . All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Constant <NSObject>

typedef enum ScrollDirection {
    ScrollDirectionNone,
    ScrollDirectionRight,
    ScrollDirectionLeft,
    ScrollDirectionUp,
    ScrollDirectionDown,
    ScrollDirectionCrazy,
} ScrollDirection;


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_4 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 480.0f)
#define IS_IPHONE_5 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)
#define IS_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0f)
#define IS_IPHONE_6plus (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0f)

#define IS_IPAD ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


#define DEVICE_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define DEVICE_WIDTH [[UIScreen mainScreen] bounds].size.width



#define customErrorCodeForMessage 123456

#define kEmptyString @""

#define kDeviceType @"2"

#define Alert_Animation_Type URBAlertAnimationTopToBottom

#define APP_DELEGATE (AppDelegate*)[[UIApplication sharedApplication]delegate]

#define WEB_SERVICE_URL @"http://52.59.153.164:3000/"

#define SCAN_DEVICE_VALIDATION_STRING @"Bean"


#define ALERT_TITLE @"IAC"
#define OK_BTN                  @"OK"
#define ALERT_CANCEL            @"Cancel"
#define ALERT_DELETE            @"Delete"
#define ALERT_EDIT              @"Edit"
#define ACTION_TAKE_PHOTO       @"Take Photo"
#define ACTION_LIBRARY_PHOTO    @"Photo From Library"

#define CONNECTION_FAILED       @"Please check internet connection"


#pragma mark User Credential-----------------------------------------

#define CURRENT_USER_ID [[NSUserDefaults standardUserDefaults] valueForKey:@"CURRENT_USER_ID"]
#define CURRENT_USER_ACCESS_TOKEN [[NSUserDefaults standardUserDefaults] valueForKey:@"CURRENT_USER_ACCESS_TOKEN"]

#define IS_INFO_SCREEN_VISIBLE_ONCE [[NSUserDefaults standardUserDefaults] valueForKey:@"IS_INFO_SCREEN_VISIBLE_ONCE"]

#define CURRENT_USER_EMAIL [[NSUserDefaults standardUserDefaults] valueForKey:@"CURRENT_USER_EMAIL"]
#define CURRENT_USER_FIRST_NAME [[NSUserDefaults standardUserDefaults] valueForKey:@"CURRENT_USER_FIRST_NAME"]
#define CURRENT_USER_LAST_NAME [[NSUserDefaults standardUserDefaults] valueForKey:@"CURRENT_USER_LAST_NAME"]
#define CURRENT_USER_IMAGE [[NSUserDefaults standardUserDefaults] valueForKey:@"CURRENT_USER_IMAGE"]


#define CURRENT_USER_PHONE_NUMBER [[NSUserDefaults standardUserDefaults] valueForKey:@"CURRENT_USER_PHONE_NUMBER"]




#pragma mark - Notifications ---------------------------
#define kUpdateInternetAvailabilityNotification @"updateInternetAvailabilityNotification"


#pragma mark - Color Codes------------------------------

#define dark_gray_color @"4d4d4d"
#define light_gray_color @"d3d3d3"
#define light_yellow_color @"f4c929"
#define White_color @"ffffff"
#define dark_red_color @"ae0125"
#define dark_blue_color @"175181"
#define dark_green_color @"3C905A"
#define light_green_color @"2dce28"

#define App_Background_color @"F4F4F4"
#define App_Header_Color @"FFFFFF"
#define header_font_color @"0b5ab2"
#define orange_color @"eb3e2d"

#define blue_color @"0b5ab2"


#pragma mark - Images------------------------------------
#define Image_App_Background @""
#define Icon_Stats @"icon_stats.png"
#define Icon_Back_Button @"back_icon.png"
#define Icon_Close_Button @"icon_close.png"
#define Icon_Search @"search_icon.png"
#define PlaceHolderImage @"txtbox_icon.png"


@end
