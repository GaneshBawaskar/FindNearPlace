//
//  LocationInfoCtrl.m
//  FindNearPlace
//
//  Created by Sabertooth on 11/01/18.
//  Copyright © 2018 Sabertoothasda. All rights reserved.
//

#import "LocationInfoCtrl.h"

@interface LocationInfoCtrl ()

@end

@implementation LocationInfoCtrl
@synthesize NLocation;
@synthesize OLocation;
@synthesize m_newLocation;
@synthesize m_oldLocation;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}


-(void)awakeFromNib {
    NSUserDefaults *defaults;
    NSString *OldLocation;
    defaults = [NSUserDefaults standardUserDefaults];
    OldLocation =  [defaults stringForKey:@"AddressLocation"];
    if ([OldLocation isEqualToString:@""] || !OldLocation) {
        [OLocation setStringValue:@"Location not set"];
    }
    else{
        [OLocation setStringValue:OldLocation];
    }
}


-(void)ConvertAddressToCoordinateAndSave:(NSString *)Address {
    
    NSError *error;
    NSData *data = nil;
    NSString *StdUrl = nil;
    NSString *Results = nil;
    NSString *LocCoordinate = nil;
    NSDictionary *rsltLocLatLngDict = nil;
    NSString *LocAddress = nil;
    NSString *newLoc = [NLocation stringValue];
    NSString *UrlString = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=false", newLoc];
    
    StdUrl = [UrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    Results = [NSString stringWithContentsOfURL:[NSURL URLWithString:StdUrl] encoding:NSUTF8StringEncoding error:&error];
    if (!Results || [Results isEqualToString:@""]) {
        NSLog(@"%@", [error description]);
        return;
    }
    
    data = [Results dataUsingEncoding:NSUTF8StringEncoding];
    if (!data) {
        return;
    }

    id dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) {
        NSLog(@"Error parsing JSON: %@", error);
    }
    
    if ([dict isKindOfClass:[NSDictionary class]]) {
        rsltLocLatLngDict = [[[[dict objectForKey:@"results"] objectAtIndex:0] objectForKey:@"geometry"] objectForKey:@"location"];
        LocAddress = [[[dict objectForKey:@"results"] objectAtIndex:0] objectForKey:@"formatted_address"];
    }
    
    LocCoordinate = [NSString stringWithFormat:@"%@,%@", [rsltLocLatLngDict objectForKey:@"lat"], [rsltLocLatLngDict objectForKey:@"lng"]];
    
    if ([LocCoordinate isEqualToString:@""] || !LocCoordinate) {
        return;
    }
    
    if (LocCoordinate)
        [[NSUserDefaults standardUserDefaults] setObject:LocCoordinate forKey:@"LocCoordinate"];
    
    if (LocAddress)
        [[NSUserDefaults standardUserDefaults] setObject:LocAddress forKey:@"AddressLocation"];
    
}


-(IBAction)Ok:(id)sender
{
    NSString *newLoc = [NLocation stringValue];
    if ([newLoc isEqualToString:@""]|| !newLoc)
    {
        [self dismissController:self];
        return;
    }
    else
    {
      [self ConvertAddressToCoordinateAndSave:newLoc];
    }
    
    [self dismissController:self];
}


-(void)setODLocation:(NSString *)loc{
    
    if (!m_oldLocation)
    {
        m_oldLocation = [[NSMutableString alloc] init];
    }
    
    [m_oldLocation setString:loc];
}


-(void)setNWLocation:(NSString *)loc{
    
    if (!m_newLocation){
         m_newLocation = [[NSMutableString alloc] init];
    }
    
    [m_newLocation setString:loc];
}



@end
