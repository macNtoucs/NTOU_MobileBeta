//
//  ClassInfoView.m
//  MIT Mobile
//
//  Created by mini server on 12/11/3.
//
//

#import "ClassInfoView.h"
#import "UIKit+MITAdditions.h"
#import "MITUIConstants.h"
@interface ClassInfoView (){
    int types;
}
@end

@implementation ClassInfoView

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
    if (self.title == type1)
        types = 1;
    else if (self.title == type2)
        types = 2;
    else if (self.title == type3)
        types = 3;
    else if (self.title == type4)
        types = 4;
    else if (self.title == type5)
        types = 5;
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
    if (types == 1)
        return 1;
    else if (types == 2)
        return 1;
    else if (types == 3)
        return 5;
    else if (types == 4)
        return 4;
    else if (types == 5)
        return 1;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (void) myAction: (UITapGestureRecognizer *) gr {
    NSURL *url;
    if (gr.view.tag == 0) {
            url = [[[ NSURL alloc ] initWithString: @"https://dl.dropbox.com/u/57606902/%E5%9C%96%E8%AB%96%E6%BC%94%E7%AE%97%E6%B3%95/Algorithm-Ch19.pdf" ] autorelease];
    }
    else if (gr.view.tag == 1){
    url = [[[ NSURL alloc ] initWithString: @"https://dl.dropbox.com/u/57606902/%E5%9C%96%E8%AB%96%E6%BC%94%E7%AE%97%E6%B3%95/Algorithm-Ch18-5.pdf" ] autorelease];
    }
    else if (gr.view.tag == 2){
        url = [[[ NSURL alloc ] initWithString: @"https://dl.dropbox.com/u/57606902/%E5%9C%96%E8%AB%96%E6%BC%94%E7%AE%97%E6%B3%95/Algorithm-Ch18.pdf" ] autorelease];
    }
    else if (gr.view.tag == 3){
        url = [[[ NSURL alloc ] initWithString: @"https://dl.dropbox.com/u/57606902/%E5%9C%96%E8%AB%96%E6%BC%94%E7%AE%97%E6%B3%95/Algorithm-Ch17.pdf" ] autorelease];
    }
    [[UIApplication sharedApplication] openURL:url];
}

-(NSString *)textLabeltext:(NSIndexPath *)indexPath
{
    if (types == 1)
        return @"11/13 期中考 範圍Ch3~Ch19 p.13";
    else if (types == 2)
        return @"分組報告準備";
    else if (types == 3){
        if (indexPath.section == 0) {
            return @"11/02    課程講義 Ch19 - Fibonacci Heaps已上傳";
        }
        else if (indexPath.section == 1) {
            return @"10/30    課程講義 Ch18.5 - Binomial Heaps已上傳";
        }
        else if (indexPath.section == 2) {
            return @"10/23    課程講義 Ch18 - B-Trees 已上傳    修課名單內容已加入上課加分紀錄";
        }
        else if (indexPath.section == 3) {
            return @"10/08    課程講義 Ch6 - Heapsort 已上傳    上課講義、修課名單內容已有修改另外提醒，尚未分組的同學請盡速找助教確認組別!!!    謝謝!!!";
        }
        else if (indexPath.section == 4) {
            return @"9/24     已將修課名單加入，請各位同學確認一下資料是否有誤，若有錯誤的話麻煩請通知一下，謝謝。";
        }
    }
    else if (types == 4){
        if (indexPath.section == 0) {
            return @"Ch19 - Fibonacci Heaps ";
        }
        else if (indexPath.section == 1) {
            return @"Ch18.5 - Binomial Heaps";
        }
        else if (indexPath.section == 2) {
            return @"Ch18 - B-Trees";
        }
        else if (indexPath.section == 3) {
            return @"Ch17 - Amortized Analysis";
        }
    }
    else if (types == 5)
        return @"霧裡看花";
    return nil;
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
    cell.textLabel.text = [self textLabeltext:indexPath];
    cell.textLabel.textColor = CELL_STANDARD_FONT_COLOR;
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.tag = indexPath.section;
    if (types == 4 ) {
        cell.textLabel.userInteractionEnabled = YES;
        cell.textLabel.textColor = [UIColor blueColor];
        UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myAction:)];
        [cell.textLabel addGestureRecognizer:gr];
        gr.numberOfTapsRequired = 1;
        gr.cancelsTouchesInView = NO;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName=nil;
    if (types ==6) {
        switch (section)
        {
            case 0:
                sectionName =@"11/02";
                break;
            case 1:
                sectionName =@"10/30";
                break;
            case 2:
                sectionName =@"10/23";
                break;
            case 3:
                sectionName =@"10/08";
                break;
            case 4:
                sectionName =@"09/24";
                break;
            default:
                sectionName = @"";
                break;
        }
    }
    return sectionName;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (types == 1)
        return 280;
    else if (types == 2)
        return 280;
    else if (types == 3)
        return 70;
    else if (types == 4)
        return 50;
    else if (types == 5)
        return 280;
    return 280;
}

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
