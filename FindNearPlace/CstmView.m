//
//  CstmView.m
//  FirstApp
//
//  Created by Sabertooth on 04/01/18.
//  Copyright © 2018 Sabertoothasda. All rights reserved.
//

#import "CstmView.h"

@implementation CstmView


- (void)drawRect:(NSRect)dirtyRect
{
    [[NSColor whiteColor] setFill];
    NSRectFill(dirtyRect);
    [super drawRect:dirtyRect];
}

@end
