//
//  NTOUGuide3ViewController.m
//  NTOUMobile
//
//  Created by cclin on 1/31/13.
//
//

#import "NTOUGuide3ViewController.h"

@interface NTOUGuide3ViewController ()

@end

@implementation NTOUGuide3ViewController

- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Routes";
    }
    return self;
}

-(void) SetRoute:(int)RouteNumber
{
    self->WhatRoute = RouteNumber;
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
    return @"1";
}


- (UIView *) tableView: (UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	NSString *headerTitle;
    switch (self->WhatRoute) {

        case 0:
            headerTitle = @"教職員宿舍";
            break;

        case 1:
            headerTitle = @"綜合館及大樓";
            break;
        default:
            break;
    }
	return [UITableView groupedSectionHeaderWithTitle:headerTitle];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (self->WhatRoute) {
        
        case 0:
            return 5;
            break;
        
        case 1:
            return 13;
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
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch (self->WhatRoute) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"宿舍";
                    cell.textLabel.textColor = [UIColor blueColor];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    break;
                case 1:
                    cell.textLabel.text = @"首長宿舍";
                    break;
                case 2:
                    cell.textLabel.text = @"祥豐單身宿舍";
                    break;
                case 3:
                    cell.textLabel.text = @"職務宿舍(二期)";
                    break;
                case 4:
                    cell.textLabel.text = @"職務宿舍(三期)";
                    break;
                
                default:
                    break;
            }
            break;
        
        case 1:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"綜合館及大樓";
                    cell.textLabel.textColor = [UIColor blueColor];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    break;
                case 1:
                    cell.textLabel.text = @"綜合一館";
                    break;
                case 2:
                    cell.textLabel.text = @"綜合二館";
                    break;
                case 3:
                    cell.textLabel.text = @"綜合三館";
                    break;
                case 4:
                    cell.textLabel.text = @"行政資訊大樓";
                    break;
                case 5:
                    cell.textLabel.text = @"生科院辦公室";
                    break;
                case 6:
                    cell.textLabel.text = @"延平技術大樓";
                    break;
            
                case 7:
                    cell.textLabel.text = @"海空大樓";
                    break;
                case 8:
                    cell.textLabel.text = @"人文大樓";
                    break;
                case 9:
                    cell.textLabel.text = @"沛華大樓";
                    break;
                case 10:
                    cell.textLabel.text = @"海事大樓甲棟";
                    break;
                case 11:
                    cell.textLabel.text = @"海事大樓乙棟";
                    break;
                case 12:
                    cell.textLabel.text = @"海事大樓丙棟";
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
    // Configure the cell...
    
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

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath.row) {
        return nil;
    }
    return indexPath;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NTOUGuideSetViewController  * stopsLocation = [[NTOUGuideSetViewController  alloc]init];
    CLLocationCoordinate2D location ;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    switch (self->WhatRoute) {
        case 0:
            switch (indexPath.row) {
                case 1:
                    location.longitude = 121.77415;
                    location.latitude = 25.150063;
                    [stopsLocation setlocation:location latitudeDelta:0.002 longitudeDelta:0.002];
                    break;
                case 2:
                    location.longitude = 121.766875;
                    location.latitude = 25.144847;
                    [stopsLocation setlocation:location latitudeDelta:0.002 longitudeDelta:0.002];
                    break;
                case 3:
                    location.longitude = 121.783194;
                    location.latitude = 25.144099;
                    [stopsLocation setlocation:location latitudeDelta:0.002 longitudeDelta:0.002];
                    break;
                case 4:
                    location.longitude = 121.783313;
                    location.latitude = 25.144163;
                    [stopsLocation setlocation:location latitudeDelta:0.002 longitudeDelta:0.002];
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 1:
                    location.longitude = 121.772891;
                    location.latitude = 25.149666;
                    [stopsLocation setlocation:location latitudeDelta:0.002 longitudeDelta:0.002];
                    break;
                case 2:
                    location.longitude = 121.774883;
                    location.latitude = 25.150599;
                    [stopsLocation setlocation:location latitudeDelta:0.002 longitudeDelta:0.002];
                    break;
                case 3:
                    location.longitude = 121.775366;
                    location.latitude = 25.149386;
                    [stopsLocation setlocation:location latitudeDelta:0.002 longitudeDelta:0.002];
                    break;
                case 4:
                    location.longitude = 121.776158;
                    location.latitude = 25.150255;
                    [stopsLocation setlocation:location latitudeDelta:0.002 longitudeDelta:0.002];
                    break;
                case 5:
                    location.longitude = 121.773533;
                    location.latitude = 25.150141;
                    [stopsLocation setlocation:location latitudeDelta:0.002 longitudeDelta:0.002];
                    break;
                case 6:
                    location.longitude = 121.777794;
                    location.latitude = 25.149213;
                    [stopsLocation setlocation:location latitudeDelta:0.002 longitudeDelta:0.002];
                    break;
                case 7:
                    location.longitude = 121.778852;
                    location.latitude = 25.149469;
                    [stopsLocation setlocation:location latitudeDelta:0.002 longitudeDelta:0.002];
                    break;
                case 8:
                    location.longitude = 121.775086;
                    location.latitude = 25.149802;
                    [stopsLocation setlocation:location latitudeDelta:0.002 longitudeDelta:0.002];
                    break;
                case 9:
                    location.longitude = 121.772611;
                    location.latitude = 25.150058;
                    [stopsLocation setlocation:location latitudeDelta:0.002 longitudeDelta:0.002];
                    break;
                case 10:
                    location.longitude = 121.774491;
                    location.latitude = 25.149827;
                    [stopsLocation setlocation:location latitudeDelta:0.002 longitudeDelta:0.002];
                    break;
                case 11:
                    location.longitude = 121.774599;
                    location.latitude = 25.149405;
                    [stopsLocation setlocation:location latitudeDelta:0.002 longitudeDelta:0.002];
                    break;
                case 12:
                    location.longitude = 121.774108;
                    location.latitude = 25.149327;
                    [stopsLocation setlocation:location latitudeDelta:0.002 longitudeDelta:0.002];
                    break;
                default:
                    break;
            }
            break;
                    
        default:
            break;
    }
    stopsLocation.view.hidden = NO;
    stopsLocation.title = [cell.textLabel.text retain];
    [self.navigationController pushViewController:stopsLocation animated:YES];
    [stopsLocation release];
    
}

@end
