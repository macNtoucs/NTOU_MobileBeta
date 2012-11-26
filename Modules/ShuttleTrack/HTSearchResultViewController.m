//
//  HTSearchResultViewController.m
//  MIT Mobile
//
//  Created by MacAir on 12/11/26.
//
//

#import "HTSearchResultViewController.h"

@interface HTSearchResultViewController ()

@end

@implementation HTSearchResultViewController

@synthesize  dataURL;
@synthesize StartAndTerminalstops;
@synthesize depatureTimes;
@synthesize arrivalTimes;
@synthesize startStation;
@synthesize depatureStation;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
       
        north_id = [NSMutableArray new];
        north_taipeiStation= [NSMutableArray new];
        north_benchiouStation= [NSMutableArray new];
        north_shinchewStation= [NSMutableArray new];
        north_touyounStation = [NSMutableArray new];
        north_taichungStation= [NSMutableArray new];
        north_chiaiStation= [NSMutableArray new];
        north_tainanStation= [NSMutableArray new];
        north_zhouyingStation= [NSMutableArray new];
        south_id= [NSMutableArray new];
        south_taipeiStation= [NSMutableArray new];
        south_benchiouStation= [NSMutableArray new];
         south_touyounStation = [NSMutableArray new];
        south_shinchewStation= [NSMutableArray new];
        south_taichungStation= [NSMutableArray new];
        south_chiaiStation= [NSMutableArray new];
        south_tainanStation= [NSMutableArray new];
        south_zhouyingStation= [NSMutableArray new];
        station = [[NSArray alloc]initWithObjects:@"台北",@"板橋",@"桃園",@"新竹",@"台中",@"嘉義",@"台南",@"左營", nil];
    }
    return self;
}


-(void) recieveURL{
    dataURL = [[NSURL alloc]init];
    dataURL = [self.dataSource HTStationInfoURL:self];
}
-(void) recieveStartAndDepature{
    startStation =[[NSString alloc]initWithString:[self.dataSource HTstartStationTitile:self]];
    depatureStation =[[NSString alloc]initWithString:[self.dataSource HTdepatureStationTitile:self]];
}
-(void)recieveData{
    [self recieveURL];
    if (![[dataURL absoluteString] isEqualToString:@""]){
        [self recieveStartAndDepature];
        downloadView = [DownloadingView new];
       [self fetchData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }
   
}


-(void)fetchData{
    
   
    NSError* error;
    NSData* data = [[NSString stringWithContentsOfURL:dataURL encoding:NSUTF8StringEncoding error:&error] dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple* parser = [[TFHpple alloc] initWithHTMLData:data];
    NSArray *tableData_td  = [parser searchWithXPathQuery:@"//body//table//tr//td//div//table//tr//td//div//table//tr//td"];
    int southTrainNumber = 0;
     
    for (int i = 10 ; ; ++i){
        NSString* input;
        TFHppleElement * attributeElement = [tableData_td objectAtIndex:i];
        NSArray * contextArr = [attributeElement children];
        if ([contextArr count])
            input = [[contextArr objectAtIndex:0]content];
        else input = @"";
        if ([input isEqualToString:@"車次"]) {
            south = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                     south_id,@"車次"
                     ,south_taipeiStation, @"台北"
                     ,south_benchiouStation,@"板橋"
                     ,south_touyounStation,@"桃園"
                     ,south_shinchewStation,@"新竹"
                     ,south_taichungStation,@"台中"
                     ,south_tainanStation,@"台南"
                     ,south_zhouyingStation,@"左營"
                     ,nil];
            southTrainNumber = i;
            break;
        }
        switch (i%10) {
            case 0:
                [south_id addObject:input];
                break;
            case 2:
                [south_taipeiStation addObject:input];
                break;
            case 3:
                [south_benchiouStation addObject:input];
                break;
            case 4:
                [south_touyounStation addObject:input];
                break;
            case 5:
                [south_shinchewStation addObject:input];
                break;
            case 6:
                [south_taichungStation addObject:input];
                break;
            case 7:
                [south_chiaiStation addObject:input];
                break;
            case 8:
                [south_tainanStation addObject:input];
                break;
            case 9:
                [south_zhouyingStation addObject:input];
                break;
            }
    
    
    }
    for (int i = southTrainNumber+11 ; i< [tableData_td count]; ++i){
        NSString* input;
        TFHppleElement * attributeElement = [tableData_td objectAtIndex:i];
        NSArray * contextArr = [attributeElement children];
        if ([contextArr count])
            input = [[contextArr objectAtIndex:0]content];
        else input = @"";
        switch (i%10) {
            case 0:
                [north_id addObject:input];
                break;
            case 2:
                [north_taipeiStation addObject:input];
                break;
            case 3:
                [north_benchiouStation addObject:input];
                break;
            case 4:
                [north_touyounStation addObject:input];
                break;
            case 5:
                [north_shinchewStation addObject:input];
                break;
            case 6:
                [north_taichungStation addObject:input];
                break;
            case 7:
                [north_chiaiStation addObject:input];
                break;
            case 8:
                [north_tainanStation addObject:input];
                break;
            case 9:
                [north_zhouyingStation addObject:input];
                break;
        }
        
        
    }
    north = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
             north_id,@"車次"
             ,north_taipeiStation, @"台北"
             ,north_benchiouStation,@"板橋"
             ,north_touyounStation,@"桃園"
             ,north_shinchewStation,@"新竹"
             ,north_taichungStation,@"台中"
             ,north_tainanStation,@"台南"
             ,north_zhouyingStation,@"左營"
             ,nil];
    
    direction = [[NSMutableDictionary alloc]initWithObjectsAndKeys:south,@"南下",north, @"北上",nil];
      
}
-(NSString *)determindir{ //return true 南下
    NSUInteger index_start = [station indexOfObject:startStation];
    NSUInteger index_depature = [station indexOfObject:depatureStation];
    if(NSNotFound == index_depature) {
        NSLog(@"not found");
    }
    if ((int)index_start -(int)index_depature<0)
        return @"南下";
    else
        return @"北上";
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
-(void)determinDisplay{
    shouldDisplay_to = [NSMutableArray new];
    shouldDisplay_from= [NSMutableArray new];
     shouldDisplay_ID= [NSMutableArray new];
    for (id obj in [[direction objectForKey:[self determindir] ]objectForKey:startStation]){
        if (![obj isEqualToString:@""]) [shouldDisplay_from addObject:obj];
    }
    for (id obj in [[direction objectForKey:[self determindir] ]objectForKey:depatureStation]){
        if (![obj isEqualToString:@""]) [shouldDisplay_to addObject:obj];
    }
    for (id obj in [[direction objectForKey:[self determindir] ]objectForKey:@"車次"]){
        if (![obj isEqualToString:@""]) [shouldDisplay_ID addObject:obj];
    }

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
    
    [self determinDisplay];
    NSLog(@"%d,%d,%d",[shouldDisplay_ID count],[shouldDisplay_to count],[shouldDisplay_from count]);
    return MIN([shouldDisplay_to count], [shouldDisplay_from count]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d%d",indexPath.section,indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    if (indexPath.row == 0 ) {
        cell.textLabel.text = [NSString stringWithFormat:@"車次                            %@           %@",startStation,depatureStation];
        cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        cell.detailTextLabel.textColor = [UIColor brownColor];
        cell.textLabel.textColor = [UIColor brownColor];
    }
    else{
        NSString * detailString = [NSString stringWithFormat:@"%@         %@", [shouldDisplay_from objectAtIndex:indexPath.row-1],[shouldDisplay_to objectAtIndex:indexPath.row-1]] ;
        cell.detailTextLabel.text = detailString;
        cell.textLabel.text=[NSString stringWithFormat:@"%@", [shouldDisplay_ID objectAtIndex:indexPath.row-1]] ;
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
