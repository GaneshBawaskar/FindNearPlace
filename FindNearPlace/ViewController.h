//
//  ViewController.h
//  FindNearPlace
//
//  Created by Sabertooth on 07/01/18.
//  Copyright © 2018 Sabertoothasda. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CoreWLAN/CoreWLAN.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import "DetailMapViewCtrl.h"
#import "LocationInfoCtrl.h"
@interface ViewController : NSViewController <NSTableViewDelegate, NSTableViewDataSource>
{
    
    
    NSButton *m_searchNearBy;
    NSTextField *m_nearByPlace;
    NSComboBox *m_comBox;
    NSTableView *m_tableView;
    NSMutableArray *m_PlacesData;
    NSMutableString *m_type;
    NSUInteger m_index;
    NSMutableDictionary *m_mapDictionary;
}
@property(retain) IBOutlet NSComboBox *m_comBox;
@property(assign) NSUInteger m_index;
@property(retain) NSButton *m_searchNearBy;
@property(retain) NSTextField *m_nearByPlace;
@property(retain) NSMutableArray *m_PlacesData;
@property(retain) NSMutableString *m_type;
@property(retain) IBOutlet NSTableView *m_tableView;
-(IBAction)SearchNearBy:(id)sender;
-(IBAction)ResetLocation:(id)sender;
@end

