//
//  NTOUGuideViewController.m
//  NTOUMobile
//
//  Created by cclin on 1/24/13.
//
//

#import "NTOUGuideViewController.h"
#import "UIKit+MITAdditions.h"

@interface NTOUGuideViewController ()

@end

@implementation NTOUGuideViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"校園導覽";
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


//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source


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
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @" ";
    
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 32;
}



- (UIView *) tableView: (UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	NSString *headerTitle;
    switch (section) {
        case 0:
            headerTitle = @"學生專區";
            break;
        case 1:
            headerTitle = @"教職員/綜合大樓";
            break;
        case 2:
            headerTitle = @"其他";
            break;
        default:
            break;
    }
    UIFont *font = [UIFont boldSystemFontOfSize:STANDARD_CONTENT_FONT_SIZE];
	CGSize size = [headerTitle sizeWithFont:font];
	CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(19.0, 3.0, appFrame.size.width - 19.0, size.height)];
	
	label.text = headerTitle;
	label.textColor = GROUPED_SECTION_FONT_COLOR;
	label.font = font;
	label.backgroundColor = [UIColor clearColor];
	
	UIView *labelContainer = [[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, appFrame.size.width, GROUPED_SECTION_HEADER_HEIGHT)] autorelease];
	labelContainer.backgroundColor = [UIColor clearColor];
	
	[labelContainer addSubview:label];
	[label release];
	return labelContainer;
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
    SecondaryGroupedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[SecondaryGroupedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch (indexPath.section)  {
        case 0:
            switch (indexPath.row) {
                
                case 3:
                    cell.textLabel.text = @"學生宿舍";
                    break;
                case 0:
                    cell.textLabel.text = @"各科系館";
                    break;
                case 2:
                    cell.textLabel.text = @"研究/實驗中心";
                    break;
                case 1:
                    cell.textLabel.text = @"學生活動領域";
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"教職員宿舍";
                    break;
                case 1:
                    cell.textLabel.text = @"綜合館及大樓";
                    break;
                default:
                    break;
            }
            break;
        case 2:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text= @"其他";
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
       NTOUGuide2ViewController * Guide2 = [[NTOUGuide2ViewController alloc]initWithStyle:UITableViewStyleGrouped];
        [Guide2 SetRoute:indexPath.row];
        [self.navigationController pushViewController:Guide2 animated:YES];
        [Guide2 release];
    }
    else if (indexPath.section == 1)
    {
        NTOUGuide3ViewController * Guide3 = [[NTOUGuide3ViewController alloc]initWithStyle:UITableViewStyleGrouped];
        [Guide3 SetRoute:indexPath.row];
        [self.navigationController pushViewController:Guide3 animated:YES];
        [Guide3 release];
    }
    else {
        
        NTOUGuide4ViewController * Guide4 = [[NTOUGuide4ViewController alloc]initWithStyle:UITableViewStyleGrouped];
        [Guide4 SetRoute:indexPath.row];
        [self.navigationController pushViewController:Guide4 animated:YES];
        [Guide4 release];
    }
}

@end
