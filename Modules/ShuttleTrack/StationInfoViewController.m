//
//  StationInfoViewController.m
//  MIT Mobile
//
//  Created by MacAir on 12/11/3.
//
//

#import "StationInfoViewController.h"

@interface StaionInfoTableViewController ()

@end

@implementation StaionInfoTableViewController
@synthesize dataURL;
@synthesize StartAndTerminalstops;
@synthesize depatureTimes;
@synthesize arrivalTimes;
@synthesize dataSource;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

-(void) recieveURL{
    dataURL = [[NSURL alloc]init];
    dataURL = [self.dataSource StationInfoURL:self];
   
}
-(void) recieveStartAndDepature{
    startStation =[[NSString alloc]initWithString:[self.dataSource startStationTitile:self]];
    depatureStation =[[NSString alloc]initWithString:[self.dataSource depatureStationTitile:self]];
}
-(void)recieveData{
    [self recieveURL];
    if (![[dataURL absoluteString] isEqualToString:@""]){
        [self recieveStartAndDepature];
        [self fetchData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }
    
}


-(void)fetchData{
  
    downloadView = [DownloadingView new];
    dispatch_async(dispatch_get_main_queue(), ^{
        [downloadView AlertViewStart];
    });

    StartAndTerminalstops = [NSMutableArray new];
    depatureTimes = [NSMutableArray new];
    arrivalTimes = [NSMutableArray new];
    trainStyle = [NSMutableArray new];
    NSError* error;
    NSData* data = [[NSString stringWithContentsOfURL:dataURL encoding:NSUTF8StringEncoding error:&error] dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple* parser = [[TFHpple alloc] initWithHTMLData:data];
    NSArray *tableData_td  = [parser searchWithXPathQuery:@"//body//form//div//table//tbody//tr//td"];
    for (int i=3 ; i< [tableData_td count] ; ++i){
        if (i%11==3) {
            TFHppleElement * attributeElement = [tableData_td objectAtIndex:i];
            NSArray * contextArr = [attributeElement children];
            TFHppleElement * context = [contextArr objectAtIndex:0];
            NSArray * stops = [context children];
            [StartAndTerminalstops addObject: [[stops objectAtIndex:0]content] ];
        }
        else if (i%11 == 4){
            TFHppleElement * attributeElement = [tableData_td objectAtIndex:i];
            NSArray * contextArr = [attributeElement children];
            TFHppleElement * context = [contextArr objectAtIndex:0];
            NSArray * stops = [context children];
            [depatureTimes addObject: [[stops objectAtIndex:0]content] ];
        }
        else if (i%11 == 5){
            TFHppleElement * attributeElement = [tableData_td objectAtIndex:i];
            NSArray * contextArr = [attributeElement children];
            TFHppleElement * context = [contextArr objectAtIndex:0];
            NSArray * stops = [context children];
            [arrivalTimes addObject: [[stops objectAtIndex:0]content] ];
        }
    }
     NSArray *tableData_trainStyle  = [parser searchWithXPathQuery:@"//body//form//div//table//tbody//tr//td//span"];
    for (int i=0 ; i< [tableData_trainStyle count] ; ++i){
        TFHppleElement * attributeElement = [tableData_trainStyle objectAtIndex:i];
        NSArray * contextArr = [attributeElement children];
        if (!(i%3))
          [trainStyle addObject: [[contextArr objectAtIndex:0]content] ];
        else continue;
       }
    [downloadView AlertViewEnd];
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
   
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

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
    return [StartAndTerminalstops count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d%d",indexPath.section,indexPath.row];
    SecondaryGroupedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[SecondaryGroupedTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    if (indexPath.row == 0 ) {
        cell.textLabel.text = [NSString stringWithFormat:@"車種                            %@           %@",startStation,depatureStation];
        cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        cell.detailTextLabel.textColor = [UIColor brownColor];
        cell.textLabel.textColor = [UIColor brownColor];
    }
    else if (indexPath==0 && [StartAndTerminalstops count]==0){
        cell.textLabel.text = [NSString stringWithFormat:@"無資料"];
    }
    else {
        NSString * detailString = [NSString stringWithFormat:@"%@         %@", [depatureTimes objectAtIndex:indexPath.row-1],[arrivalTimes objectAtIndex:indexPath.row-1] ] ;
        cell.textLabel.text=[NSString stringWithFormat:@"%@",[StartAndTerminalstops objectAtIndex:indexPath.row-1]] ;
        if ([[trainStyle objectAtIndex:indexPath.row-1] isEqualToString: @"區間車"])
            cell.imageView.image = [UIImage imageNamed:@"local_train.png"];
        if ([[trainStyle objectAtIndex:indexPath.row-1]isEqualToString: @"自強"])
            cell.imageView.image = [UIImage imageNamed:@"speed_train.png"];
        if ([[trainStyle objectAtIndex:indexPath.row-1]isEqualToString: @"莒光"])
            cell.imageView.image = [UIImage imageNamed:@"gigoung_train.png"];
        cell.detailTextLabel.text = detailString;
        cell.detailTextLabel.textColor = [UIColor blueColor];
    }
    
    return cell;
}


/*-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.backgroundColor = [UIColor grayColor];
}*/
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

