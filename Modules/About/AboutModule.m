#import "AboutModule.h"
#import "AboutTableViewController.h"

#import "MITModule+Protected.h"

@implementation AboutModule

- (id) init {
    self = [super init];
    if (self != nil) {
        self.tag = AboutTag;
        self.shortName = @"關於";
        self.longName = @"About";
        self.iconName = @"about";
    }
    return self;
}

- (void)loadModuleHomeController
{
    self.moduleHomeController = [[[AboutTableViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
}

@end
