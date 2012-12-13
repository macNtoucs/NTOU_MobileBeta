#import <UIKit/UIKit.h>
#import "StoryXMLParser.h"
#import "MITSearchDisplayController.h"
#import "NavScrollerView.h"

typedef enum {
    NewsCategoryIdTopNews = 0,
    NewsCategoryIdEngineering = 1,
    NewsCategoryIdScience = 2,
    NewsCategoryIdManagement = 3,
    NewsCategoryIdArchitecture = 5,
    NewsCategoryIdHumanities = 6,
    NewsCategoryIdCampus = 99
} NewsCategoryId;

@class NewsStory;

@interface StoryListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, MITSearchDisplayDelegate, StoryXMLParserDelegate, NavScrollerDelegate> {
	UITableView *storyTable;
    NSArray *_categories;
    NSInteger activeCategoryId;
	StoryXMLParser *xmlParser;
    
    NSArray *navButtons;
    
	// Nav Scroll View
    NavScrollerView *navScrollView;
	//UIScrollView *navScrollView;
	//UIButton *leftScrollButton;
	//UIButton *rightScrollButton;
    
	// Search bits
	NSString *searchQuery;
	NSArray *searchResults;
	NSInteger searchTotalAvailableResults;
	UISearchBar *theSearchBar;
    MITSearchDisplayController *searchController;
	
	BOOL hasBookmarks;
	BOOL showingBookmarks;
	
    UIView *activityView;
    
    NSIndexPath *tempTableSelection;
    BOOL lastRequestSucceeded;
    
    NSArray *stories;
    NSArray *storiesDate;
    NSArray *storiesContent;
}

@property (nonatomic, retain) NSArray *stories;
@property (nonatomic, retain) NSArray *storiesDate;
@property (nonatomic, retain) NSArray *storiesContent;
@property (nonatomic, retain) NSString *searchQuery;
@property (nonatomic, retain) NSArray *searchResults;
@property (nonatomic, retain) NSArray *categories;
@property (nonatomic, assign) NSInteger activeCategoryId;
@property (nonatomic, retain) StoryXMLParser *xmlParser;

// 新增
- (void)displayContentCampusFocus;
- (void)displayContentSchoolBulletin;
- (void)displayContentExternalMessage;

- (void)pruneStories;
- (void)switchToCategory:(NewsCategoryId)category;
- (void)loadFromCache;
- (void)loadFromServer:(BOOL)loadMore;
- (void)loadSearchResultsFromCache;
- (void)loadSearchResultsFromServer:(BOOL)loadMore forQuery:(NSString *)query;
- (BOOL)canSelectPreviousStory;
- (BOOL)canSelectNextStory;
- (NewsStory *)selectPreviousStory;
- (NewsStory *)selectNextStory;
@end
