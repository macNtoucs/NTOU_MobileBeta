//
//  StopsViewController.m
//  MIT Mobile
//
//  Created by mac_hero on 12/9/27.
//
//

#import "StopsViewController.h"

@interface StopsViewController ()

@end

@implementation StopsViewController
- (void) setDirection:(BOOL)dir{
    go=dir;
}
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"體育館";
            break;
        case 1:
            cell.textLabel.text = @"濱海校門";
            break;
        case 2:
            cell.textLabel.text = @"祥豐校門";
            break;
        case 3:
            cell.textLabel.text = @"中正校門";
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RouteDetailViewController * detail = [[RouteDetailViewController alloc]initWithStyle:UITableViewStyleGrouped];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    detail.title = cell.textLabel.text;
    if (go){ //往市區
        if (indexPath.row ==0){
            //體育館
            [detail addRoutesURL:@"http://ebus.klcba.gov.tw/KLBusWeb/pda/estimate_result.jsp?rid=103101&sid=120"
                             and: @"http://ebus.klcba.gov.tw/KLBusWeb/pda/estimate_result.jsp?rid=103102&sid=120"
                             and: @"http://ebus.klcba.gov.tw/KLBusWeb/pda/estimate_result.jsp?rid=104101&sid=120"
                             and: @"http://ebus.klcba.gov.tw/KLBusWeb/pda/estimate_result.jsp?rid=104102&sid=120"
             ];
        }
        else if (indexPath.row ==1){
        //濱海校門
            [detail addRoutesURL:@"http://ebus.klcba.gov.tw/KLBusWeb/pda/estimate_result.jsp?rid=103101&sid=121"
                             and: @"http://ebus.klcba.gov.tw/KLBusWeb/pda/estimate_result.jsp?rid=103102&sid=121"
                             and: @"http://ebus.klcba.gov.tw/KLBusWeb/pda/estimate_result.jsp?rid=104101&sid=121"
                             and: @"http://ebus.klcba.gov.tw/KLBusWeb/pda/estimate_result.jsp?rid=104102&sid=121"
             ];
        }
        else if (indexPath.row ==2){
        //祥豐校門
            [detail addRoutesURL:@"http://ebus.klcba.gov.tw/KLBusWeb/pda/estimate_result.jsp?rid=103101&sid=122"
                             and: @"http://ebus.klcba.gov.tw/KLBusWeb/pda/estimate_result.jsp?rid=103102&sid=122"
                             and: @"http://ebus.klcba.gov.tw/KLBusWeb/pda/estimate_result.jsp?rid=104101&sid=122"
                             and: @"http://ebus.klcba.gov.tw/KLBusWeb/pda/estimate_result.jsp?rid=104102&sid=122"
             ];
        }
        else{
        //中正校門
            [detail addRoutesURL:@"http://ebus.klcba.gov.tw/KLBusWeb/pda/estimate_result.jsp?rid=103101&sid=65"
                             and: nil
                             and: @"http://ebus.klcba.gov.tw/KLBusWeb/pda/estimate_result.jsp?rid=104101&sid=65"
                             and: nil
             ];
        }
    }
    else{//往八斗
        if (indexPath.row ==0){
             //體育館
            [detail addRoutesURL:@"http://ebus.klcba.gov.tw/KLBusWeb/pda/estimate_result.jsp?rid=103201&sid=165"
                             and: @"http://ebus.klcba.gov.tw/KLBusWeb/pda/estimate_result.jsp?rid=103202&sid=165"
                             and: @"http://ebus.klcba.gov.tw/KLBusWeb/pda/estimate_result.jsp?rid=104201&sid=165"
                             and: @"http://ebus.klcba.gov.tw/KLBusWeb/pda/estimate_result.jsp?rid=104202&sid=165"
             ];
        }
        else if (indexPath.row ==1){
            //濱海校門
            [detail addRoutesURL:@"http://ebus.klcba.gov.tw/KLBusWeb/pda/estimate_result.jsp?rid=103201&sid=164"
                             and: @"http://ebus.klcba.gov.tw/KLBusWeb/pda/estimate_result.jsp?rid=103202&sid=164"
                             and: @"http://ebus.klcba.gov.tw/KLBusWeb/pda/estimate_result.jsp?rid=104201&sid=164"
                             and: @"http://ebus.klcba.gov.tw/KLBusWeb/pda/estimate_result.jsp?rid=104202&sid=164"
             ];
        }
        else if (indexPath.row ==2){
            //祥豐校門
            [detail addRoutesURL:@"http://ebus.klcba.gov.tw/KLBusWeb/pda/estimate_result.jsp?rid=103201&sid=163"
                             and: @"http://ebus.klcba.gov.tw/KLBusWeb/pda/estimate_result.jsp?rid=103202&sid=163"
                             and: @"http://ebus.klcba.gov.tw/KLBusWeb/pda/estimate_result.jsp?rid=104201&sid=163"
                             and: @"http://ebus.klcba.gov.tw/KLBusWeb/pda/estimate_result.jsp?rid=104202&sid=163"
             ];
        }
        else{
            //中正校門
            [detail addRoutesURL:@"http://ebus.klcba.gov.tw/KLBusWeb/pda/estimate_result.jsp?rid=103201&sid=102"
                             and: nil
                             and: @"http://ebus.klcba.gov.tw/KLBusWeb/pda/estimate_result.jsp?rid=104201&sid=102"
                             and: nil
             ];
        }
    
    
    
    
    }
    [self.navigationController pushViewController:detail animated:YES];
}

@end
