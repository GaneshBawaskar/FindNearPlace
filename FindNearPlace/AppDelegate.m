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
    
    [[NSUserDefaults standardUserDefaults] setObject:@"AIzaSyCAjzh1MKW2MVtl493LQiooASqqYGjL4Yw" forKey:@"API_KEY"];
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
