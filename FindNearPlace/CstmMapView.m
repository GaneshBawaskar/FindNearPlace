//
//  CstmMapView.m
//  FindNearPlace
//
//  Created by Sabertooth on 11/01/18.
//  Copyright © 2018 Sabertoothasda. All rights reserved.
//

#import "CstmMapView.h"

@implementation CstmMapView

- (void)drawRect:(NSRect)dirtyRect {
    
    [[NSColor cyanColor] setFill];
    NSRectFill(dirtyRect);
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
