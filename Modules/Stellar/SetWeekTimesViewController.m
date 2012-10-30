//
//  SetWeekTimesViewController.m
//  MIT Mobile
//
//  Created by R MAC on 12/10/29.
//
//

#import "SetWeekTimesViewController.h"

@interface SetWeekTimesViewController ()

@end

@implementation SetWeekTimesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"星期一";
           // cell.accessoryType =UITableViewCellAccessoryCheckmark;
           cell.accessoryType =  UITableViewCellAccessoryNone;
            break;
        case 1:
            cell.textLabel.text = @"星期二";
            cell.accessoryType =  UITableViewCellAccessoryNone;
            break;
        case 2:
            cell.textLabel.text = @"星期三";
            cell.accessoryType =  UITableViewCellAccessoryNone;
            break;
        case 3:
            cell.textLabel.text = @"星期四";
            cell.accessoryType =  UITableViewCellAccessoryNone;
            break;
        case 4:
            cell.textLabel.text = @"星期五";
            cell.accessoryType =  UITableViewCellAccessoryNone;
            break;
        case 5:
            cell.textLabel.text = @"星期六";
            cell.accessoryType =  UITableViewCellAccessoryNone;
            break;
        case 6:
            cell.textLabel.text = @"星期日";
            cell.accessoryType =  UITableViewCellAccessoryNone;
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
    switch (indexPath.row) {
        case 0:
            if (cell.accessoryType == UITableViewCellAccessoryNone)
            cell.accessoryType =UITableViewCellAccessoryCheckmark;
            else
                cell.accessoryType = UITableViewCellAccessoryNone;
            break;
        case 1:
            if (cell.accessoryType == UITableViewCellAccessoryNone)
                cell.accessoryType =UITableViewCellAccessoryCheckmark;
            else
                cell.accessoryType = UITableViewCellAccessoryNone;
            break;

        case 2:
            if (cell.accessoryType == UITableViewCellAccessoryNone)
                cell.accessoryType =UITableViewCellAccessoryCheckmark;
            else
                cell.accessoryType = UITableViewCellAccessoryNone;
            break;

        case 3:
            if (cell.accessoryType == UITableViewCellAccessoryNone)
                cell.accessoryType =UITableViewCellAccessoryCheckmark;
            else
                cell.accessoryType = UITableViewCellAccessoryNone;
            break;

        case 4:
            if (cell.accessoryType == UITableViewCellAccessoryNone)
                cell.accessoryType =UITableViewCellAccessoryCheckmark;
            else
                cell.accessoryType = UITableViewCellAccessoryNone;
            break;

        case 5:
            if (cell.accessoryType == UITableViewCellAccessoryNone)
                cell.accessoryType =UITableViewCellAccessoryCheckmark;
            else
                cell.accessoryType = UITableViewCellAccessoryNone;
            break;

        case 6:
            if (cell.accessoryType == UITableViewCellAccessoryNone)
                cell.accessoryType =UITableViewCellAccessoryCheckmark;
            else
                cell.accessoryType = UITableViewCellAccessoryNone;
            break;

        default:
            break;
    }
}

@end
