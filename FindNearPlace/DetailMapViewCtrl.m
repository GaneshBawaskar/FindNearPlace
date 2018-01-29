//
//  DetailMapViewCtrl.m
//  FindNearPlace
//
//  Created by Sabertooth on 11/01/18.
//  Copyright © 2018 Sabertoothasda. All rights reserved.
//

#import "DetailMapViewCtrl.h"

@interface DetailMapViewCtrl ()

@end
@class ViewController;
@implementation DetailMapViewCtrl
@synthesize infoArray;
@synthesize m_mapView;
@synthesize m_name;
@synthesize m_address;
@synthesize m_contact;
@synthesize m_weekdays;
@synthesize m_postcode;
@synthesize indicator;
@synthesize Index;
-(id)init {
    
    Index = 0;
    self = [super init];
    if (!self) {
        return nil;
    }
    
    return self;
}


- (void)viewDidLoad {
    [m_weekdays sizeToFit];
    [super viewDidLoad];
    [self setTitle:@"Place Details"];
    [self updateCtrl];
}


-(NSDictionary *)GetDetailInfo:(NSString*)placeid {
    
    NSError *error;
    NSData *data = nil;
    NSString *name  = nil;
    NSString *address = nil;
    NSString *weekdays = @"";
    NSString *mobileNumber = nil;
    NSString *StdUrl = nil;
    NSString *Results = nil;

    NSString *apikey;
    apikey = [[NSUserDefaults standardUserDefaults] objectForKey:@"API_KEY"];
    NSString *UrlString = [NSString stringWithFormat: @"https://maps.googleapis.com/maps/api/place/details/json?placeid=%@&key=%@", placeid, apikey];
    StdUrl = [UrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    Results = [NSString stringWithContentsOfURL:[NSURL URLWithString:StdUrl] encoding:NSUTF8StringEncoding error:&error];
    
    if (!Results || [Results isEqualToString:@""]) {
        NSLog(@"%@", [error description]);
        return nil;
    }
    
    data = [Results dataUsingEncoding:NSUTF8StringEncoding];
    if (!data) {
        return nil;
    }
    
    id dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) {
        NSLog(@"Error parsing JSON: %@", error);
    }
    
    if ([dict isKindOfClass:[NSDictionary class]]) {
        dict = [dict objectForKey:@"result"];
    }
    
    address = [dict objectForKey:@"formatted_address"];
    NSArray *weekday_text = [[dict objectForKey:@"opening_hours"] objectForKey:@"weekday_text"];
    for (NSString *text in weekday_text) {
        weekdays = [NSString stringWithFormat:@"%@\n %@",weekdays, text];
    }
    
    name =  [[infoArray objectAtIndex:Index] objectForKey:@"name"];
    mobileNumber = [dict objectForKey:@"formatted_phone_number"];
    NSString *PostalCode;
    NSArray *arrCompo = [dict objectForKey:@"address_components"] ;
    for (NSDictionary *types in arrCompo){
        if ([[types objectForKey:@"types"] containsObject:@"postal_code"])
        {
            PostalCode = [types objectForKey:@"long_name"];
            if (PostalCode)
                [m_postcode setStringValue:PostalCode];
            else
                [m_postcode setStringValue:@"Not available"];
            break;
        }
    }

    if (name)
        [m_name setStringValue:name];
    
    if (address)
        [m_address setStringValue:address];
    else
        [m_address setStringValue:@"Not available"];
    
    if (mobileNumber)
        [m_contact setStringValue:mobileNumber];
    else
        [m_contact setStringValue:@"Not available "];
    
    if ([weekdays isEqualToString:@""])
        [m_weekdays setStringValue:@"Information not available"];
    else
        [m_weekdays setStringValue:weekdays];
    
    long int intgervalue = [[[infoArray objectAtIndex:Index] objectForKey:@"rating"] integerValue];
    [indicator setDoubleValue:intgervalue];

    return nil;
}



-(void)updateCtrl
{
    NSDictionary *dict = [infoArray objectAtIndex:Index];
    NSString *loc = [dict objectForKey:@"location"];
    NSArray *latlng = [loc componentsSeparatedByString:@","];
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [[latlng objectAtIndex:0] doubleValue];;
    coordinate.longitude = [[latlng objectAtIndex:1] doubleValue];;
    [annotation setCoordinate:coordinate];
    [annotation setTitle:[dict objectForKey:@"name"]];
    [annotation setSubtitle:[dict objectForKey:@"vicinity"]];
    
    [m_mapView showAnnotations:[NSArray arrayWithObjects:annotation, nil] animated:YES];
    [m_mapView selectAnnotation:[[self.m_mapView annotations] objectAtIndex:0] animated:YES];
 
    //
    // Places information
    //
    NSString *placesid = [dict objectForKey:@"place_id"];
    [self GetDetailInfo:placesid];
}


-(void)awakeFromNib {

    
}


-(IBAction)Ok:(id)sender{
    
    [self dismissController:self];
}

@end
