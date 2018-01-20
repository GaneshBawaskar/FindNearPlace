//
//  MapViewCtrl.m
//  FindNearPlace
//
//  Created by Sabertooth on 10/01/18.
//  Copyright © 2018 Sabertoothasda. All rights reserved.
//

#import "MapViewCtrl.h"

@interface MapViewCtrl ()

@end

@implementation MapViewCtrl
@synthesize m_mapView;
@synthesize m_type;
@synthesize typeName;
@synthesize m_Address;
@synthesize infoArray;


- (void)viewDidLoad {
    
    [super viewDidLoad];
}


- (void)setType:(NSString*) type {
    if (!typeName) {
        typeName = [[NSMutableString alloc] init];
    }
    
    [typeName setString:type];
}


-(void)awakeFromNib {
    NSUInteger count =  [infoArray count];
    if (count > 0){
        [self PointAnnotation];
        NSString *Address = [[NSUserDefaults standardUserDefaults] objectForKey:@"AddressLocation"];
        [m_Address setStringValue:Address];
        [m_type setStringValue:typeName];
    }
}


-(void)PointAnnotation{
    
    NSMutableArray *Annotations = [[NSMutableArray alloc] init];
     for (NSDictionary *dict in infoArray) {
            
        NSString *loc = [dict objectForKey:@"location"];
        NSArray *latlng = [loc componentsSeparatedByString:@","];
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = [[latlng objectAtIndex:0] doubleValue];;
        coordinate.longitude = [[latlng objectAtIndex:1] doubleValue];;
        [annotation setCoordinate:coordinate];
        [annotation setTitle:[dict objectForKey:@"name"]];
        [annotation setSubtitle:[dict objectForKey:@"vicinity"]];
        [Annotations addObject:annotation];
    }
    
    [m_mapView showAnnotations:Annotations animated:YES];
    
}
@end
