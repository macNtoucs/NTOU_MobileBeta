//
//  SetTimeViewController.m
//  MIT Mobile
//
//  Created by R MAC on 12/12/17.
//
//

#import "SetTimeViewController.h"
#import "UIKit+MITAdditions.h"
@interface SetTimeViewController ()

@end

@implementation SetTimeViewController
@synthesize delegate;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        HT_timeArr_morning =
        [[NSArray alloc]initWithObjects:@"6:00",@"6:30",@"7:00",@"7:30",@"8:00",@"8:30",@"9:00",@"9:30",@"10:00",@"10:30", nil];
        HT_timeArr_noon =
        [[NSArray alloc]initWithObjects:@"11:00",@"11:30",@"12:00",@"12:30",@"13:00",@"13:30",@"14:00",@"14:30", nil];
        HT_timeArr_evening =
        [[NSArray alloc]initWithObjects:@"15:00",@"15:30",@"16:00",@"16:30",@"17:00",@"17:30",@"18:00",@"18:30", nil];
        HT_timeArr_night =
        [[NSArray alloc]initWithObjects:@"19:00",@"19:30",@"20:00",@"20:30",@"21:00",@"21:30",@"22:00",@"22:30",@"23:00",@"23:30", nil];
        TimeCategory = [[NSArray alloc]initWithObjects:@"早上",@"中午",@"下午",@"晚上", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView applyStandardColors];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (section==0)return 10;
    else if (section ==1) return 8;
    else if (section ==2) return 8;
    else return 10;
}

- (UIView *) tableView: (UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *headerTitle;
    headerTitle = [TimeCategory objectAtIndex:section];
    UILabel *label = [[[UILabel alloc] init] autorelease];
    label.frame = CGRectMake(15, 3, 284, 23);
    label.textColor = [UIColor blackColor];
    label.font = [UIFont fontWithName:@"Helvetica" size:25];
    label.text = headerTitle;
    label.backgroundColor = [UIColor clearColor];
    
    // Create header view and add label as a subview
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    [view autorelease];
    [view addSubview:label];
    
    return view;
    
    
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return TimeCategory;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat rowHeight = 0;
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:14.0];
    CGSize constraintSize = CGSizeMake(270.0f, 2009.0f);
    NSString *cellText = nil;
    
    switch (indexPath.section) {
        default:
            cellText = @"A"; // just something to guarantee one line
            CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
            rowHeight = labelSize.height + 20.0f;
            break;
    }
    
    return rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    SecondaryGroupedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[SecondaryGroupedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = [HT_timeArr_morning objectAtIndex:indexPath.row];
            break;
        case 1:
            cell.textLabel.text = [HT_timeArr_noon objectAtIndex:indexPath.row];
            break;
        case 2:
            cell.textLabel.text = [HT_timeArr_evening objectAtIndex:indexPath.row];
            break;
        case 3:
            cell.textLabel.text = [HT_timeArr_night objectAtIndex:indexPath.row];
            break;
        default:
            break;
    }
    
    return cell;
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
   UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [delegate HTTime:self nowselectedTime:cell.textLabel.text];
}


@end
