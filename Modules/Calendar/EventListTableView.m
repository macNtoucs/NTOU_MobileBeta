#import "EventListTableView.h"
#import "CalendarSpeech.h"
#import "CalendarActivities.h"
#import "CalendarDetailViewController.h"
#import "MITUIConstants.h"
#import "MultiLineTableViewCell.h"

@interface MyTableViewCell : UITableViewCell

-(void) layoutSubviews;

@end

@implementation MyTableViewCell

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = self.detailTextLabel.frame;
    frame.size.width = 210;
    [self.detailTextLabel setFrame:frame];
}

@end


@implementation EventListTableView
@synthesize events, parentViewController, isSearchResults, searchSpan;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	if (self.events != nil) {
		return [self.events count];
	}
    return 0;
    
    //NSString *dateText = [CalendarDataManager dateStringForEventType:parentViewController.activeEventList forDate:parentViewController.startDate];
    //if([dateText isEqual:@"Dec 17, 2012"])
    /*if([dateText isEqual:@"Today"])
        return 10;
    return 0;*/}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return (isSearchResults) ? UNGROUPED_SECTION_HEADER_HEIGHT : 0;
}

/*- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	UIView *titleView = nil;
    NSString *titleString = nil;
	if (isSearchResults) {
		NSUInteger numResults = [self.events count];
		switch (numResults) {
			case 0:
                titleString = @"Nothing found";
				break;
			case 1:
                titleString = @"1 found";
				break;
			default:
                titleString = [NSString stringWithFormat:@"%d found", numResults];
				break;
		}
        
        if (searchSpan) {
            titleString = [NSString stringWithFormat:@"%@ in the next %@", titleString, searchSpan];
        }
        
        titleView = [UITableView ungroupedSectionHeaderWithTitle:titleString];
	}
    
    return titleView;
}*/
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 65.0;
    return height;
}

- (MyTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
	NSString *CellIdentifier = [NSString stringWithFormat:@"%d", indexPath.row];
	NSInteger randomTagNumberForLocationLabel = 1831;
    
    MultiLineTableViewCell *cell = (MultiLineTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[MultiLineTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    } else {
		UIView *extraView = [cell viewWithTag:randomTagNumberForLocationLabel];
		[extraView removeFromSuperview];
	}
	[cell applyStandardFonts];
    
	MITCalendarEvent *event = [self.events objectAtIndex:indexPath.row];

	//CGFloat maxWidth = self.frame.size.width - MULTILINE_ADJUSTMENT_ACCESSORY;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
	//CGSize textSize = [event.title sizeWithFont:cell.textLabel.font];
	//CGFloat textHeight = 10.0 + (textSize.width > maxWidth ? textSize.height * 2 : textSize.height);

    cell.textLabelNumberOfLines = 2;
    cell.textLabelLineBreakMode = UILineBreakModeTailTruncation;
    cell.textLabel.text = event.title;

	// show time only if date is shown; date plus time otherwise
	BOOL showTimeOnly = !isSearchResults && ([CalendarDataManager intervalForEventType:self.parentViewController.activeEventList fromDate:self.parentViewController.startDate forward:YES] == 86400.0);
    
    if (showTimeOnly) {
        cell.detailTextLabel.text = [event dateStringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle separator:@" "];
    } else {
        cell.detailTextLabel.text = [event dateStringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle separator:@" "];
    }
        
    if (event.shortloc) {
        // right align event location
        CGSize locationTextSize = [event.shortloc sizeWithFont:[UIFont fontWithName:STANDARD_FONT size:CELL_DETAIL_FONT_SIZE] forWidth:100.0 lineBreakMode:UILineBreakModeTailTruncation];
        CGFloat labelY = [self tableView:self heightForRowAtIndexPath:indexPath] - CELL_VERTICAL_PADDING - locationTextSize.height;
        CGRect locationFrame = CGRectMake(self.frame.size.width - locationTextSize.width - 20.0,
                                          labelY,
                                          locationTextSize.width,
                                          locationTextSize.height);
        
        UILabel *locationLabel = [[UILabel alloc] initWithFrame:locationFrame];
        locationLabel.lineBreakMode = UILineBreakModeTailTruncation;
        locationLabel.text = event.shortloc;
        locationLabel.textColor = cell.detailTextLabel.textColor;
        locationLabel.font = cell.detailTextLabel.font;
        locationLabel.tag = randomTagNumberForLocationLabel;
        locationLabel.highlightedTextColor = [UIColor whiteColor];
        
        [cell.contentView addSubview:locationLabel];
        [locationLabel release];
    }
	*/
    
    static NSString *CellIdentifier = @"Cell";
    
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16.5];
    
    if([[parentViewController.activeEventList listID] isEqual:@"Speech"])
    {
        cell.textLabel.text = [[events objectAtIndex:indexPath.row] title];
        cell.detailTextLabel.text = [[[[events objectAtIndex:indexPath.row] time] stringByAppendingString:@" "] stringByAppendingString:[[events objectAtIndex:indexPath.row] speaker]];
    }
    else
    {
        cell.textLabel.text = [[events objectAtIndex:indexPath.row] title];
        cell.detailTextLabel.text = [[events objectAtIndex:indexPath.row] period];
    }
    
    return cell;
}

/*- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //CGFloat *constraintWidth = [MultiLineTableViewCell cellWidthForTableStyle:self accessoryType:UITableViewCellAccessoryDisclosureIndicator];
    //if (*constraintWidth == 0) {
    
	MITCalendarEvent *event = [self.events objectAtIndex:indexPath.row];
    
    CGFloat cellHeight = [MultiLineTableViewCell cellHeightForTableView:self
                                                                   text:event.title
                                                             detailText:@"ONELINE"
                                                          accessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    CGFloat maxHeight = [MultiLineTableViewCell cellHeightForTableView:self
                                                                  text:@"TWO\nLINES"
                                                            detailText:@"ONELINE"
                                                         accessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return (cellHeight > maxHeight) ? maxHeight : cellHeight;
    //
	CGFloat height = CELL_TWO_LINE_HEIGHT;
    
	UIFont *font = [UIFont fontWithName:BOLD_FONT size:CELL_STANDARD_FONT_SIZE];
	CGFloat constraintWidth = self.frame.size.width - MULTILINE_ADJUSTMENT_ACCESSORY;

	MITCalendarEvent *event = [self.events objectAtIndex:indexPath.row];
	CGSize textSize = [event.title sizeWithFont:font];
	if (textSize.width > constraintWidth) {
		height += textSize.height + 2.0;
	}

	return height;
    //
}*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	CalendarDetailViewController *detailVC = [[CalendarDetailViewController alloc] initWithNibName:nil bundle:nil];//initWithStyle:UITableViewStylePlain];
	detailVC.events = self.events;
    
    if([[parentViewController.activeEventList listID] isEqual:@"Speech"])
    {
        CalendarSpeech * speechEvent = [events objectAtIndex:indexPath.row];
        detailVC.speechEvent = speechEvent;
        detailVC.numRows = 4;
    }
    
    else
    {
        CalendarActivities * activitiesEvent = [self.events objectAtIndex:indexPath.row];
        detailVC.activitiesEvent = activitiesEvent;
        detailVC.numRows = 5;
    }

	[self.parentViewController.navigationController pushViewController:detailVC animated:YES];
	[detailVC release];
}


- (void)dealloc {
    if (searchSpan) {
        [searchSpan release];
    }
    [events release];
    events = nil;
    [super dealloc];
}


@end

