//
//  EditScheduleViewController.m
//  MIT Mobile
//
//  Created by mac_hero on 12/10/27.
//
//

#import "EditScheduleViewController.h"

@interface EditScheduleViewController (){
    SetWeekTimesViewController * setweek;
}

@end

@implementation EditScheduleViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.view.backgroundColor = [UIColor clearColor];
        [ClassDataBase sharedData].EditScheduleDelegate = self;
    }
    return self;
}

-(void) addNavRightButton {
    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(finishSetting)];
    [self.navigationItem setRightBarButtonItem:right animated:YES];
}
- (void)viewDidLoad
{
      [self addNavRightButton]; 
    [super viewDidLoad];
    [self.tableView applyStandardColors];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[ClassDataBase sharedData].ScheduleViewDelegate ChangeDisplayView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat rowHeight = 0;
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:14.0];
    CGSize constraintSize = CGSizeMake(270.0f, 2009.0f);
    NSString *cellText = nil;
    
    cellText = @"A"; // just something to guarantee one line
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    rowHeight = labelSize.height + 20.0f;
    
    return rowHeight;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 3;
}
-(void) finishSetting {
[self dismissModalViewControllerAnimated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     
    static NSString *CellIdentifier = @"Cell";
    SecondaryGroupedTableViewCell *cell  = [[[SecondaryGroupedTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    UISwitch *switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
    switchview.on = [[ClassDataBase sharedData] FetchshowClassTimes];
    UISlider *sliderView = [[UISlider alloc]initWithFrame:CGRectMake(174,12,120,23)];
    sliderView.maximumValue = 14;
    sliderView.minimumValue = 8;
    sliderView.value = [[ClassDataBase sharedData] FetchClassSessionTimes];
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"一周上課天數";
            cell.detailTextLabel.text = @"";
            cell.detailTextLabel.textColor = [UIColor blueColor];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 1:
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"節次";
             cell.accessoryView = sliderView;
            [(UISlider *)cell.accessoryView addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0f",sliderView.value];
            cell.detailTextLabel.textColor = [UIColor blueColor];
            cell.detailTextLabel.backgroundColor = [UIColor clearColor];
            break;
        case 2:
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
              cell.accessoryView = switchview;
            [(UISwitch *)cell.accessoryView addTarget:self action:@selector(switchValueChange:) forControlEvents:UIControlEventTouchUpInside];
            cell.textLabel.text = @"顯示課堂時間";
            break;
    }
    
    return cell;
}

-(void)switchValueChange:(id)sender{
    UISwitch *theSwitch = (UISwitch *)sender;
    willbeset_showClassTimes = theSwitch.on;
    [[ClassDataBase sharedData] SetShowClassTimes:willbeset_showClassTimes];
}
- (void)sliderValueChange:(id)sender{
    UISlider *theSlider = (UISlider *)sender;
    SecondaryGroupedTableViewCell *cell = (SecondaryGroupedTableViewCell *)theSlider.superview;
    willbeset_ClassSessionTimes = theSlider.value;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0f",theSlider.value];
    [[ClassDataBase sharedData] SetClassSessionTimes:[cell.detailTextLabel.text intValue]];
}

-(void)ReloadSetWeek
{
    [setweek.tableView reloadData];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0){
        setweek = [SetWeekTimesViewController new];
        [self.navigationController pushViewController:setweek animated:YES];
        setweek.title = @"設定一周天數";
    }
        
}

@end
