//
//  KUO_RouteViewController_Bra2.m
//  MIT Mobile
//
//  Created by mini server on 12/11/17.
//
//

#import "KUO_RouteViewController_Bra2.h"
#import "UIKit+MITAdditions.h"
@interface KUO_RouteViewController_Bra2 (){
    NSIndexPath *tabcIndexPath;
}
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
        display = inbound;
        direct = FALSE;
    } else {
        display = outbound;
        direct = TRUE;
    }
    [self.tableView reloadData];
}

-(void)TimeViewControllerDirectChange
{
    [self changeDirectType];
    [self changeTabcTittle];
    tabc.data = [[display objectForKey:[[display allKeys] objectAtIndex:tabcIndexPath.section]] objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(tabcIndexPath.row*5, 5)]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView applyStandardColors];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"往返切換"
                                                                    style:UIBarButtonItemStyleBordered
                                                                   target:self
                                                                   action:@selector(changeDirectType)];
    [self.navigationItem setRightBarButtonItem:rightButton];
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

-(void)changeTabcTittle
{
    NSArray* Separated= [tabc.title componentsSeparatedByString:@"  →  "];
    tabc.title = [[[Separated objectAtIndex:1] stringByAppendingString:@"  →  "] stringByAppendingString:[Separated objectAtIndex:0]];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    tabc = [[KUO_TimeViewController alloc] init:[[display objectForKey:[[display allKeys] objectAtIndex:indexPath.section]] objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(indexPath.row*5, 5)]]];
    if (display==inbound) {
            tabc.title = [[[[display allKeys]objectAtIndex:indexPath.section] stringByAppendingString:@"  →  "] stringByAppendingString:cell.textLabel.text];
    } else {
            tabc.title = [[cell.textLabel.text stringByAppendingString:@"  →  "] stringByAppendingString:[[display allKeys]objectAtIndex:indexPath.section]];
    }
    tabc.delegate2 = self;
    tabcIndexPath = [indexPath retain];
    [self.navigationController pushViewController:tabc animated:YES];
    [tabc release];
}

@end
