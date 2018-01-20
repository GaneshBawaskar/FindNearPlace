//
//  CSTViewCell.m
//  FindNearPlace
//
//  Created by Sabertooth on 10/01/18.
//  Copyright © 2018 Sabertoothasda. All rights reserved.
//

#import "CSTViewCell.h"

@implementation CSTViewCell

- (void)drawRect:(NSRect)dirtyRect {
    
    NSRect rect = [self bounds];
    NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:rect xRadius:6 yRadius:6];
    [path addClip];
    NSColor *bckcolor = [NSColor gridColor];
    [bckcolor setFill];
    NSRectFill(dirtyRect);
    [super drawRect:dirtyRect];
    // Drawing code here.
}

@end
