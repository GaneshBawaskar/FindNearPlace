//
//  AppDelegate.m
//  FindNearPlace
//
//  Created by Sabertooth on 07/01/18.
//  Copyright © 2018 Sabertoothasda. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    //
    // ++ Init keys
    //
    [[NSUserDefaults standardUserDefaults] setObject:@"21.147,79.13" forKey:@"LocCoordinate"];
    [[NSUserDefaults standardUserDefaults] setObject:@"Gurudev Nagar, Bapu Nagar, Nandanvan, Nagpur" forKey:@"AddressLocation"];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"AIzaSyAVSxn0lFQ-jnsDuf4Rm9oeePxr4KUvDXQ" forKey:@"API_KEY"];
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
