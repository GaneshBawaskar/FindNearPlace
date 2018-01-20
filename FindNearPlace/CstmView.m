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
    // add a background image
    NSColor *bckcolor = [NSColor colorWithPatternImage:[NSImage imageNamed:@"images.jpg"]];//[NSColor orangeColor];//
    [bckcolor setFill];
    NSRectFill(dirtyRect);
    [super drawRect:dirtyRect];
}

@end
