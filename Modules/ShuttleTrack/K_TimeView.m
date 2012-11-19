//
//  K_TimeView.m
//  MIT Mobile
//
//  Created by mini server on 12/11/17.
//
//

#import "K_TimeView.h"
@interface K_TimeView (){
    int type;
}

@end

@implementation K_TimeView
@synthesize delegate;
@synthesize data;
@synthesize data2;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        data = [NSArray array];
        data2 = [NSArray array];
    }
    return self;
}

-(void)changeDirect
{
    [delegate changeDirect];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView applyStandardColors];
    if ([self.title rangeOfString: K_TimeViewtype1].location != NSNotFound)
        type=1;
    if ([self.title rangeOfString: K_TimeViewtype2].location != NSNotFound)
        type=2;
    else if ([self.title rangeOfString: K_TimeViewtype3].location != NSNotFound)
        type=3;
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self                                                                                                 action:@selector(changeDirect)];
    swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft|UISwipeGestureRecognizerDirectionRight;
    
    [self.tableView addGestureRecognizer:swipeGestureRecognizer];
    
    [swipeGestureRecognizer release];
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

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (MAX([data count], [data2 count])==1&&indexPath.row==1) {
        return 50;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1+MAX([data count], [data2 count]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d%d",indexPath.section,indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.textLabel.numberOfLines = 0;
    }
    // Configure the cell...
    if (indexPath.row==0) {
        cell.textLabel.text = self.title;
        if (type==2) {
            cell.textLabel.text = @"上客站                      下客站";
        }
        cell.textLabel.textColor = [UIColor blueColor];
    }
    else{
        if (type==2) {
            if (indexPath.row<=[data count]&&indexPath.row<=[data2 count]){
                NSString* space = [data objectAtIndex:indexPath.row-1];
                for (int i=0;i<(27-[[data objectAtIndex:indexPath.row-1] length]*(11.0/3));i++) {
                    space = [space stringByAppendingString:@" "];
                    
                }
                cell.textLabel.text = [space stringByAppendingString:[data2 objectAtIndex:indexPath.row-1]];
            }
            else if(indexPath.row>[data2 count])
                cell.textLabel.text = [data objectAtIndex:indexPath.row-1];
            else
                cell.textLabel.text =[[NSString stringWithFormat:@"                           "]stringByAppendingString:[data2 objectAtIndex:indexPath.row-1]];
        }
        else
            cell.textLabel.text = [data objectAtIndex:indexPath.row-1];
    }
    if (type==1||type==3) {
        cell.textLabel.textAlignment = UITextAlignmentCenter;
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
