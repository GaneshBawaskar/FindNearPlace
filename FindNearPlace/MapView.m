//
//  MapView.m
//  MXEvents
//
//  Created by Sabertooth on 30/01/18.
//  Copyright © 2018 Ganesh Bawaskar. All rights reserved.
//

#import "MapView.h"

@implementation MapView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];

    // Drawing code here.
}

-(BOOL)becomeFirstResponder{

    return true;
}

- (NSRect)getFocusRect {
    NSRect focusRect = self.bounds;
    return focusRect;
}

- (void)drawFocusRingMask {
    NSRectFill([self getFocusRect]);
}
- (NSRect)focusRingMaskBounds {
    return [self getFocusRect];
}

-(BOOL)acceptsFirstResponder{

    return true;
}
@end
