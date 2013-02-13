#import "PeopleModule.h"
#import "MITModuleURL.h"


#import "MITModule+Protected.h"


@interface PeopleModule ()
@end

@implementation PeopleModule


- (id)init
{
    self = [super init];
    if (self) {
        self.tag = DirectoryTag;
        self.shortName = @"生活圈";
        self.longName = @"People Directory";
        self.iconName = @"people";
    }
    return self;
}

- (void)loadModuleHomeController
{
    NTOU_LifeViewController *controller = [[[NTOU_LifeViewController alloc] init] autorelease];
    self.moduleHomeController = controller;
}



- (void)dealloc
{
    [NTOU_LifeViewController release];
	[super dealloc];
}


@end

