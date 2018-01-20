//
//  LocationInfoCtrl.h
//  FindNearPlace
//
//  Created by Sabertooth on 11/01/18.
//  Copyright © 2018 Sabertoothasda. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LocationInfoCtrl : NSViewController
{
    NSTextField *OLocation;
    NSTextField *NLocation;
    NSMutableString *m_newLocation;
    NSMutableString *m_oldLocation;
}
@property(retain)  NSMutableString *m_newLocation;
@property(retain)  NSMutableString *m_oldLocation;
@property(retain)  IBOutlet NSTextField *OLocation;
@property(retain)  IBOutlet NSTextField *NLocation;
-(void)setODLocation:(NSString *)loc;
-(void)setNWLocation:(NSString *)loc;
-(void)ConvertAddressToCoordinateAndSave:(NSString *)Address;
-(IBAction)Ok:(id)sender;
@end
