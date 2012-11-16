//
//  OtherTrafficTrapViewController.m
//  MIT Mobile
//
//  Created by mini server on 12/11/16.
//
//

#import "OtherTrafficTrapViewController.h"

@interface OtherTrafficTrapViewController ()

@end

@implementation OtherTrafficTrapViewController

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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
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
    switch (indexPath.row)  {
        case 0:
            cell.textLabel.text = @"基隆火車站";
            break;
        case 1:
            cell.textLabel.text = @"台鐵";
            break;
        case 2:
            cell.textLabel.text = @"國光客運";
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
    if (indexPath.row==0) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        StopsViewController * stops = [[StopsViewController alloc]initWithStyle:UITableViewStyleGrouped];
        stops.title = cell.textLabel.text;
        [stops setDirection:true];
        [self.navigationController pushViewController:stops animated:YES];
        [stops release];
    }
    else if (indexPath.row==1)
    {
        SetStationViewController *setStationView = [[SetStationViewController alloc]init];
        [self.navigationController pushViewController:setStationView animated:YES];
        [setStationView release];
    }
    else if (indexPath.row==2)
    {
        UITabBarController* tab_c = [[UITabBarController alloc] init];
        K_RouteViewController* kuo_kuang1 = [[K_RouteViewController alloc] initWithStyle:UITableViewStyleGrouped];
        kuo_kuang1.title = @"北部";
        kuo_kuang1.region=1;
        K_RouteViewController* kuo_kuang2 = [[K_RouteViewController alloc] initWithStyle:UITableViewStyleGrouped];
        kuo_kuang2.title = @"中部";
        kuo_kuang2.region=2;
        K_RouteViewController* kuo_kuang3 = [[K_RouteViewController alloc] initWithStyle:UITableViewStyleGrouped];
        kuo_kuang3.title = @"南部";
        kuo_kuang3.region=3;
        K_RouteViewController* kuo_kuang4 = [[K_RouteViewController alloc] initWithStyle:UITableViewStyleGrouped];
        kuo_kuang4.title = @"東部";
        kuo_kuang4.region=4;
        tab_c.viewControllers = [NSArray arrayWithObjects:kuo_kuang1,kuo_kuang2,kuo_kuang3,kuo_kuang4, nil];
        [kuo_kuang1 release];
        [kuo_kuang2 release];
        [kuo_kuang3 release];
        [kuo_kuang4 release];
        [self.navigationController pushViewController:tab_c animated:YES];
        [tab_c release];
    }
}

@end
