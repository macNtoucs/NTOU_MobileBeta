//
//  NTOU_ClassColorViewController.m
//  NTOUMobile
//
//  Created by mac_hero on 12/12/24.
//
//

#import "NTOU_ClassColorViewController.h"

@interface NTOU_ClassColorViewController (){
    NTOU_ClassColorTableController* colorTable;
}

@end

@implementation NTOU_ClassColorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    colorTable = [[NTOU_ClassColorTableController alloc]initWithStyle:UITableViewStylePlain];
    colorTable.delegate = self;
    colorTable.tableView.frame = CGRectMake(10, 10, 300, 305);
    colorTable.tableView.layer.cornerRadius = 12;
    colorTable.tableView.layer.masksToBounds = YES;
    [self.view addSubview:colorTable.tableView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchUpForSliderValue:(id)sender
{
    UIButton *theSlider = (UIButton *)sender;
    [self TableControllerChangeSlider:theSlider.backgroundColor];
    [self saveSliderValueToDataBase];
}

-(void)saveSliderValueToDataBase
{
    if (colorTable.selectCell) {
        [[ClassDataBase sharedData] UpdataColorDic:colorTable.selectCell.textLabel.text ColorDic:[UIColor colorWithRed:_RedSlider.value/255 green:_GreenSlider.value/255 blue:_BlueSlider.value/255 alpha:1]];
    }
    [colorTable.tableView reloadData];
}

- (IBAction)sliderValueChange:(id)sender{
    @autoreleasepool{
        UISlider *theSlider = (UISlider *)sender;
        if([theSlider isEqual:_RedSlider])
            _RedSlider_label.text = [NSString stringWithFormat:@"%.0f",theSlider.value];
        else if([theSlider isEqual:_GreenSlider])
            _GreenSlider_label.text = [NSString stringWithFormat:@"%.0f",theSlider.value];
        if([theSlider isEqual:_BlueSlider])
            _BlueSlider_label.text = [NSString stringWithFormat:@"%.0f",theSlider.value];
    }
    [self saveSliderValueToDataBase];
}

-(void)TableControllerChangeSlider:(UIColor *)color
{
    @autoreleasepool{
        const float* colors = CGColorGetComponents(color.CGColor );
        CGFloat R, G, B;
        R = colors[0]*255;
        G = colors[1]*255;
        B = colors[2]*255;
        _RedSlider.value = R;
        _GreenSlider.value = G;
        _BlueSlider.value = B;
        _RedSlider_label.text = [NSString stringWithFormat:@"%.0f",_RedSlider.value];
        _GreenSlider_label.text = [NSString stringWithFormat:@"%.0f",_GreenSlider.value];
        _BlueSlider_label.text = [NSString stringWithFormat:@"%.0f",_BlueSlider.value];
    }
}

- (void)dealloc {
    [_RedSlider release];
    [_GreenSlider release];
    [_BlueSlider release];
    [_RedSlider_label release];
    [_GreenSlider_label release];
    [_BlueSlider_label release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setRedSlider:nil];
    [self setGreenSlider:nil];
    [self setBlueSlider:nil];
    [self setRedSlider_label:nil];
    [self setGreenSlider_label:nil];
    [self setBlueSlider_label:nil];
    [super viewDidUnload];
}
@end
