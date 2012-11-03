//
//  ClassLabelBasis.h
//  MIT Mobile
//
//  Created by mini server on 12/10/31.
//
//

#import <UIKit/UIKit.h>

@interface ClassLabelBasis : UILabel
{
    UIColor* tempBackground;
}

@property(nonatomic,retain) UIColor* tempBackground;
@property BOOL changeColor;

@end
