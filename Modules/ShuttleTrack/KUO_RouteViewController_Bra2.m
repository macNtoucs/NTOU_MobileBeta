//
//  KUO_RouteViewController_Bra2.m
//  MIT Mobile
//
//  Created by mini server on 12/11/17.
//
//

#import "KUO_RouteViewController_Bra2.h"
#import "UIKit+MITAdditions.h"
@interface KUO_RouteViewController_Bra2 ()

@end

@implementation KUO_RouteViewController_Bra2

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        data = [KUO_Data_Bra2 sharedData];
        inbound = [[data fetchInboundJourney] mutableCopy] ;
        outbound = [[data fetchOutboundJourney] mutableCopy] ;
        display = inbound;
        // Custom initialization
    }
    return self;
}

-(void)changeDirectType
{
    static BOOL direct = FALSE;
    if (direct) {
        self.title = @"去程";
        display = inbound;
        direct = FALSE;
    } else {
        self.title = @"回程";
        display = outbound;
        direct = TRUE;
    }
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView applyStandardColors];
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self                                                                                                 action:@selector(changeDirectType)];
    swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft|UISwipeGestureRecognizerDirectionRight;

    [self.tableView addGestureRecognizer:swipeGestureRecognizer];

    [swipeGestureRecognizer release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @" ";
}
- (UIView *) tableView: (UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (display==inbound) {
        return [UITableView groupedSectionHeaderWithTitle:[[[display allKeys]objectAtIndex:section] stringByAppendingString:@"  → "]] ;
    }
    else
        return [UITableView groupedSectionHeaderWithTitle:[[NSString stringWithFormat:@"  → "]  stringByAppendingString:[[display allKeys]objectAtIndex:section]]] ;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [display count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[display objectForKey:[[display allKeys] objectAtIndex:section]] count]/StationInformationCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d%d",indexPath.section,indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text= [[display objectForKey:[[display allKeys] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row*StationInformationCount];
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
    KUO_TimeViewController* tabc = [[KUO_TimeViewController alloc] init:[display objectForKey:[[display allKeys] objectAtIndex:indexPath.section]]];
    if (display==inbound) {
            tabc.title = [[[[display allKeys]objectAtIndex:indexPath.section] stringByAppendingString:@"  → "] stringByAppendingString:cell.textLabel.text];
    } else {
            tabc.title = [[cell.textLabel.text stringByAppendingString:@"  → "] stringByAppendingString:[[display allKeys]objectAtIndex:indexPath.section]];
    }
    [self.navigationController pushViewController:tabc animated:YES];
    [tabc release];
}

@end
