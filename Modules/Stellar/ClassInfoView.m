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
    BOOL edit;
}
@end

@implementation ClassInfoView
@synthesize textView;
@synthesize delegatetype5;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.textView = [[UITextView alloc] init];
        self.textView.textColor = CELL_STANDARD_FONT_COLOR;
        self.textView.font = [UIFont fontWithName:STANDARD_FONT size:CELL_STANDARD_FONT_SIZE];
        self.textView.delegate = self;
        self.textView.backgroundColor = [UIColor clearColor];
        self.textView.text = @"Now is the time for all good developers tocome to serve their country.\n\nNow is the time for all good developers to cometo serve their country.";
        self.textView.returnKeyType = UIReturnKeyDefault;
        self.textView.keyboardType = UIKeyboardTypeDefault;
        self.textView.scrollEnabled = YES;
        
        edit = NO;
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
    else if (self.title == type6)
        types = 6;
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
        return 4;
    else if (types == 2)
        return 1;
    else if (types == 3)
        return 14;
    else if (types == 4)
        return 1;
    else if (types == 5)
        return 1;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (types == 1)
        switch (section) {
            case 0:
                return 5;
                break;
            case 1:
                return 2;
                break;
            case 2:
                return 1;
                break;
            case 3:
                return 1;
                break;
            default:
                break;
        }
    else if (types == 2)
        return 9;
    else if (types == 3)
        return 1;
    else if (types == 4)
        return 9;
    else if (types == 5)
        return 1;
    else if (types == 6)
        return 5;
    return 1;
}

- (void) myAction: (UITapGestureRecognizer *) gr {
    NSURL *url;
    if (types==4) {
        if (gr.view.tag == 8) {
            url = [[[ NSURL alloc ] initWithString: @"https://dl.dropbox.com/u/57606902/%E6%BC%94%E7%AE%97%E6%B3%95/Algorithm-Ch9.pdf" ] autorelease];
        }
        else if (gr.view.tag == 7){
            url = [[[ NSURL alloc ] initWithString: @"https://dl.dropbox.com/u/57606902/%E6%BC%94%E7%AE%97%E6%B3%95/Algorithm-Ch8.pdf" ] autorelease];
        }
        else if (gr.view.tag == 6){
            url = [[[ NSURL alloc ] initWithString: @"https://dl.dropbox.com/u/57606902/%E6%BC%94%E7%AE%97%E6%B3%95/Algorithm-Ch7.pdf" ] autorelease];
        }
        else if (gr.view.tag == 5){
            url = [[[ NSURL alloc ] initWithString: @"https://dl.dropbox.com/u/57606902/%E6%BC%94%E7%AE%97%E6%B3%95/Algorithm-Ch6.pdf" ] autorelease];
        }
        else if (gr.view.tag == 4){
            url = [[[ NSURL alloc ] initWithString: @"https://dl.dropbox.com/u/57606902/%E6%BC%94%E7%AE%97%E6%B3%95/Algorithm-Ch4.pdf" ] autorelease];
        }
        else if (gr.view.tag == 3){
            url = [[[ NSURL alloc ] initWithString: @"https://dl.dropbox.com/u/57606902/%E6%BC%94%E7%AE%97%E6%B3%95/Algorithm-Ch3.pdf" ] autorelease];
        }
        else if (gr.view.tag == 2){
            url = [[[ NSURL alloc ] initWithString: @"https://dl.dropbox.com/u/57606902/%E6%BC%94%E7%AE%97%E6%B3%95/Algorithm-Ch2.pdf" ] autorelease];
        }
        else if (gr.view.tag == 1){
            url = [[[ NSURL alloc ] initWithString: @"https://dl.dropbox.com/u/57606902/%E6%BC%94%E7%AE%97%E6%B3%95/Algorithm-Ch1.pdf" ] autorelease];
        }
        else if (gr.view.tag == 0){
            url = [[[ NSURL alloc ] initWithString: @"https://dl.dropbox.com/u/57606902/%E6%BC%94%E7%AE%97%E6%B3%95/Syllabus.pdf" ] autorelease];
        }
    }
    else if (types==2)
    {
        switch (gr.view.tag) {
            case 1:
                url = [[[ NSURL alloc ] initWithString: @"https://dl.dropbox.com/u/57606902/%E6%BC%94%E7%AE%97%E6%B3%95/exercise/2012_algorithm_homework_1.pdf" ] autorelease];
                break;
            case 2:
                url = [[[ NSURL alloc ] initWithString: @"https://dl.dropbox.com/u/57606902/%E6%BC%94%E7%AE%97%E6%B3%95/exercise/2012_algorithm_homework_2.pdf" ] autorelease];
                break;
            case 3:
                url = [[[ NSURL alloc ] initWithString: @"https://dl.dropbox.com/u/57606902/%E6%BC%94%E7%AE%97%E6%B3%95/exercise/2012_algorithm_homework_3.pdf" ] autorelease];
                break;
            case 4:
                url = [[[ NSURL alloc ] initWithString: @"https://dl.dropbox.com/u/57606902/%E6%BC%94%E7%AE%97%E6%B3%95/exercise/2012_algorithm_homework_4.pdf" ] autorelease];
                break;
            case 5:
                url = [[[ NSURL alloc ] initWithString: @"https://dl.dropbox.com/u/57606902/%E6%BC%94%E7%AE%97%E6%B3%95/exercise/2012_algorithm_homework_5.pdf" ] autorelease];
                break;
            case 6:
                url = [[[ NSURL alloc ] initWithString: @"https://dl.dropbox.com/u/57606902/%E6%BC%94%E7%AE%97%E6%B3%95/exercise/2012_algorithm_homework_6.pdf" ] autorelease];
                break;
            case 7:
                url = [[[ NSURL alloc ] initWithString: @"https://dl.dropbox.com/u/57606902/%E6%BC%94%E7%AE%97%E6%B3%95/exercise/2012_algorithm_homework_7.pdf" ] autorelease];
                break;
            case 8:
                url = [[[ NSURL alloc ] initWithString: @"https://dl.dropbox.com/u/57606902/%E6%BC%94%E7%AE%97%E6%B3%95/exercise/2012_algorithm_homework_8.pdf" ] autorelease];
                break;

            default:
                break;
        }
    }
    else if (types==6)
    {
        switch (gr.view.tag) {
            case 1:
                url = [[[ NSURL alloc ] initWithString: @"https://dl.dropbox.com/u/57606902/%E6%BC%94%E7%AE%97%E6%B3%95/AL-mid-11.pdf" ] autorelease];
                break;
            case 2:
                url = [[[ NSURL alloc ] initWithString: @"https://dl.dropbox.com/u/57606902/%E6%BC%94%E7%AE%97%E6%B3%95/2011_NTOU_CSIE_algorithm_final.pdf" ] autorelease];
                break;
            case 3:
                url = [[[ NSURL alloc ] initWithString: @"https://dl.dropbox.com/u/57606902/%E6%BC%94%E7%AE%97%E6%B3%95/AL-mid-10.pdf" ] autorelease];
                break;
            case 4:
                url = [[[ NSURL alloc ] initWithString: @"https://dl.dropbox.com/u/57606902/%E6%BC%94%E7%AE%97%E6%B3%95/2010_NTOU_CSIE_algorithm_final.pdf" ] autorelease];
                break;
                
            default:
                break;
        }
    }
    [[UIApplication sharedApplication] openURL:url];
}

-(NSString *)subLabeltext:(NSIndexPath *)indexPath
{
    if (types == 1)
        switch (indexPath.section) {
            case 0:
                switch (indexPath.row) {
                    case 0:
                        return @"75";
                        break;
                    case 1:
                        return @"95";
                        break;
                    case 2:
                        return @"50";
                        break;
                    case 3:
                        return @"70";
                        break;
                    case 4:
                        return @"90";
                        break;
                    default:
                        break;
                }
                break;
            case 1:
                switch (indexPath.row) {
                    case 0:
                        return @"85";
                        break;
                    case 1:
                        return @"70";
                        break;
                    default:
                        break;
                }
                break;
            case 2:
                switch (indexPath.row) {
                    case 0:
                        return @"75";
                        break;
                    default:
                        break;
                }
                break;
                
            default:
                break;
        }
    return nil;
}

-(NSString *)textLabeltext:(NSIndexPath *)indexPath
{
    if (types == 1)
        switch (indexPath.section) {
            case 0:
                switch (indexPath.row) {
                    case 0:
                        return @"作業1";
                        break;
                    case 1:
                        return @"作業2";
                        break;
                    case 2:
                        return @"作業3";
                        break;
                    case 3:
                        return @"作業4";
                        break;
                    case 4:
                        return @"作業5";
                        break;
                    default:
                        break;
                }
                break;
            case 1:
                switch (indexPath.row) {
                    case 0:
                        return @"小考1";
                        break;
                    case 1:
                        return @"小考2";
                        break;
                    default:
                        break;
                }
                break;
            case 2:
                switch (indexPath.row) {
                    case 0:
                        return @"期中考";
                        break;
                    default:
                        break;
                }
                break;
            case 3:
                switch (indexPath.row) {
                    case 0:
                        return @"45";
                        break;
                    default:
                        break;
                }
                break;
                
            default:
                break;
        }
    else if (types == 2)
        switch (indexPath.row) {
            case 0:
                return @"         作業                          繳交期限";
                break; 
            case 1:
                return @"  Homework1                         10/11";
                break;
            case 2:
                return @"  Homework2                         10/18";
                break;
            case 3:
                return @"  Homework3                         10/25";
                break;
            case 4:
                return @"  Homework4                         11/01";
                break;
            case 5:
                return @"  Homework5                         11/08";
                break;
            case 6:
                return @"  Homework6                         11/15";
                break;
            case 7:
                return @"  Homework7                         11/29";
                break;
            case 8:
                return @"  Homework8                         12/06";
                break;
            default:
                break;
        }
    else if (types == 3){
        /*if (indexPath.section == 0) {
            return @"11/09	作業7、各作業解答、小考解答已上傳\n各項紀錄以及成績皆已登錄，如果有問題請記得通知助教\n另外提醒，\n11/14(三)的課輔，由於期中考週的關係暫停一次\n11/15(四)要繳交作業6！！！\n作業7將會在11/21(三)的課輔講解，但繳交期限仍為11/22(四)\n期中考資訊如下:\n時間：11/15(四) 09:20~12:00\n地點：B10、B12\n範圍：老師教過的部分\n可攜帶 8分之1 A4 紙張！！！\n另外提醒~請記得攜帶學生證！！！\n祝各位 期中考順利！！！";
        }*/
        if (indexPath.section == 0) {
            return @"11/02	作業6、第8章講義-Quicksort 已上傳\n11/07(三)之前助教會將小考成績、作業成績、解答以及補強有到的名單放上\n小考及作業也會在當週發回\n另外提醒，11/07(三)晚上的補強記得將小考題目卷帶來，助教會講解";
        }
        else if (indexPath.section == 1) {
            return @"10/27	作業5、第7章講義-Quicksort 已上傳";
        }
        else if (indexPath.section == 2) {
            return @"10/23	作業一、作業二 成績、解答已上傳\n成績以及解答上如果有問題請找助教";
        }
        else if (indexPath.section == 3) {
            return @"10/19	教學網頁已有修改過\n請各位同學確認一下資料是否有誤\n如有錯誤或者疑問請至 LAB 505 找 陳揚升 助教\n或者寄 E-mail 至 10157004@ntou.edu.tw";
        }
        else if (indexPath.section == 4) {
            return @"10/19	作業4 已經上傳\n繳交期限為 11/01";
        }
        else if (indexPath.section == 5) {
            return @"10/18	10/25(四)會有隨堂小考\n範圍為 Ch1 ~ Ch 4\n請各位同學儘早準備！！！";
        }
        else if (indexPath.section == 6) {
            return @"10/5	10/10為國慶日放假, 改為下禮拜四的五點半課輔\n上課會提醒各位";
        }
        else if (indexPath.section == 7) {
            return @"10/4	作業事項:\n一. 作業繳交請用A4紙手寫, 其他不收 禮拜四上課收\n二. 遲交扣分, 答案放上後不得補交\n三. 作業查看兩個方法 1. 實驗室INS112找助教 2. 課輔時間會發 (成績有問題可以問)\n四. 作業一 10/11日繳交";
        }
        else if (indexPath.section == 8) {
            return @"9/27	第一章註解講義上傳, 作業一上傳 下禮拜三(10/4)下午五點半上課輔 (原上課教室)";
        }
        else if (indexPath.section == 9) {
            return @"9/24	2010,2011期中期末考古題上傳";
        }
        else if (indexPath.section == 10) {
            return @"9/24	課輔時間為每個禮拜三下午五點半，從9/26開始，9/26為講解有關作業事項。如沒特別公布為101教室上課，此後每周三下午五點半都需課輔。";
        }
        else if (indexPath.section == 11) {
            return @"9/24	第二章講義已經上傳。";
        }
        else if (indexPath.section == 12) {
            return @"9/24	第一章講義已經上傳。";
        }
        else if (indexPath.section == 13) {
            return @"9/24	Syllabus講義已經上傳。";
        }
    }
    else if (types == 4){
        if (indexPath.row == 8) {
            return @"Ch9  Medians and Order Statistics";
        }
        else if (indexPath.row == 7) {
            return @"Ch8  Sorting in Linear Time";
        }
        else if (indexPath.row == 6) {
            return @"Ch7  Quicksort";
        }
        else if (indexPath.row == 5) {
            return @"Ch6  Heapsort";
        }
        else if (indexPath.row == 4) {
            return @"Ch4  Recurrences";
        }
        else if (indexPath.row == 3) {
            return @"Ch3  Growth of Functions";
        }
        else if (indexPath.row == 2) {
            return @"Ch2  Getting Started";
        }
        else if (indexPath.row == 1) {
            return @"Ch1  Preliminaries";
        }
        else if (indexPath.row == 0) {
            return @"Syllabus";
        }

    }
    else if (types == 6){
        if (indexPath.row == 4) {
            return @"2010期末考";
        }
        else if (indexPath.row == 3) {
            return @"2010期中考";
        }
        else if (indexPath.row == 2) {
            return @"2011期末考";
        }
        else if (indexPath.row == 1) {
            return @"2011期中考";
        }
        else if (indexPath.row == 0) {
            return @"考試名稱與範圍";
        }
        
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d%d",indexPath.section,indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        if (types==1&&indexPath.section<3)
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        else
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [self textLabeltext:indexPath];
    cell.detailTextLabel.text = [self subLabeltext:indexPath];
    if ([cell.detailTextLabel.text floatValue]<60) {
        cell.detailTextLabel.textColor = [UIColor redColor];
    }
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.tag = indexPath.row;
    cell.backgroundColor = SECONDARY_GROUP_BACKGROUND_COLOR;
	cell.textLabel.font = [UIFont fontWithName:STANDARD_FONT size:CELL_STANDARD_FONT_SIZE];
	cell.textLabel.textColor = CELL_STANDARD_FONT_COLOR;
	cell.textLabel.backgroundColor = [UIColor clearColor];
    if (types==5) {
        if (edit) {
            textView.frame = CGRectMake(0, 5, 300, 150);
        } else {
            textView.frame = CGRectMake(0, 5, 300, 300);
        }
        [cell.contentView addSubview:self.textView];
    }
    else if (types==6||(types==1&&indexPath.section==3)) {
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        if (types==1&&indexPath.section==3){
            cell.textLabel.textColor = [UIColor blueColor];
        }
    }

    if (types == 4||(types == 2&&indexPath.row>0) ||(types == 6&&indexPath.row>0)) {
        cell.textLabel.userInteractionEnabled = YES;
        cell.textLabel.textColor = [UIColor blueColor];
        UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myAction:)];
        [cell.textLabel addGestureRecognizer:gr];
        gr.numberOfTapsRequired = 1;
        gr.cancelsTouchesInView = NO;
    }
    else if((types == 2&&indexPath.row==0) ||(types == 6&&indexPath.row==0))
        cell.textLabel.font = [UIFont fontWithName:BOLD_FONT size:CELL_STANDARD_FONT_SIZE];
    
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

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    edit = YES;
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil] withRowAnimation:UITableViewRowAnimationLeft];
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [delegatetype5 rightBarButtonItemOn];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [delegatetype5 rightBarButtonItemOff];
    edit = NO;
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil] withRowAnimation:UITableViewRowAnimationLeft];
}

- (void)textViewDidChange:(UITextView *)textView{
    
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (types==1)
        return 32;
    return 1;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName=nil;
    if (types==1) {
        sectionName= @" ";
    }
    return sectionName;
}


- (UIView *) tableView: (UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (types==1) {
	NSString *headerTitle;
        switch (section) {
            case 0:
                headerTitle = @"作業成績 (30%)：";
                break;
            case 1:
                headerTitle = @"平時考成績 (30%)：";
                break;
            case 2:
                headerTitle = @"期中、期末成績 (40%)：";
                break;
            default:
                headerTitle = @"目前實得總成績：";
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
    return nil;
}


-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat rowHeight = 0;
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:CELL_STANDARD_FONT_SIZE];
    CGSize constraintSize = CGSizeMake(270.0f, 2009.0f);
    NSString *cellText = @" ";
    cellText = [self textLabeltext:indexPath]; // just something to guarantee one line
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    rowHeight = labelSize.height + 20.0f;
    if (edit) {
        return 160;
    }
    else if (types==5) {
        return 320;
    }
    else
    return rowHeight;
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
