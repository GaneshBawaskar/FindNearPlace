//
//  MapViewCtrl.h
//  FindNearPlace
//
//  Created by Sabertooth on 10/01/18.
//  Copyright © 2018 Sabertoothasda. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <MapKit/MapKit.h>
@interface MapViewCtrl : NSViewController
{
    NSTextField *m_Address;
    NSTextField *m_type;
    NSMutableString *typeName;
    NSMutableArray *infoArray;
    MKMapView *m_mapView;
}
-(void)setType:(NSString *)type;
@property(retain)  IBOutlet  NSTextField *m_Address;
@property(retain)  NSMutableString *typeName;
@property(retain) IBOutlet  NSTextField *m_type;
@property(retain) IBOutlet MKMapView *m_mapView;
@property(retain) NSMutableArray *infoArray;
@end
