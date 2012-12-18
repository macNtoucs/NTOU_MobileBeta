//
//  Rotation.m
//  NTOUMobile
//
//  Created by mac_hero on 12/12/18.
//
//

#import "Rotation.h"

@implementation Rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

@end
