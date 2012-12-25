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
@synthesize dataSource;
@synthesize selectedDate;
@synthesize selectedHTTime;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        station = [[NSArray alloc]initWithObjects:@"台北",@"板橋",@"桃園",@"新竹",@"台中",@"嘉義",@"台南",@"左營", nil];
        isFirstTimeLoad = true;
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
-(void)initialDisplay{
    trainID = [NSMutableArray new];
    depatureTime= [NSMutableArray new];
    startTime= [NSMutableArray new];
    
    NSData * BIN_resultString = [NSData new];
    BIN_resultString = [queryResult dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple* parser = [[TFHpple alloc] initWithHTMLData:BIN_resultString];
    
    NSArray *tableData_td  = [parser searchWithXPathQuery:@"//body//table//tr//td//table//tr//td//table//tr//td//table//tr//td//table//tr//td//span"];
    for (int i=0 ; i< [tableData_td count] ; ++i){
       
            TFHppleElement * attributeElement = [tableData_td objectAtIndex:i];
            NSString * context = [[[attributeElement children]objectAtIndex:0]content];
           // NSLog(@"context => %@",context);
            [trainID addObject:context];
    }
    tableData_td  = [parser searchWithXPathQuery:@"//body//table//tr//td//table//tr//td//table//tr//td//table//tr//td//table//tr//td"];
    bool isStartTime=true;
    for (int i=[trainID count]+2; i<5*[trainID count]; ){
        TFHppleElement * attributeElement = [tableData_td objectAtIndex:i];
        NSString * context = [[[attributeElement children]objectAtIndex:0]content];
        context = [context stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSLog(@"context => %@",context);
        if (isStartTime){
             [startTime addObject:context];
               isStartTime = false;
            ++i;
            }
        else {
            [depatureTime addObject:context];
            isStartTime=true;
            i=i+3;
        }
        
    }
   /*[ trainID  retain];
    [depatureTime retain];
    [startTime retain];*/
    [self.tableView reloadData];
    [BIN_resultString release];
    
}

-(void)recieveData{
    [self recieveURL];
    if (![[dataURL absoluteString] isEqualToString:@""] && !isFirstTimeLoad){
        [self recieveStartAndDepature];
        [self fetchData];
        [self initialDisplay];
    }
    isFirstTimeLoad = false;
}


-(void)fetchData{
    //from=1&to=5&sDate=2012%2F12%2F18&TimeTable=13%3A30&FromOrDest=From&x=50&y=14
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:dataURL];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"http://www.thsrc.com.tw/TC/ticket/tic_time_result.asp" forHTTPHeaderField:@"Referer"];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    [request addValue:@"zh-TW,zh;q=0.8,en-US;q=0.6,en;q=0.4" forHTTPHeaderField:@"Accept-Language"];
    [request addValue:@"Big5,utf-8;q=0.7,*;q=0.3" forHTTPHeaderField:@"Accept-Charset"];
    [request addValue:@"max-age=0" forHTTPHeaderField:@"Cache-Control"];
    [request addValue:@"http://www.thsrc.com.tw" forHTTPHeaderField:@"Origin"];
    
    
    NSString * postString = [[NSString alloc]init];
    postString=[postString stringByAppendingFormat:@"from=%u",[station indexOfObject:startStation]+1];
    postString=[postString stringByAppendingFormat:@"&to=%u",[station indexOfObject:depatureStation]+1];
    postString=[postString stringByAppendingString:@"&sDate="];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    postString=[postString stringByAppendingString:[NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:self.selectedDate]]];
    postString= [postString stringByAppendingString:@"%2F"];
    
    [dateFormatter setDateFormat:@"M"];
    postString=[postString stringByAppendingString:[NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:self.selectedDate]]];
    postString= [postString stringByAppendingString:@"%2F"];
    
    [dateFormatter setDateFormat:@"d"];
    postString=[postString stringByAppendingString:[NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:self.selectedDate]]];

    
    NSArray *dateData = [selectedHTTime componentsSeparatedByString:@":"];
    postString=[postString stringByAppendingString:@"&TimeTable="];
    postString=[postString stringByAppendingString:[NSString stringWithString:[dateData objectAtIndex:0] ]];
    postString=[postString stringByAppendingString:@"%3A"];
    postString=[postString stringByAppendingString:[NSString stringWithString:[dateData objectAtIndex:1] ]];
    
    
    postString=[postString stringByAppendingString:@"&FromOrDest=From&x=50&y=14"];
    
    
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    NSHTTPURLResponse *urlResponse = nil;
     NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request
                                                 returningResponse:&urlResponse
                                                             error:&error
                            ];
    queryResult = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    
    //NSLog(@"Response ==> %@", queryResult);
    
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
   
    return [trainID count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d%d",indexPath.section,indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@    %@   %@",
                           [trainID objectAtIndex:indexPath.row],
                           [startTime objectAtIndex:indexPath.row],
                           [depatureTime objectAtIndex:indexPath.row]
                           ];
    
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
