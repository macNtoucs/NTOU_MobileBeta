//
//  NTOUTableViewControllerLayer1.m
//  MIT Mobile
//
//  Created by mac_hero on 12/9/26.
//
//

#import "NTOUTableViewControllerLayer1.h"

#import "UIKit+MITAdditions.h"

@interface NTOUTableViewControllerLayer1 ()

@end

@implementation NTOUTableViewControllerLayer1

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"Shuttles";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView applyStandardColors];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display 	 an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==2) {
        return nil;
    }
    return @" ";
}

- (UIView *) tableView: (UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	NSString *headerTitle;
    switch (section) {
        case 0:
            headerTitle = @"學生專車";
            break;
        case 1:
            headerTitle = @"市區公車";
            break;
        case 2:
            return nil;
            break;
        default:
            break;
    }
	return [UITableView groupedSectionHeaderWithTitle:headerTitle];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 4;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d%d",indexPath.section,indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch (indexPath.section)  {
        case 0:
            switch (indexPath.row) {
                case 3:
                    cell.textLabel.text = @"忠孝復興站  → 海洋大學";
                    break;
                case 0:
                    cell.textLabel.text = @"海洋大學  → 忠孝復興站";
                    break;
                case 2:
                    cell.textLabel.text = @"捷運劍潭站  → 海洋大學";
                    break;
                case 1:
                    cell.textLabel.text = @"海洋大學  → 捷運劍潭站";
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"八斗子  → 海大  → 火車站";
                    break;
                case 1:
                    cell.textLabel.text = @"火車站  → 海大  → 八斗子";
                    break;
                default:
                    break;
            }
            break;
        case 2:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text= @"基隆火車站";
                    break;
            }
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

    if (indexPath.section==0) {
        NTOUTableViewControllerLayer2 * Layer2 = [[NTOUTableViewControllerLayer2 alloc]initWithStyle:UITableViewStyleGrouped];
        [Layer2 SetRoute:indexPath.row];
        [self.navigationController pushViewController:Layer2 animated:YES];
        [Layer2 release];
    }
    else if (indexPath.row == 1)
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
       
        StopsViewController * stops = [[StopsViewController alloc]initWithStyle:UITableViewStyleGrouped];
        stops.title = cell.textLabel.text;
        if (indexPath.row==0) {
            [stops setDirection:true];
            [self.navigationController pushViewController:stops animated:YES];
        } else {
            [stops setDirection:false];
             [self.navigationController pushViewController:stops animated:YES];
        }
       
        [stops release];
    }
    else {

        OtherTrafficTrapViewController *other = [[OtherTrafficTrapViewController alloc ]initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:other animated:YES];
        [other release];
    }
}

@end
