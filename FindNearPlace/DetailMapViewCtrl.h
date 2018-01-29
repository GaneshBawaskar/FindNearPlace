//
//  DetailMapViewCtrl.h
//  FindNearPlace
//
//  Created by Sabertooth on 11/01/18.
//  Copyright © 2018 Sabertoothasda. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <MapKit/MapKit.h>
@interface DetailMapViewCtrl : NSViewController
{
    NSMutableArray *infoArray;
    MKMapView *m_mapView;
    NSUInteger Index;
    NSTextField *m_name;
    NSTextView *m_address;
    NSTextField *m_contact;
    NSTextField *m_postcode;;
    NSTextView *m_weekdays;
    NSLevelIndicator *indicator;
    
}
-(IBAction)Ok:(id)sender;
@property(retain) NSMutableArray *infoArray;
@property(retain) IBOutlet MKMapView *m_mapView;
@property(retain) IBOutlet NSTextField *m_name;
@property(retain) IBOutlet NSTextField *m_postcode;
@property(retain) IBOutlet NSTextView *m_address;
@property(retain) IBOutlet NSTextField *m_contact;
@property(retain) IBOutlet NSTextView *m_weekdays;
@property(retain) IBOutlet NSLevelIndicator *indicator;
@property(assign)  NSUInteger Index;
-(void)updateCtrl;
-(NSDictionary *)GetDetailInfo:(NSString*)placeid;
@end
