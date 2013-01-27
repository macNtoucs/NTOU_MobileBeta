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
#import "ClassDataBase.h"
@interface ClassInfoView (){
    int types;
    BOOL edit;
    NSMutableArray* resource;
}
@end

@implementation ClassInfoView
@synthesize textView;
@synthesize delegatetype5;
@synthesize moodleData;
#pragma mark Constants

#define DEMO_VIEW_CONTROLLER_PUSH FALSE

#pragma mark UIViewController methods

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
        self.textView.text = [[NSUserDefaults standardUserDefaults] objectForKey:type5];
        self.textView.returnKeyType = UIReturnKeyDefault;
        self.textView.keyboardType = UIKeyboardTypeDefault;
        self.textView.scrollEnabled = YES;
        
        edit = NO;
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) // See README
		return UIInterfaceOrientationIsPortrait(interfaceOrientation);
	else
		return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView applyStandardColors];
    if (self.title == type1){
        types = 1;
    }
    else if (self.title == type2)
        types = 2;
    else if (self.title == type3)
        types = 3;
    else if (self.title == type4)
        types = 4;
    else if (self.title == type5){
        types = 5;
        self.tableView.scrollEnabled = NO;
    }
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
        return 1;
    else if (types == 2)
        return 1;
    else if (types == 3){
        resource = [[[moodleData objectForKey:moodleListKey] objectAtIndex:0] objectForKey:moodleResourceInfoKey];
        return [resource count];
    }
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
        return [[moodleData objectForKey:moodleListKey] count];
        
    else if (types == 2||types == 4||types == 6){
        NSArray* infos = [[[moodleData objectForKey:moodleListKey] objectAtIndex:0] objectForKey:moodleResourceInfoKey];
        resource = [[NSMutableArray alloc] init];
        for (NSDictionary* resourceInfo in infos) {
            if (([[resourceInfo objectForKey:moodleResourceModuleKey] isEqualToString:moodleModuleAssignmentKey]&&types == 2)||
                ([[resourceInfo objectForKey:moodleResourceModuleKey] isEqualToString:moodleModuleLectureKey]&&types == 4)||
                ([[resourceInfo objectForKey:moodleResourceModuleKey] isEqualToString:moodleModuleExamKey]&&types == 6))
                [resource addObject:resourceInfo];
        }
        if (types == 2||types == 6) {
            return [resource count]+1;
        }
        return [resource count];
    }
    else if (types == 3)
        return 1;
    else if (types == 5)
        return 1;
    return 1;
}


- (void)handleSingle:(NSString*)filename
{
	NSString *phrase = nil; // Document password (for unlocking most encrypted PDF files)
    NSString *filePath = [[[NSBundle mainBundle] bundlePath]stringByAppendingPathComponent:filename];

    
	ReaderDocument *document = [ReaderDocument withDocumentFilePath:filePath password:phrase];
    
	if (document != nil) // Must have a valid ReaderDocument object in order to proceed with things
	{
		ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
        
		readerViewController.delegate = self; // Set the ReaderViewController delegate to self
        
        
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
        
		[self.navigationController pushViewController:readerViewController animated:YES];
        
#else // present in a modal view controller
        
        [delegatetype5 presentOn:readerViewController];
        
        
#endif // DEMO_VIEW_CONTROLLER_PUSH

        
	}
}

#pragma mark ReaderViewControllerDelegate methods

- (void)dismissReaderViewController:(ReaderViewController *)viewController
{
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
    
	[self.navigationController popViewControllerAnimated:YES];
    
#else // dismiss the modal view controller
    [delegatetype5 presentOff];
	
    
#endif // DEMO_VIEW_CONTROLLER_PUSH
}

- (void) myAction: (UITapGestureRecognizer *) gr {
    NSURL *url = nil;
    
    if (types==4) {
        if (gr.view.tag == 8) {
            [self handleSingle:@"Algorithm-Ch9.pdf"];
        }
        else if (gr.view.tag == 7){
            [self handleSingle:@"Algorithm-Ch8.pdf"];
        }
        else if (gr.view.tag == 6){
            [self handleSingle:@"Algorithm-Ch7.pdf"];
        }
        else if (gr.view.tag == 5){
            [self handleSingle:@"Algorithm-Ch6.pdf"];
        }
        else if (gr.view.tag == 4){
            [self handleSingle:@"Algorithm-Ch4.pdf"];
        }
        else if (gr.view.tag == 3){
            [self handleSingle:@"Algorithm-Ch3.pdf"];
        }
        else if (gr.view.tag == 2){
            [self handleSingle:@"Algorithm-Ch2.pdf"];
        }
        else if (gr.view.tag == 1){
            [self handleSingle:@"Algorithm-Ch1.pdf"];
        }
        else if (gr.view.tag == 0){
            [self handleSingle:@"Syllabus.pdf"];
        }
        

    }
    else if (types==2)
    {
        switch (gr.view.tag) {
            case 1:
                [self handleSingle:@"2012_algorithm_homework_1.pdf"];
                break;
            case 2:
                [self handleSingle:@"2012_algorithm_homework_2.pdf"];
                break;
            case 3:
                [self handleSingle:@"2012_algorithm_homework_3.pdf"];
                break;
            case 4:
                [self handleSingle:@"2012_algorithm_homework_4.pdf"];
                break;
            case 5:
                [self handleSingle:@"2012_algorithm_homework_5.pdf"];
                break;
            case 6:
                [self handleSingle:@"2012_algorithm_homework_6.pdf"];
                break;
            case 7:
                [self handleSingle:@"2012_algorithm_homework_7.pdf"];
                break;
            case 8:
                [self handleSingle:@"2012_algorithm_homework_8.pdf"];
                break;

            default:
                break;
        }
    }
    else if (types==6)
    {
        switch (gr.view.tag) {
            case 1:
                [self handleSingle:@"AL-mid-11.pdf"];
                url = [[[ NSURL alloc ] initWithString: @"https://dl.dropbox.com/u/57606902/%E6%BC%94%E7%AE%97%E6%B3%95/AL-mid-11.pdf" ] autorelease];
                break;
            case 2:
                [self handleSingle:@"2011_NTOU_CSIE_algorithm_final.pdf"];
                break;
            case 3:
                [self handleSingle:@"AL-mid-10.pdf"];
                break;
            case 4:
                [self handleSingle:@"2010_NTOU_CSIE_algorithm_final.pdf"];
                break;
                
            default:
                break;
        }
    }
    if (url!=nil) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

-(NSString *)subLabeltext:(NSIndexPath *)indexPath
{
    if (types == 1){
        NSDictionary* gradeInfo = [[moodleData objectForKey:moodleListKey] objectAtIndex:indexPath.row];
        return [gradeInfo objectForKey:moodleGradeKey];
    }
    return nil;
}

-(NSString *)textLabeltext:(NSIndexPath *)indexPath
{
    if (types == 1){
        NSDictionary* gradeInfo = [[moodleData objectForKey:moodleListKey] objectAtIndex:indexPath.row];
        NSString *str = nil;
        if ([gradeInfo objectForKey:moodleGradeCommentKey]) {
            str = [[gradeInfo objectForKey:moodleGradeNameKey] stringByAppendingFormat:@"\n(%@)",[gradeInfo objectForKey:moodleGradeCommentKey]];
        }
        else
            str = [gradeInfo objectForKey:moodleGradeNameKey];
        return str;
    }
    else if (types == 2||types == 4||types == 6){
        if (indexPath.row == 0&&types == 2)
            return @"         作業                          繳交期限";
        else if (indexPath.row == 0&&types == 6)
            return @"考試名稱與範圍";
        else if (types == 2||types == 6)
            return [[resource objectAtIndex:indexPath.row-1] objectForKey:moodleResourceTitleKey];
        else
            return [[resource objectAtIndex:indexPath.row] objectForKey:moodleResourceTitleKey];
    }
    else if (types == 3){
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
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d%d",indexPath.section,indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UILabel *label = nil;
    UILabel *detailLabel = nil;
    if (cell == nil)
    {
        CGSize constraintSize = CGSizeMake(270.0f, 2009.0f);
        UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:CELL_STANDARD_FONT_SIZE];
        CGSize labelSize = [[self textLabeltext:indexPath] sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
        CGFloat rowHeight = labelSize.height + 20.0f;
        label = [[UILabel alloc] init];
        detailLabel = [[UILabel alloc] init];
        if (types==1&&indexPath.section<3){
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
            label.frame = CGRectMake(5, 0,220, rowHeight);
            detailLabel.frame = CGRectMake(270, 0,20, rowHeight);
        }
        else{
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            label.frame = CGRectMake(5, 0,295, rowHeight);
            detailLabel.frame = CGRectMake(280, 0,20, rowHeight);
        }
        cell.backgroundColor = SECONDARY_GROUP_BACKGROUND_COLOR;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        label.tag=indexPath.row;
        label.lineBreakMode = UILineBreakModeWordWrap;
        label.numberOfLines = 0;
        label.font = [UIFont fontWithName:STANDARD_FONT size:CELL_STANDARD_FONT_SIZE];
        label.textColor = CELL_STANDARD_FONT_COLOR;
        label.backgroundColor = [UIColor clearColor];
        detailLabel.tag=indexPath.row;
        detailLabel.backgroundColor = [UIColor clearColor];
        detailLabel.textAlignment = UITextAlignmentRight;
        [cell.contentView addSubview:label];
        [cell.contentView addSubview:detailLabel];
        label.text = [self textLabeltext:indexPath];
        detailLabel.text = [self subLabeltext:indexPath];
        
        if (types==1&&[detailLabel.text floatValue]<60) {
            detailLabel.textColor = [UIColor redColor];
        }
        if (types==6||(types==1&&indexPath.section==3)) {
            label.textAlignment = UITextAlignmentCenter;
            if (types==1&&indexPath.section==3){
                label.textColor = [UIColor blueColor];
            }
        }
        
        if (types == 4||(types == 2&&indexPath.row>0) ||(types == 6&&indexPath.row>0)) {
            label.userInteractionEnabled = YES;
            label.textColor = [UIColor blueColor];
            UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myAction:)];
            [label addGestureRecognizer:gr];
            gr.numberOfTapsRequired = 1;
            gr.cancelsTouchesInView = NO;
        }
        else if((types == 2&&indexPath.row==0) ||(types == 6&&indexPath.row==0))
            label.font = [UIFont fontWithName:BOLD_FONT size:CELL_STANDARD_FONT_SIZE];
        

    }
    else
    {
        label = (UILabel *)[cell.contentView viewWithTag:indexPath.row];
        detailLabel = (UILabel *)[cell.contentView viewWithTag:indexPath.row];
    }
    
    if (types==5) {
        if (edit) {
            textView.frame = CGRectMake(0, 0, 300, [[UIScreen mainScreen] bounds].size.height-320);
        } else {
            textView.frame = CGRectMake(0, 0, 300, [[UIScreen mainScreen] bounds].size.height-55);
        }
        [cell.contentView addSubview:self.textView];
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
    NSUserDefaults *userPrefs = [NSUserDefaults standardUserDefaults];
    [userPrefs setObject:self.textView.text forKey:type5];
    [userPrefs synchronize];
    edit = NO;
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil] withRowAnimation:UITableViewRowAnimationLeft];
}

- (void)textViewDidChange:(UITextView *)textView{
    
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (types==3) {
        CGFloat rowHeight = 0;
        UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:14.0];
        CGSize constraintSize = CGSizeMake(270.0f, 2009.0f);
        NSString *cellText = nil;
        
        cellText = [[resource objectAtIndex:section] objectForKey:moodleResourceTitleKey];        CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
        rowHeight = labelSize.height + 20.0f;
        
        return rowHeight;
    }
    return 1;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName=nil;
    if (types==3) {
        sectionName= @" ";
    }
    return sectionName;
}


- (UIView *) tableView: (UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (types==3) {
	NSString *headerTitle = [[resource objectAtIndex:section] objectForKey:moodleResourceTitleKey];

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
    //return [[resource objectAtIndex:section] objectForKey:moodleResourceTitleKey];
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
        return [[UIScreen mainScreen] bounds].size.height-320;
    }
    else if (types==5) {
        return [[UIScreen mainScreen] bounds].size.height-155;
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
