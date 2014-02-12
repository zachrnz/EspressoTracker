//
//  AppDelegate.m
//  Espresso Tracker
//
//  Created by Zachary Arendsee on 9/25/13.
//  Copyright (c) 2013 Zulu Alpha Design, Inc. All rights reserved.
//

#import "AppDelegate.h"
//#import "DataStore.h"
//#import "Shot.h"
//#import "Beans.h"
//#import "Variable.h"
//#import "ShotData.h"
//#import "Shot+Custom.h"
//#import "Beans+Custom.h"
//#import "NewShotViewController.h"
//#import "NewShotViewController.m"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    NSManagedObjectContext *context = [self managedObjectContext];
//    NSManagedObject *failedBankInfo = [NSEntityDescription
//                                       insertNewObjectForEntityForName:@"FailedBankInfo"
//                                       inManagedObjectContext:context];
//    [failedBankInfo setValue:@"Test Bank" forKey:@"name"];
//    [failedBankInfo setValue:@"Testville" forKey:@"city"];
//    [failedBankInfo setValue:@"Testland" forKey:@"state"];
//    NSManagedObject *failedBankDetails = [NSEntityDescription
//                                          insertNewObjectForEntityForName:@"FailedBankDetails"
//                                          inManagedObjectContext:context];
//    [failedBankDetails setValue:[NSDate date] forKey:@"closeDate"];
//    [failedBankDetails setValue:[NSDate date] forKey:@"updateDate"];
//    [failedBankDetails setValue:[NSNumber numberWithInt:12345] forKey:@"zip"];
//    [failedBankDetails setValue:failedBankInfo forKey:@"info"];
//    [failedBankInfo setValue:failedBankDetails forKey:@"details"];
//    NSError *error;
//    if (![context save:&error]) {
//        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
//    }
    


    

    
/* OLD MODEL:
    
    //Test setup 1
    Shot *shot1 = [NSEntityDescription insertNewObjectForEntityForName:@"Shot" inManagedObjectContext:context];
    [shot1 setValue:[NSDate date] forKey:@"datePulled"];
    [shot1 setValue:[NSNumber numberWithInt:26] forKey:@"pullTimeInSeconds"];
    Beans *beans1 = [NSEntityDescription insertNewObjectForEntityForName:@"Beans" inManagedObjectContext: context];
    [beans1 setValue:@"Black Cat Espresso" forKey:@"name"];
    [beans1 setValue:@"Intelligentsia" forKey:@"roaster"];
    [beans1 setValue:@"Blend" forKey:@"region"];
    [beans1 setValue:[NSDate date] forKey:@"roastDate"];
    [shot1 setValue:beans1 forKey:@"beans"];
    
    //Test setup 2
    Shot *shot2 = [NSEntityDescription insertNewObjectForEntityForName:@"Shot" inManagedObjectContext:context];
    [shot2 setValue:[NSDate date] forKey:@"datePulled"];
    [shot2 setValue:[NSNumber numberWithInt:26] forKey:@"pullTimeInSeconds"];
    Beans *beans2 = [NSEntityDescription insertNewObjectForEntityForName:@"Beans" inManagedObjectContext: context];
    [beans2 setValue:@"Coffee2" forKey:@"name"];
    [beans2 setValue:@"Roaster2" forKey:@"roaster"];
    [beans2 setValue:@"Region2" forKey:@"region"];
    [beans2 setValue:pastDate forKey:@"roastDate"];
    [shot2 setValue:beans2 forKey:@"beans"];
    
    
    shot1.groundsWeightInGrams = [NSNumber numberWithInt:1];
    shot2.groundsWeightInOunces = [NSNumber numberWithFloat:1];
    
    shot1.espressoVolumeInFluidOunces = [NSNumber numberWithFloat:1];
    shot2.espressoVolumeInML = [NSNumber numberWithFloat:1];
    
    shot1.espressoWeightInGrams = [NSNumber numberWithFloat:1];
    shot2.espressoWeightInOunces = [NSNumber numberWithFloat:1];

 */
 
/*  //EXAMPLE:
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"FailedBankInfo" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *info in fetchedObjects) {
        NSLog(@"Name: %@", [info valueForKey:@"name"]);
        NSManagedObject *details = [info valueForKey:@"details"];
        NSLog(@"Zip: %@", [details valueForKey:@"zip"]);
    }
*/
  
    

/* OLD MODEL:
 
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Shot" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    int count = 1;
    for (Shot *shot in fetchedObjects) {
        Beans *beans = [shot valueForKey:@"beans"];
        NSLog(@"Beans name (%i): %@", count,  [beans valueForKey:@"name"]);
        NSLog(@"Beans roast date: %@", [formatter stringFromDate:beans.roastDate]);
        NSLog(@"Date Pulled: %@", [formatter stringFromDate:shot.datePulled]);
        
        int age = shot.beanAgeInDays.intValue;
        NSLog(@"Shot bean age (%i): %i", count, age);
        
        NSLog(@"Pull time in seconds (%i): %@", count, [shot valueForKey:@"pullTimeInSeconds"]);
        NSLog(@"Grounds weight in grams (%i): %f", count,  shot.groundsWeightInGrams.floatValue);
        NSLog(@"Grounds weight in ounces (%i): %f", count,  shot.groundsWeightInOunces.floatValue);
        NSLog(@"Espresso weight in grams (%i): %f", count,  shot.espressoWeightInGrams.floatValue);
        NSLog(@"Espresso weight in ounces (%i): %f", count,  shot.espressoWeightInOunces.floatValue);
        NSLog(@"Espresso volume in ml (%i): %f", count,  shot.espressoVolumeInML.floatValue);
        NSLog(@"Espresso volume in fl. ounces (%i): %f", count,  shot.espressoVolumeInFluidOunces.floatValue);
        count++;
    }

*/
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    //[[DataStore sharedDataStore] saveData];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
#warning saving is turned off. Make sure to reactivate in other methods as well.
    //[[DataStore sharedDataStore] saveData];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    //[[DataStore sharedDataStore] saveData];
}

@end
