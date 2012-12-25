#import <UIKit/UIKit.h>
#import "MITMobileWebAPI.h"
#import "ShareDetailViewController.h"
#import <EventKitUI/EventKitUI.h>

//@class MITCalendarEvent;
@class CalendarSpeech;
@class CalendarActivities;

/*typedef enum {
	CalendarDetailRowTypeTime,
	CalendarDetailRowTypeLocation,
	CalendarDetailRowTypePhone,
	CalendarDetailRowTypeURL,
	CalendarDetailRowTypeDescription,
	CalendarDetailRowTypeCategories
} CalendarDetailRowType;*/

@interface CalendarDetailViewController : ShareDetailViewController <
UITableViewDelegate, UITableViewDataSource, JSONLoadedDelegate, ShareItemDelegate, 
UIWebViewDelegate, EKEventEditViewDelegate> {
	
    MITMobileWebAPI *apiRequest;
    BOOL isLoading;
    
	//MITCalendarEvent *event;
    CalendarSpeech * speechEvent;
    CalendarActivities * activitiesEvent;
	//CalendarDetailRowType* rowTypes;
	NSInteger numRows;
	
	UITableView *_tableView;
	UIButton *shareButton;
    UISegmentedControl *eventPager;
	
    CGFloat descriptionHeight;
	NSString *descriptionString;
	
    CGFloat categoriesHeight;
	NSString *categoriesString;

	// list of events to scroll through for previous/next buttons
	NSArray *events;
}
// @property (nonatomic, retain) MITCalendarEvent *event;
@property (nonatomic, retain) CalendarSpeech * speechEvent;
@property (nonatomic, retain) CalendarActivities * activitiesEvent;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSArray *events;
@property (nonatomic) NSInteger numRows;

- (void)reloadEvent;
- (void)setupHeader;
- (void)setupShareButton;
- (void)requestEventDetails;
- (void)showNextEvent:(id)sender;

- (NSString *)htmlStringFromString:(NSString *)source;

@end

