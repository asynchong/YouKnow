//
//  AppDelegate.m
//  OneTheBike
//
//  Created by szk on 14-9-24.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import "AppDelegate.h"

#import "MainViewController.h"

#import "HistoryViewController.h"

#import "StartViewController.h"

#import "FindViewController.h"

#import "MineViewController.h"

/*
 第三方登录
 Q Q 2765869240
 邮箱 2765869240@qq.com
 */
#import "UMSocial.h"

#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaHandler.h"

#define UmengAppkey @"5423e48cfd98c58eed00664f"

//#define SinaAppKey @"2470821654"
//#define SinaAppSecret @"bea7d21c9647406a25960a617a8e40a8"

#define SinaAppKey @"4197263606"
#define SinaAppSecret @"7c43201436878420f8b5ee335062d549"

//fbauto
#define QQAPPID @"1101950003" //十六进制:41AE6C33; 生成方法:echo 'ibase=10;obase=16;1101950003'|bc
#define QQAPPKEY @"JAtVGEGeQWk9icsK"

//fbauto
#define WXAPPID @"wx0ad0d507a8933b9d"
#define WXAPPSECRET @"SADSDAS"

#define RedirectUrl @"http://sns.whalecloud.com/sina2/callback"

//人人网
#define REN_APPID @"272107"
#define REN_APIKEY @"8399387c4fe34861b73585d5f99d93c4"
#define REN_SecretKey @"1762208535a047e18bd0799b7a21b7ab"

//高德地图
#import <MAMapKit/MAMapKit.h>



@interface AppDelegate ()<CLLocationManagerDelegate>
{
    //IOS8 定位
    UINavigationController *_navController;
    CLLocationManager      *_locationmanager;
}
@end

@implementation AppDelegate




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    MainViewController * mainVC = [[MainViewController alloc] init];
    
    HistoryViewController * microBBSVC = [[HistoryViewController alloc] init];
    
    StartViewController * messageVC = [[StartViewController alloc] init];
    
    FindViewController * foundVC = [[FindViewController alloc] init];
    
    MineViewController * mineVC = [[MineViewController alloc] init];
    
    UINavigationController * navc1 = [[UINavigationController alloc] initWithRootViewController:mainVC];
    
    UINavigationController * navc2 = [[UINavigationController alloc] initWithRootViewController:microBBSVC];
    
    UINavigationController * navc3 = [[UINavigationController alloc] initWithRootViewController:messageVC];
    
    UINavigationController * navc4 = [[UINavigationController alloc] initWithRootViewController:foundVC];
    
    UINavigationController * navc5 = [[UINavigationController alloc] initWithRootViewController:mineVC];
    
    
    navc1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"运动" image:[UIImage imageNamed:@"bike.png"] selectedImage:[UIImage imageNamed:@"bike.png"]];
    
    navc2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"历史" image:[UIImage imageNamed:@"history.png"] selectedImage:[UIImage imageNamed:@"history.png"]];
    
    navc3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"开始" image:[UIImage imageNamed:@"start.png"] selectedImage:[UIImage imageNamed:@"start.png"]];
    
    navc4.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:[UIImage imageNamed:@"find.png"] selectedImage:[UIImage imageNamed:@"find.png"]];
    
    navc5.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"mine.png"] selectedImage:[UIImage imageNamed:@"mine.png"]];
    
    
    UITabBarController * tabbarVC = [[UITabBarController alloc] init];
    
    tabbarVC.viewControllers = [NSArray arrayWithObjects:navc1,navc2,navc3,navc4,navc5,nil];
    
    tabbarVC.selectedIndex = 0;
    
      tabbarVC.tabBar.tintColor=[UIColor redColor];
    
    
    tabbarVC.tabBar.backgroundImage = [UIImage imageNamed:@""];
    
    
//    [MobClick startWithAppkey:@"5368ab4256240b6925029e29"];
    
    //微信
    
    //友盟第三方登录分享
    [self umengShare];
    
    
    
    
    //高德地图
    [self configureAPIKey];
    [UIApplication sharedApplication].idleTimerDisabled = TRUE;
    
    _locationmanager = [[CLLocationManager alloc] init];
    [_locationmanager requestAlwaysAuthorization];        //NSLocationAlwaysUsageDescription
    [_locationmanager requestWhenInUseAuthorization];     //NSLocationWhenInUseDescription
    _locationmanager.delegate = self;
    
    
    self.window.rootViewController = tabbarVC;
    
    return YES;
}




- (void)configureAPIKey
{
    
    
    if ([APIKey_MAP length] == 0)
    {
#define kMALogTitle @"提示"
#define kMALogContent @"0b92a81f23cc5905c30dcb4c39da609d"
        
        NSString *log = [NSString stringWithFormat:@"[MAMapKit] %@", kMALogContent];
        NSLog(@"%@", log);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kMALogTitle message:kMALogContent delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];
        });
    }
    
    [MAMapServices sharedServices].apiKey = (NSString *)APIKey_MAP;
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.fblife.OneTheBike" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"OneTheBike" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"OneTheBike.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

/**
 这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}

/**
 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UMSocialSnsService  applicationDidBecomeActive];
}


#pragma mark - 友盟分享

- (void)umengShare
{
    [UMSocialData setAppKey:UmengAppkey];
    
    //打开调试log的开关
    [UMSocialData openLog:YES];
    
    //打开新浪微博的SSO开关
    [UMSocialSinaHandler openSSOWithRedirectURL:RedirectUrl];
    
    //设置分享到QQ空间的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:QQAPPID appKey:QQAPPKEY url:@"http://www.umeng.com/social"];
    
    //设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];
    
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:WXAPPID appSecret:WXAPPSECRET url:@"http://www.umeng.com/social"];

}

@end
