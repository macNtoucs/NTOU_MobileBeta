//
//  K_RouteViewController.m
//  MIT Mobile
//
//  Created by mini server on 12/11/16.
//
//

#import "K_RouteViewController.h"

@interface K_RouteViewController ()

@end

@implementation K_RouteViewController
@synthesize region;
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
    titleArray = [[NSMutableArray alloc] init];
    data = [Kuo_Data sharedData];
    [titleArray addObject:UITableViewIndexSearch];
    for (int i = 0;i< [self numberOfSectionsInTableView:self.tableView];i++  ) {
        NSString* str =[data.Stop objectAtIndex:[self sectionChangeIndex:i]];
        NSString* str2 = [[[[str componentsSeparatedByString:@"國際"] componentsJoinedByString:@""]componentsSeparatedByString:@"台北"] componentsJoinedByString:@""];
       [titleArray addObject:str2];
    }
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

-(void)resetTableView{

}
#pragma mark NO.6
/*搜索删除不符合的值。先准备一个空的可变key容器用于储存不符合的key，接下来创建两个可变数组容器，一个用于存储key所对应的值(数组)，另一个为空，用于存储需要移除的值。
 */
-(void)SearchData:(NSString *)searchtext{
    
    //准备储存要删掉的key
    NSMutableArray *removekey=[[NSMutableArray alloc] init];
    
    for (NSString * key in titleArray) {
        
        NSMutableArray *localarr=data.Route;
        
        //准备存储要删掉的key里的数组
        NSMutableArray *removearr=[[NSMutableArray alloc] init];
        
        for (NSString * tmpvalue in localarr) {
            if ([tmpvalue rangeOfString:searchtext options:NSCaseInsensitiveSearch].location==NSNotFound ) {
                [removearr addObject:tmpvalue];
            }
        }
        
        if ([localarr count] == [removearr count]) {
            [removekey addObject:key];
        }
        //移除不符合的值
        [localarr removeObjectsInArray:removearr];
        
    }
    //移除不符合的值(key所对应的值(整个数组))
    [titleArray removeObjectsInArray:removekey];
    //重新加载(刷新)。
    [self.tableView reloadData];
}

#pragma mark-
#pragma mark NO.4 TableView Delegate Method
//点击uitableview触发此方法。
-(NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [MySearchBar resignFirstResponder];
    MySearchBar.text=@"";
    issearching=NO;
    [self.tableView reloadData];
    return indexPath;
}
#pragma mark-
#pragma mark NO.5 Search Bar Delegate Method
//点击search按钮
//从UISearchBar输入框中提取内容调用SearchData方法进行查找
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSString *mysearch=[searchBar text];
    [self SearchData:mysearch];
}
//自动搜索
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if ([searchText length]==0) {
        [self resetTableView];
        [self.tableView reloadData];
        return;
    }
    [self SearchData:searchText];
}
//点击Cancle按钮
//清除记录退回屏幕键盘，返回初始状态。显示索引。
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    issearching=NO;
    MySearchBar.text=@"";
    //当重新输入时，重新加载，此前就是落下了这一步，让我很头疼。
    [self resetTableView];
    [self.tableView reloadData];
    [searchBar resignFirstResponder];
    
    
}
//点击输入框时被触发
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    issearching=YES;
    [self.tableView reloadData];
}
//点击索引会调用此方法。点击扩大镜UITableViewIndexSearch让searchbar出现(因为扩大镜在执行resettableview方法时把其下标设为0，加入key的，所以执行if语句会进入)。
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    NSString *key=[titleArray objectAtIndex:index];
    if (key==UITableViewIndexSearch) {
        [self.tableView setContentOffset:CGPointZero animated:NO];
        return NSNotFound;
    }
    return index;
}


#pragma mark - Table view data source

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (issearching) {
        return nil;
        
    }
    return titleArray;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @" ";
}

-(NSInteger)sectionChangeIndex:(NSInteger)section{
    int index =section;
    switch (region) {
        case 1:
            if (section>=22) {
                index++;
            }
            break;
        case 2:
            if (section==0) {
                index=22;
            }
            else if (section<8)
            {
                index+=24;
            }
            else
                index = 45;
            break;
        case 3:
            if (section<2) {
                index+=33;
            }
            else if(section ==2){
                index=38;
            }
            else
                index+=37;
            break;
        case 4:
            if (section<3) {
                index+=35;
            }
            else
                index=39;
            break;
        default:
            break;
    }
    return index;
}

- (UIView *) tableView: (UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    	return [UITableView groupedSectionHeaderWithTitle:[data.Stop objectAtIndex:[self sectionChangeIndex:section]]];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (region==1)
        return 24;
    else if (region==2)
        return 9;
    else if (region==3)
        return 8;
    else if (region==4)
        return 4;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int row = [[data.Index objectAtIndex:[self sectionChangeIndex:section]] intValue];
    if (!row) {
        row=1;
    }
    return row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d%d",indexPath.section,indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
    }
    if (![[data.Index objectAtIndex:[self sectionChangeIndex:indexPath.section]] intValue]) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text=@"目前暫無資料";
        return cell;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [data.Route objectAtIndex:[[data.IndexBase objectAtIndex:[self sectionChangeIndex:indexPath.section]] intValue]+indexPath.row ];
    // Configure the cell...
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.textLabel.numberOfLines = 0;
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
