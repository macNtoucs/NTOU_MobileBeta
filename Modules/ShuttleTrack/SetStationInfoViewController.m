//
//  SetStationInfoViewController.m
//  MIT Mobile
//
//  Created by MacAir on 12/11/4.
//
//

#import "SetStationInfoViewController.h"

@interface SetStationInfoViewController ()

@end

@implementation SetStationInfoViewController
@synthesize stationName;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        stationName = [[NSMutableArray alloc]initWithObjects:@"台北",@"板橋", nil];
        dir = false;
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

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"1";
}


- (UIView *) tableView: (UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	NSString *headerTitle;
    switch (section) {
        case 0:
            headerTitle = @"方向";
            break;
        case 1:
           if (!dir) //北上
            headerTitle = @"乘車處";
            else //南下
            headerTitle = @"下車處";
        default:
            headerTitle = @"";
    }
	return [UITableView groupedSectionHeaderWithTitle:headerTitle];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 2;
            break;
        case 2:
            return 1;
        default:
            return [stationName count];
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
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0 ){
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"北上";
                break;
                
            case 1:
                cell.textLabel.text = @"南下";
                break;
        }
        if (indexPath.section==dirCurrentSelectSection && indexPath.row == dirCurrentSelectRow)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
    }
    else if (indexPath.section ==1 ){ 
        cell.textLabel.text = [stationName objectAtIndex:indexPath.row];
        if (indexPath.section==currentSelectSection && indexPath.row == currentSelectRow)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
    cell.textLabel.text = @"確認";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
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
    UITableViewCell * cell_selected = [tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.section == 0 ){        dirCurrentSelectRow=indexPath.row;
        dirCurrentSelectSection=indexPath.section;
        if (indexPath.row == 0) dir=false;
        else dir = true;
        [tableView reloadData];
    }
    else if (indexPath.section==1){
        currentSelectRow=indexPath.row;
        currentSelectSection=indexPath.section;
        [tableView reloadData];
    }
    else {
        StaionInfoTableViewController * stationInfo = [[StaionInfoTableViewController alloc]init];
        [stationInfo recieveURL: [NSURL URLWithString:@"http://twtraffic.tra.gov.tw/twrail/SearchResult.aspx?searchtype=0&searchdate=2012/11/05&fromstation=1001&tostation=1008&trainclass=2&fromtime=0000&totime=2359"]];
        [self.navigationController pushViewController:stationInfo animated:YES];
    }
    
}

@end
