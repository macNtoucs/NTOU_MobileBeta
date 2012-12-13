#import "MIT_MobileAppDelegate.h"
#import "StoryListViewController.h"
#import "StoryDetailViewController.h"
#import "StoryThumbnailView.h"
#import "NewsStory.h"
#import "CoreDataManager.h"
#import "UIKit+MITAdditions.h"
#import "MITUIConstants.h"

#define SCROLL_TAB_HORIZONTAL_PADDING 5.0
#define SCROLL_TAB_HORIZONTAL_MARGIN  5.0

#define THUMBNAIL_WIDTH 55.0
#define ACCESSORY_WIDTH_PLUS_PADDING 18.0
#define STORY_TEXT_PADDING_TOP 3.0 // with 15pt titles, makes for 8px of actual whitespace
#define STORY_TEXT_PADDING_BOTTOM 7.0 // from baseline of 12pt font, is roughly 5px
#define STORY_TEXT_PADDING_LEFT 7.0
#define STORY_TEXT_PADDING_RIGHT 7.0
#define STORY_TEXT_WIDTH (320.0 - STORY_TEXT_PADDING_LEFT - STORY_TEXT_PADDING_RIGHT - THUMBNAIL_WIDTH - ACCESSORY_WIDTH_PLUS_PADDING) // 8px horizontal padding
#define STORY_TEXT_HEIGHT (THUMBNAIL_WIDTH - STORY_TEXT_PADDING_TOP - STORY_TEXT_PADDING_BOTTOM) // 8px vertical padding (bottom is less because descenders on dekLabel go below baseline)
#define STORY_TITLE_FONT_SIZE 15.0
#define STORY_DEK_FONT_SIZE 12.0

#define SEARCH_BUTTON_TAG 7947
#define BOOKMARK_BUTTON_TAG 7948

@interface StoryListViewController (Private)

- (void)setupNavScroller;
- (void)setupNavScrollButtons;
- (void)buttonPressed:(id)sender;

- (void)setupActivityIndicator;
- (void)setStatusText:(NSString *)text;
- (void)setLastUpdated:(NSDate *)date;
- (void)setProgress:(CGFloat)value;

- (void)showSearchBar;
- (void)hideSearchBar;
- (void)releaseSearchBar;

- (void)pruneStories:(BOOL)asyncPrune;

@end

@implementation StoryListViewController

@synthesize stories = _stories;
@synthesize storiesDate;
@synthesize storiesContent;
@synthesize searchResults;
@synthesize searchQuery;
@synthesize categories = _categories;
@synthesize activeCategoryId;
@synthesize xmlParser;

NSString *const NewsCategoryTopNews = @"校園焦點";
NSString *const NewsCategoryCampus = @"學校公告";
NSString *const NewsCategoryEngineering = @"校外訊息";
NSString *const NewsCategoryScience = @"Science";
NSString *const NewsCategoryManagement = @"Management";
NSString *const NewsCategoryArchitecture = @"Architecture";
NSString *const NewsCategoryHumanities = @"Humanities";

// 新增
- (void) displayContentCampusFocus
{
    self.stories = [[NSArray alloc] initWithObjects:@"第15屆東亞鰻魚資源協議會28日在海大舉行", @"海大「罐蓋愛」溫馨傳情意「Love in can」for you．You can fall in love", @"海大、長庚合作癌症治療研究-中草藥助化療療效 減緩副作用[吉隆新聞]", @"秋收滿藏 海大通識教育展成果", @"海大、長庚攜手合作癌症治療研究中草藥配方有助化療療效及減緩副作用", @"海大與救國團策略聯盟共享教育資源", @"海大期中考溫馨餐點情免費送宵夜", @"推廣海洋文化－海大行政會議安排海洋文學講座", @"海大舉辦研討會關心海洋教育與文化", @"全球第一隻粉紅螢光神仙魚漂「亮」登場海大與芝林公司產學合作開發新品種觀賞魚", nil];
    self.storiesDate = [[NSArray alloc] initWithObjects:@"101/11/28", @"101/11/22", @"101/11/20", @"101/11/19", @"101/11/16", @"101/11/15", @"101/11/14", @"101/11/08", @"101/11/07", @"101/11/07", nil];
    self.storiesContent = [[NSArray alloc] initWithObjects:@"http://blog.ntou.edu.tw/oceannews/2012/11/1528.html", @"http://blog.ntou.edu.tw/oceannews/2012/11/love_in_canfor_youyou_can_fall.html", @"http://blog.ntou.edu.tw/oceannews/2012/11/post_443.html", @"http://blog.ntou.edu.tw/oceannews/2012/11/post_442.html", @"http://blog.ntou.edu.tw/oceannews/2012/11/post_441.html", @"http://blog.ntou.edu.tw/oceannews/2012/11/post_440.html", @"http://blog.ntou.edu.tw/oceannews/2012/11/post_438.html", @"http://blog.ntou.edu.tw/oceannews/2012/11/post_439.html", @"http://blog.ntou.edu.tw/oceannews/2012/11/post_437.html", @"http://blog.ntou.edu.tw/oceannews/2012/11/post_436.html", nil];
}

- (void)displayContentSchoolBulletin
{
    self.stories = [[NSArray alloc] initWithObjects:@"《在生命的海洋‧相信》課程於12月06日(四)邀請張曉風作家、立委演講：「文學中的土地與大自然」，歡迎踴躍參加。", @"「熱血沸騰」捐血活動~~發揮愛心讓無數的生命延續下去!!", @"產業碩士專班102年度秋季班申請作業須知。", @"教育部來函轉知機關擁有機車之所屬員工，請其確實依據空氣污染防制法之規定，依照行照發照前後及當月份之期限，實施機車排氣定期檢驗，以免受罰，請查照。 ", @"教學助教研習營來囉，歡迎本校同學踴躍報名參加！(教學助教時數)", @"101年資訊月「政府暨公眾服務成果─教育部主題館」展示活動全臺巡迴展出，請師生前往參觀。", @"千叮萬嚀要知道，勿再受騙上當", @"修正「國立臺灣海洋大學體育館管理辦法施行細則」。附修正「國立臺灣海洋大學體育館管理辦法施行細則」。", @"修正「國立臺灣海洋大學體育館管理辦法」。附修正「國立臺灣海洋大學體育館管理辦法」。", @"圖資處提供windows　8下載", nil];
    self.storiesDate = [[NSArray alloc] initWithObjects:@"[通識教育中心] - 101/12/03", @"[衛生保健組] - 101/12/03", @"[註冊課務組] - 101/11/30", @"[環安組] - 101/11/30", @"[教學中心] - 101/11/30", @"[圖書暨資訊處] - 101/11/30", @"[軍訓室] - 101/11/29", @"[體育活動組] - 101/11/29", @"[體育活動組] - 101/11/29", @"[教學支援組] - 101/11/29", nil];
    
    NSArray * content1 = [[NSArray alloc] initWithObjects:@"101/12/03", @"陳雪燕", @"分機2057", @"《在生命的海洋‧相信》課程於12月06日(四)邀請張曉風作家、立委演講：「文學中的土地與大自然」，歡迎踴躍參加。", @"《教育部101學?886;@001;全校性閱?834;書寫課程推動與革新計畫~在生命的海洋‧　相信》\n\n講題：文學中的土地與大自然\n\n時間：101年12月06日(四)　　10:20~12:05 \n\n地點：行政大樓第一演講廳\n\n演講人：張曉風作家、立委\n\n\n~~歡迎踴躍參加~~", @"文學中的土地與大自然.pdf", nil];
    NSArray * content2 = [[NSArray alloc] initWithObjects:@"101/12/03", @"邱子芯", @"分機1073", @"「熱血沸騰」捐血活動~~發揮愛心讓無數的生命延續下去!!", @"★時間　:　12月4日（二）至12月7日（五）10:30~17:00\n★對象：17~65歲身體健康者之全校教職員生及社區民眾\n★地點　:　本校展示廳旁\n★請攜帶具身分證統一編號、照片、生日之有效證件正本\n\n★12/6(四)及12/7(五)現場另有「海鷗救護社」擺攤---\n進行免費血壓、體重、體脂肪測量及BMI計算，並發放健康紀錄卡!!\n\n★常見暫時不能捐血之情況\n(1)　感冒正在治療中或三天內進行拔牙\n\n(2)　接受大手術未滿1年或1年內曾接受輸血\n(3)　曾在7天內服用含Aspirin類藥物或服用其他藥物 \n(4)　懷孕中或產後(含流產)6個月以內\n(5)　B型肝炎、C型肝炎病患或帶原者\n(6)　一年內刺青者(包括紋身、紋眉)\n(7)　一年內曾出國到瘧疾流行區\n\n學務處　　衛生保健組　　誠摯邀請您的參與!! ", @"無", nil];
    NSArray * content3 = [[NSArray alloc] initWithObjects:@"101/12/03", @"何美青", @"分機1019", @"產業碩士專班102年度秋季班申請作業須知。", @"一、依99年8月30日教育部台高（一）字第0990140379C號令修正之「大學校院辦理產業碩士專班計畫審核要點」。\n二、欲辦理者，相關計畫參詳可洽詢本組承辦人。另敬請於10年12月18日前檢具應繳交文件至本組，由本組彙整後備文函送教育部及專案辦公室。\n三、辦理領域及開課相關要項請詳閱附檔。", @"102秋季班申請作業需知_011129.doc", nil];
    NSArray * content4 = [[NSArray alloc] initWithObjects:@"101/11/30", @"林永富", @"24622192 分機1313", @"教育部來函轉知機關擁有機車之所屬員工，請其確實依據空氣污染防制法之規定，依照行照發照前後及當月份之期限，實施機車排氣定期檢驗，以免受罰，請查照。 ", @"一、依據行政院環境保護署101年11月27日環署空字第1010106656號函辦理。\n二、依「空氣污染防制法」第40條規定，使用中之機車應實施排放氣污染物定期檢驗，檢驗不符合第34條排放標準之車輛，應於1個月內修復並申請複驗。另出廠滿5年以上之機車，每年應於行車執照之原發照月份前後1個月檢驗期限內，實施1次排氣定期檢驗；如未依規定定檢者，將依空氣污染防制法之規定，處2,000元之罰鍰。\n三、若持有出廠滿5年之機車，應依空氣污染防治法相關規定，於年度檢驗期限內實施排氣定期檢驗，以免受罰。\n四、該署移動污染源網頁(網址:http://www.motorim.org.tw/)中，置有全國定檢站地址查詢，請同仁多加利用，以查詢鄰近之定檢站，儘速完成所屬車輛之排氣定期檢驗。", @"環保署公文.pdf", nil];
    NSArray * content5 = [[NSArray alloc] initWithObjects:@"101/11/30", @"施硯傑", @"分機1094", @"教學助教研習營來囉，歡迎本校同學踴躍報名參加！(教學助教時數)", @"各位同學大家好：\n\n照過來照過來，本學期的教學助教研習營來囉！\n\n(一)演講資訊\n(1)日期：101年12月11日(二)　10：00-12：00\n(2)地點：生命科學院109全興國際廳\n(3)講題：垃圾堆裡淘寶的物理教授\n(4)講者：東吳大學　陳秋民　老師\n\n(二)報名資訊\n請欲參加之同學於即日起至非正式課程管理平台(http://ability.ntou.edu.tw/)進行報名，報名流程如下：點選「首頁研習活動名稱」>點選「我要報名」>登入「系統登入」>再次點選「我要報名」>出現「活動報名成功」即完成本次活動報名。\n\n線上報名並全程參與者發予研習時數2小時之證明(每人每學期需集滿6小時)。名額有限，額滿為止。一經線上報名，請務必出席！出席時請記得攜帶學生證唷！ \n\n本次活動亦可認證北一區區域教學資源中心之通識護照時數，護照索取、認證場次及相關規範請見：http://ctl.ntou.edu.tw/user/NTTLRCbulletin.php?bulletinid=38 ，大獎等著你唷！ \n\n請同學告訴同學，一起揪團來參加！ \n\n教務處教學中心敬啟 ", @"無", nil];
    NSArray * content6 = [[NSArray alloc] initWithObjects:@"101/11/30", @"吳淑錦", @"24622192 分機1176", @"101年資訊月「政府暨公眾服務成果─教育部主題館」展示活動全臺巡迴展出，請師生前往參觀。", @"活動展示期間如下：\n臺北：101年12月1日至101年12月9日(臺北世貿一館)\n\n資訊月網站：http://www.itmonth.org.tw ", @"無", nil];
    NSArray * content7 = [[NSArray alloc] initWithObjects:@"101/11/30", @"金臺灣", @"分機1052", @"千叮萬嚀要知道，勿再受騙上當", @"無", @"校安通報第101027號-千叮萬嚀要知道，勿再受騙上當.ppt", nil];
    NSArray * content8 = [[NSArray alloc] initWithObjects:@"101/11/30", @"吳亮頤", @"分機2214", @"修正「國立臺灣海洋大學體育館管理辦法施行細則」。附修正「國立臺灣海洋大學體育館管理辦法施行細則」。", @"修正「國立臺灣海洋大學體育館管理辦法施行細則」。附修正「國立臺灣海洋大學體育館管理辦法施行細則」。", @"國立臺灣海洋大學體育館管理辦法施行細則_1108.docx", nil];
    NSArray * content9 = [[NSArray alloc] initWithObjects:@"101/11/30", @"吳亮頤", @"分機2214", @"修正「國立臺灣海洋大學體育館管理辦法」。附修正「國立臺灣海洋大學體育館管理辦法」。", @"修正「國立臺灣海洋大學體育館管理辦法」。附修正「國立臺灣海洋大學體育館管理辦法」。", @"國立臺灣海洋大學體育館管理辦法_1108.docx", nil];
    NSArray * content10 = [[NSArray alloc] initWithObjects:@"101/11/29", @"林宗陞", @"分機2133", @"圖資處提供windows　8下載", @"圖資處已將Windows　8作業系統置於全校授權軟體網站上，敬請全校師生下載使用。\n\n注意事項：\n一、認證方面：\n1.windows　8的認證方式與windows　7認證方式相同，可以使用windows　7的認證檔做認證。\n2.目前windows　8認證，尚無法於校外做認證，敬請師生於校內網路進行認證。\n\n二、下載方面：\n1.若使用IE　10瀏覽器登錄「全校授權軟體」下載相關軟體時，則需設定為「相容模式」，否則將無法下載軟體。 \n\n圖資處公告", @"無", nil];
    
    self.storiesContent = [[NSArray alloc] initWithObjects:content1, content2, content3, content4, content5, content6, content7, content8, content9, content10, nil];
}

- (void)displayContentExternalMessage
{
    self.stories = [[NSArray alloc] initWithObjects:@"輔仁大學「鶼鰈琴聲─史坦威藝術家雙鋼琴之夜」與「鶼鰈琴聲─專題演講暨鋼琴大師班」，歡迎踴躍參加。", @"國立歷史博物館「米開朗基羅：文藝復興巨匠再現」歡迎踴躍參加。", @"轉發活動訊息:大同大學辦理「101年度大學校院創新創業紮根計畫-大同大學創業研究班」", @"國立科學工藝博物館舉辦「跳躍奇航～立體書的異想世界特展」，歡迎本校教職員師生踴躍參與。", @"傳染病防治研究及教育中心辦理「102年度研究生及大專生人才培育計畫」，歡迎本校師生踴躍申請。", @"屏東教育大學音樂學系66週年校慶音樂季，歡迎參加", @"國立科學工藝博物館與秋雨文化公司合作辦理「歡樂蛋糕城~工藝蛋糕展」，展期自101年12月22日起至102年4月14日止，歡迎本校師生踴躍參觀。", @"臺北藝術大學2012「現代世界設計潮流」研討會", @"臺北市政府文化局「第15屆臺北文化獎推廣活動」唐文華京夜講堂", @"有關政治大學「楚戈紀念畫展開幕活動暨當代藝術發展研討會」訊息公告", nil];
    self.storiesDate = [[NSArray alloc] initWithObjects:@"[藝文中心] - 101/11/30", @"[藝文中心] - 101/11/30", @"[產學技轉中心] - 101/11/28", @"[教學中心] - 101/11/27", @"[教學中心] - 101/11/27", @"[藝文中心] - 101/11/27", @"[教學中心] - 101/11/27", @"[藝文中心] - 101/11/26", @"[藝文中心] - 101/11/26", @"[藝文中心] - 101/11/23", nil];
    
    NSArray * content1 = [[NSArray alloc] initWithObjects:@"101/11/30", @"林令華", @"24622192 分機2130", @"輔仁大學「鶼鰈琴聲─史坦威藝術家雙鋼琴之夜」與「鶼鰈琴聲─專題演講暨鋼琴大師班」，歡迎踴躍參加。", @"輔仁大學音樂學系將於本〈101〉年12月5日〈三〉假台北國家演奏廳、12月11日〈二〉假嘉義大學民雄校區大學館演講廳舉辦「鶼鰈琴聲─史坦威藝術家雙鋼琴之夜」；12月6日〈四〉、7日〈五〉、8日〈六〉於該校藝術學院懷仁廳，12月12日〈三〉於嘉義大學演講廳舉辦「鶼鰈琴聲-專題演講暨鋼琴大師班」。\n\n報名參加之教師，同意核予研習時數每場次2小時，至多14小時。", @"無", nil];
    NSArray * content2 = [[NSArray alloc] initWithObjects:@"101/11/30", @"林令華", @"24622192 分機2130", @"國立歷史博物館「米開朗基羅：文藝復興巨匠再現」歡迎踴躍參加。", @"國立歷史博物館與旺旺中時媒體集團時藝多媒體共同主辦「米開朗基羅：文藝復興巨匠再現」\n\n(一)展覽時間：2013.1.26~2013.5.12。09:00-18:00(除夕休館)\n(二)展覽地點：國立歷史博物館一樓展廳。\n(三)展覽內容：展覽規劃分為「不為人知的米開朗基羅」、「藝術的米開朗基羅」、「建築與文學的米開朗基羅」、「文藝復興『王者之爭』」等四個主題。\n\n展覽相關聯絡人：時藝多媒體活動組黃松萍先生（02）2311-5200（代表號）/傳真：（02）2311-5296。", @"無", nil];
    NSArray * content3 = [[NSArray alloc] initWithObjects:@"101/11/28", @"戴嘉儀", @"分機2296", @"轉發活動訊息:大同大學辦理「101年度大學校院創新創業紮根計畫-大同大學創業研究班」", @"轉發活動訊息:\n【活動公告】歡迎參加:　101年度大學校院創新創業紮根計畫-大同大學創業研究班\n一、指導單位：教育部\n二、主辦單位：大同大學\n三、執行單位：大同大學研究發展處創新育成中心\n四、上課地點：大同大學創新育成中心701室(台北市中山北路3段22號北設工大樓7樓)\n五、上課對象：全國大專院校師生\n六、課程日期：101年12月06日~102年05月31日，合計72小時\n七、課程收費：免費\n八、招生人數：每單元課程　20　名 \n九、報名網址：http://iic.ttu.edu.tw/files/87-1048-70.php\n十、諮詢專線：(02)2592-5252分機3619曾小姐　", @"101年度大學校院創新創業紮根計畫大同大學創業研究班11.28.pdf", nil];
    NSArray * content4 = [[NSArray alloc] initWithObjects:@"101/11/27", @"徐培慈", @"分機1097", @"國立科學工藝博物館舉辦「跳躍奇航～立體書的異想世界特展」，歡迎本校教職員師生踴躍參與。", @"一、國立科學工藝博物館為提倡國人精神生活與藝術人文之美，促進了解設計創作發展之歷史與藝術賞析，以達美學教育融入學校教學之目的，並使學校師生融合休閒娛樂與人文藝術，特與聯合報系共同引進立體書收藏家珍藏萃品特展，以達寓教於樂的目的，內容精采豐富。\n\n二、「跳躍奇航～立體書的異想世界」特展相關資料如下：\n\n(一)展覽時間：101年12月13日(四)～102年4月7日(日)，09:00-17:00（每逢星期一、除夕、年初一固定休館，星期一為國定例假日或補假日，照常開放。\n\n(二)展覽地點：高雄國立科學工藝博物館　B1F宇宙之星廣場。\n\n(三)展覽介紹：立體書不只是書！而是一個包羅萬象的異想世界！立體書（pop-upbook）是文學和藝術的結晶，擁有七百多年的歷史，更累積了令人嘆為觀止的作品。從立體書創作形式、豐富多元的內容，啟動觀賞者無限廣大的想像力。\n\n(四)展覽內容包含：\n１、立體書的歷史沿革。\n２、匯集古今中外150件經典作品，包含國內罕見的娃娃屋書、劇場書，以及展開後長達一百二十一公分的太空梭立體書、暴龍立體書等。\n３、立體書製作方式影片播放。 \n\n(五)票價：\n１、現場票價：全票200元、學生票180元(大專院校(含)以下學生憑證進場)。 \n２、免費資格：115cm以下兒童免費(需家長持票陪同)、身障者憑證及一名陪同者。 \n３、學校優惠預購票，不分大人、小孩皆為150元，平日、假日均可使用。 \n\n(六)團體導覽：學校團體可於周二至周五預約導覽服務，安排導覽老師導覽(為顧及導覽品質，團體導覽一律使用母子導覽機系統，每人需租借導覽子機20元)。 \n\n三、本案聯絡人：活動推廣部　　優惠預購票服務專線:（07）384-9128　傳真：（07）384-9166　陳小姐", @"無", nil];
    NSArray * content5 = [[NSArray alloc] initWithObjects:@"101/11/27", @"徐培慈", @"分機1097", @"傳染病防治研究及教育中心辦理「102年度研究生及大專生人才培育計畫」，歡迎本校師生踴躍申請。", @"一、依據行政院衛生署與國立臺灣大學簽訂之「傳染病防治研究及教育合作協議」，鼓勵公私立大專院校學生投入傳染病領域碩博士論文或專題研究計畫，以提升我國傳染病防治專業水準，加速人才培養。\n\n二、研究所與碩博士論文或大學部、專科學生及研究生自發性構想題目均可申請，惟研究題目均須與傳染病相關。\n\n三、每一計畫補助以新臺幣5萬元為上限。\n\n四、詳細申請辦法請於http://ntuidrec.ntu.edu.tw網站查詢。\n\n 五、聯絡人及連絡電話：陳婉甄、康嫚珊，02-33668260", @"無", nil];
    NSArray * content6 = [[NSArray alloc] initWithObjects:@"101/11/27", @"林令華", @"24622192 分機2130", @"屏東教育大學音樂學系66週年校慶音樂季，歡迎參加", @"系列活動列表請見http://music.npue.edu.tw/front/bin/ptdetail.phtml?Part=12110017", @"無", nil];
    NSArray * content7 = [[NSArray alloc] initWithObjects:@"101/11/27", @"徐培慈", @"分機1097", @"國立科學工藝博物館與秋雨文化公司合作辦理「歡樂蛋糕城~工藝蛋糕展」，展期自101年12月22日起至102年4月14日止，歡迎本校師生踴躍參觀。", @"一、國立科學工藝博物館設有「食品工業常設展示廳」，長期展出我國吃的文化以及食品科技的演進。為充實「自然與科技」及「藝術與人文」領域的多元學習與認知，國立科學工藝博物館與秋雨文化公司共同籌辦本展，引進食品工藝師們精心打造的蛋糕夢幻奇境。透過本展可深入瞭解蛋糕生產製程、食用文化與健康價值等展品，以達寓教於樂目的，內容精采豐富。\n\n二、「歡樂蛋糕城~工藝蛋糕展」相關資料如下：\n\n(一)展覽時間：101年12月22日起至102年4月14日止，每日上午9時起至5時（周一及除夕休館；如遇國定假日周一照常開放）。\n\n(二)展覽地點：國立科學工藝博物館第二、第三特展廳。\n\n(三)展覽內容：\n\n１、【迎賓城門】可愛美麗的城門，是通往甜蜜童話-歡樂蛋糕城的捷徑。歡迎遠道而來的貴賓們，一同感受蛋糕所帶來的幸福洋溢的歡樂氣氛!\n\n２、【鄉間小道】歡迎進入鄉間小道，在復古的蛋糕插畫裡，訴說著蛋糕工藝發展幾世紀以來的變化。緊接著進入迷幻森林，在森林裡透過各式造型萬花筒，看到各式美味的蛋糕與材料，讓觀眾藉由雞蛋、麵粉；體驗到蛋糕藝術的創作與靈感。還有神奇的歡樂廚房，佈滿了各式製作蛋糕的器具。\n\n\n\n３、【鏡面蛋糕】與蛋糕拍照互動，透過鏡面反射視覺效果，和蛋糕拍出不同的趣味照片，透過鏡面折射原理感受蛋糕環繞的拍照樂趣。\n\n４、【彩虹橋】踏上歡樂彩虹橋的旅程，請放眼欣賞神奇蛋糕城！希望參觀觀眾帶著歡樂的心情走過橋後，觀賞世界七大國家特色蛋糕，並開始踏上一場幸福體驗之旅。\n\n５、【歡樂城】由7,000顆水晶所打造的迷人耀眼閃亮水晶蛋糕，本展區將可以看到各國特色蛋糕，還有巨大的牛奶噴泉造景，以及有趣的互動遊戲。\n\n６、【星光走廊】沿著優雅浪漫的燈海，歡迎來到迷人繽紛艷麗的『幻彩詠星光』蛋糕長廊步道，包括：海洋風貌造型蛋糕以及世界造景、台灣夜市風格、高雄地標造型蛋糕，緊接著還有各式由國內蛋糕名師群所製作的拉糖蛋糕、糖花蛋糕。同時上方可以看到用LED燈串成的星星，遊走在星光走廊裡，觀眾將體會置身星空的神奇經驗。 \n\n７、【互動遊戲區】互動遊戲、趣味拍照區以及蛋糕香氣櫃，等觀眾來探險以及拍照留念。 \n\n(四)票價：\n\n１、現場票價：全票250元、優惠票200元(大專以下學生、65-69歲長者) \n\n２、免費資格：115cm以下兒童免費(需家長持票陪同)、身障者及一名陪同者、70歲以上長者。 \n\n３、學校優惠預購票，不分成人、小孩，票價皆為150元。平日、假日均可使用。\n\n三、本案聯絡人：活動推廣部，優惠預購票服務專線:（07）384-9171。傳真：（07）384-9166許小姐 ", @"無", nil];
    NSArray * content8 = [[NSArray alloc] initWithObjects:@"101/11/26", @"林令華", @"24622192 分機2130", @"臺北藝術大學2012「現代世界設計潮流」研討會", @"臺北藝術大學2012「現代世界設計潮流」研討會2012年12月4日（二）13:00-17:00於國立臺北藝術大學國際會議廳（研究大樓2樓）舉辦。\n\n線上報名網址。詳細研討會議程及交通路線請見報名網頁。本研討會免費參加，即日起接受報名http://library.tnua.edu.tw/tnualib_Apply.htm，公務人員全程參加者發給4小時研習證明。\n\n研討會聯絡人：臺北藝術大學高彩珍小姐，電話：28938794，電子郵件：tckao@library.tnua.edu.tw。", @"無", nil];
    NSArray * content9 = [[NSArray alloc] initWithObjects:@"101/11/26", @"林令華", @"24622192 分機2130", @"臺北市政府文化局「第15屆臺北文化獎推廣活動」唐文華京夜講堂", @"臺北市政府文化局將於101年12月17日（一）及19日（三）下午19時至21時，假臺北市中山堂管理所光復廳辦理『第15屆臺北文化獎推廣活動』邀請唐文華老師主講：老生暢談京彩京劇就在『京夜講堂』，本活動為免費場次，18時30分開放入場，歡迎踴躍參加。", @"無", nil];
    NSArray * content10 = [[NSArray alloc] initWithObjects:@"101/11/23", @"林佩珊", @"分機2121", @"有關政治大學「楚戈紀念畫展開幕活動暨當代藝術發展研討會」訊息公告。", @"一、「楚戈紀念畫展開幕活動暨當代藝術發展研討會」活動時間為12月8日（六）上午10時至下午6時，於政治大學藝文中心2樓舜文大講堂。即日起至12月7日止，採網路報名方式http://moltke.cc.nccu.edu.tw/Registration/registration.do?action=conferenceList\n二、楚戈紀念畫展展出時間為101年12月8日-102年元月4日，週一至週六，上午11時至下午6時（週六至下午5時），於政治大學藝文中心5樓藝文空間展出。聯絡電話：(02)2939-3091#62059詹小姐", @"無", nil];
    
    self.storiesContent = [[NSArray alloc] initWithObjects:content1, content2, content3, content4, content5, content6, content7, content8, content9, content10, nil];
}

NewsCategoryId buttonCategories[] = {
    NewsCategoryIdTopNews, NewsCategoryIdCampus,
    NewsCategoryIdEngineering, NewsCategoryIdScience,
    NewsCategoryIdManagement, NewsCategoryIdArchitecture,
    NewsCategoryIdHumanities
};

NSString *titleForCategoryId(NewsCategoryId category_id) {
    NSString *result = nil;
    switch (category_id)
    {
        case NewsCategoryIdTopNews:
            result = NewsCategoryTopNews;
            break;
        case NewsCategoryIdCampus:
            result = NewsCategoryCampus;
            break;
        case NewsCategoryIdEngineering:
            result = NewsCategoryEngineering;
            break;
            /*case NewsCategoryIdScience:
             result = NewsCategoryScience;
             break;
             case NewsCategoryIdManagement:
             result = NewsCategoryManagement;
             break;
             case NewsCategoryIdArchitecture:
             result = NewsCategoryArchitecture;
             break;
             case NewsCategoryIdHumanities:
             result = NewsCategoryHumanities;
             break;*/
        default:
            break;
    }
    return result;
}

- (void)loadView
{
    //NSLog(@"StoryList.m loadView");
    [super loadView];
    
    self.navigationItem.title = @"NTOU News"; //+++++++++
    self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Headlines" style:UIBarButtonItemStylePlain target:nil action:nil] autorelease];
    //self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)] autorelease];
    
    //self.stories = [NSArray array];
    [self displayContentCampusFocus];
    self.searchQuery = nil;
    self.searchResults = nil;
    
    tempTableSelection = nil;
    
    /*NSMutableArray *newCategories = [NSMutableArray array];
     NSInteger i, count = sizeof(buttonCategories) / sizeof(NewsCategoryId);
     for (i = 0; i < count; i++)
     {
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category_id == %d", buttonCategories[i]];
     NSManagedObject *aCategory = [[CoreDataManager objectsForEntity:NewsCategoryEntityName matchingPredicate:predicate] lastObject];
     if (!aCategory)
     {
     aCategory = [CoreDataManager insertNewObjectForEntityForName:NewsCategoryEntityName];
     }
     [aCategory setValue:[NSNumber numberWithInteger:buttonCategories[i]] forKey:@"category_id"];
     [aCategory setValue:[NSNumber numberWithInteger:0] forKey:@"expectedCount"];
     [newCategories addObject:aCategory];
     }
     self.categories = newCategories;
     
     [self pruneStories];
     // reduce number of saved stories to 10 when app quits
     [[NSNotificationCenter defaultCenter] addObserver:self
     selector:@selector(pruneStories)
     name:@"UIApplicationWillTerminateNotification"
     object:nil];*/
    
    // Story Table view
    storyTable = [[UITableView alloc] initWithFrame:self.view.bounds];
    storyTable.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    storyTable.delegate = self;
    storyTable.dataSource = self;
    storyTable.separatorColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    [self.view addSubview:storyTable];
    [storyTable release];
}

- (void)viewDidLoad
{
    //NSLog(@"StoryList.m viewDidLoad");
    [self setupNavScroller];
    
    // set up results table
    storyTable.frame = CGRectMake(0, navScrollView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - navScrollView.frame.size.height);
    [self setupActivityIndicator];
    
    //[self loadFromCache];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    //NSLog(@"StoryList.m viewWillAppear");
    [super viewWillAppear:animated];
    // show / hide the bookmarks category
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"bookmarked == YES"];
    NSMutableArray *allBookmarkedStories = [CoreDataManager objectsForEntity:NewsStoryEntityName matchingPredicate:predicate];
    hasBookmarks = ([allBookmarkedStories count] > 0) ? YES : NO;
    [self setupNavScrollButtons];
    if (showingBookmarks)
    {
        [self loadFromCache];
        if (!hasBookmarks)
        {
            [self buttonPressed:[navButtons objectAtIndex:0]];
        }
    }
    // Unselect the selected row
    [tempTableSelection release];
    tempTableSelection = [[storyTable indexPathForSelectedRow] retain];
    if (tempTableSelection)
    {
        [storyTable beginUpdates];
        [storyTable deselectRowAtIndexPath:tempTableSelection animated:YES];
        [storyTable endUpdates];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"StoryList.m viewDidAppear");
    [super viewDidAppear:animated];
    if (tempTableSelection)
    {
        [storyTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:tempTableSelection] withRowAnimation:UITableViewRowAnimationNone];
        [tempTableSelection release];
        tempTableSelection = nil;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    storyTable = nil;
    navScrollView = nil;
    [navButtons release];
    navButtons = nil;
    [activityView release];
    activityView = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIApplicationWillTerminateNotification" object:nil];
    self.stories = nil;
    self.searchQuery = nil;
    self.searchResults = nil;
    self.categories = nil;
    self.xmlParser = nil;
    [super dealloc];
}


- (void)pruneStories
{
    [self pruneStories:YES];
}

- (void)pruneStories:(BOOL)asyncPrune
{
    //NSLog(@"StoryList.m pruneStories");
    void (*dispatch_func)(dispatch_queue_t,dispatch_block_t) = NULL;
    
    if (asyncPrune)
    {
        dispatch_func = &dispatch_async;
    }
    else
    {
        dispatch_func = &dispatch_sync;
    }
    
    (*dispatch_func)(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
        context.persistentStoreCoordinator = [[CoreDataManager coreDataManager] persistentStoreCoordinator];
        context.undoManager = nil;
        context.mergePolicy = NSOverwriteMergePolicy;
        [context lock];
        
        NSPredicate *notBookmarkedPredicate = [NSPredicate predicateWithFormat:@"(bookmarked == nil) || (bookmarked == NO)"];
        
        // bskinner (note): This is legacy code from 1.x. It was added to clean up
        //  duplicate, un-bookmarked articles when upgrading from 1.x to 2.x.
        //  On all new installs this ends up being a NOOP.
        if (![[NSUserDefaults standardUserDefaults] boolForKey:MITNewsTwoFirstRunKey])
        {
            NSEntityDescription *newsStoryEntity = [NSEntityDescription entityForName:NewsStoryEntityName
                                                               inManagedObjectContext:context];
            
            NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
            fetchRequest.entity = newsStoryEntity;
            fetchRequest.predicate = notBookmarkedPredicate;
            
            NSArray *results = [context executeFetchRequest:fetchRequest
                                                      error:NULL];
            for (NSManagedObject *result in results)
            {
                [context deleteObject:result];
            }
            [[NSUserDefaults standardUserDefaults] setBool:YES
                                                    forKey:MITNewsTwoFirstRunKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        {
            NSEntityDescription *newsStoryEntity = [NSEntityDescription entityForName:NewsStoryEntityName
                                                               inManagedObjectContext:context];
            
            NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
            fetchRequest.entity = newsStoryEntity;
            fetchRequest.predicate = notBookmarkedPredicate;
            fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"postDate" ascending:NO]];
            
            NSArray *stories = [context executeFetchRequest:fetchRequest
                                                      error:NULL];
            
            NSMutableDictionary *savedArticles = [NSMutableDictionary dictionary];
            for (NewsStory *story in stories)
            {
                BOOL storySaved = NO;
                
                for (NSManagedObject *category in story.categories)
                {
                    NSNumber *categoryID = [category valueForKey:@"category_id"];
                    NSMutableSet *categoryStories = [savedArticles objectForKey:categoryID];
                    
                    if (categoryStories == nil)
                    {
                        categoryStories = [NSMutableSet set];
                        [savedArticles setObject:categoryStories
                                          forKey:categoryID];
                    }
                    
                    BOOL shouldSave = storySaved = (([categoryStories count] < 10) &&
                                                    (story.postDate != nil) &&
                                                    ([story.postDate compare:[NSDate date]] != NSOrderedDescending));
                    if (shouldSave)
                    {
                        [categoryStories addObject:story];
                    }
                }
                
                if (storySaved == NO)
                {
                    [context deleteObject:story];
                }
            }
            
            [savedArticles enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                NSLog(@"Category %@ has %d articles after pruning", key, [obj count]);
            }];
        }
        
        NSError *error = nil;
        [context save:&error];
        
        if (error)
        {
            ELog(@"[News] Failed to save pruning context: %@", [error localizedDescription]);
        }
        
        [context unlock];
        [context release];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self loadFromCache];
        });
    });
}


#pragma mark - Category selector
- (void)setupNavScroller
{
    // Nav Scroller View
    navScrollView = [[NavScrollerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.0)];
    navScrollView.navScrollerDelegate = self;
    
    [self.view addSubview:navScrollView];
}

- (void)setupNavScrollButtons
{
    //NSLog(@"StoryList.m setupNavScrollButtons");
    [navScrollView removeAllButtons];
    
    // add search button
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *searchImage = [UIImage imageNamed:MITImageNameSearch];
    [searchButton setImage:searchImage forState:UIControlStateNormal];
    searchButton.adjustsImageWhenHighlighted = NO;
    searchButton.tag = SEARCH_BUTTON_TAG; // random number that won't conflict with news categories
    
    [navScrollView addButton:searchButton shouldHighlight:NO];
    
    if (hasBookmarks)
    {
        UIButton *bookmarkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *bookmarkImage = [UIImage imageNamed:MITImageNameBookmark];
        [bookmarkButton setImage:bookmarkImage forState:UIControlStateNormal];
        bookmarkButton.adjustsImageWhenHighlighted = NO;
        bookmarkButton.tag = BOOKMARK_BUTTON_TAG; // random number that won't conflict with news categories
        [navScrollView addButton:bookmarkButton shouldHighlight:NO];
    }
    // add pile of text buttons
    
    // create buttons for nav scroller view
    /*NSArray *buttonTitles = [NSArray arrayWithObjects:
     NewsCategoryTopNews, NewsCategoryCampus,
     NewsCategoryEngineering,
     NewsCategoryScience, NewsCategoryManagement,
     NewsCategoryArchitecture, NewsCategoryHumanities,
     nil];*/
    NSArray *buttonTitles = [NSArray arrayWithObjects:
                             NewsCategoryTopNews, NewsCategoryCampus,
                             NewsCategoryEngineering,
                             nil];
    
    //NSMutableArray *buttons = [[NSMutableArray alloc] initWithCapacity:[buttonTitles count]];
    
    NSInteger i = 0;
    for (NSString *buttonTitle in buttonTitles)
    {
        UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
        aButton.tag = buttonCategories[i];
        [aButton setTitle:buttonTitle forState:UIControlStateNormal];
        i++;
        [navScrollView addButton:aButton shouldHighlight:YES];
    }
    
    UIButton *homeButton = [navScrollView buttonWithTag:self.activeCategoryId];
    [navScrollView buttonPressed:homeButton];
}

- (void)buttonPressed:(id)sender
{
    //NSLog(@"StoryList.m buttonPressed");
    UIButton *pressedButton = (UIButton *)sender;
    if (pressedButton.tag == SEARCH_BUTTON_TAG)
    {
        [self showSearchBar];
    }
    else
    {
        [self switchToCategory:pressedButton.tag];
    }
}

#pragma mark -
#pragma mark Search UI

- (void)showSearchBar
{
    //NSLog(@"StoryList.m showSearchBar");
    if (!theSearchBar)
    {
        theSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 44.0)];
        theSearchBar.tintColor = SEARCH_BAR_TINT_COLOR;
        theSearchBar.alpha = 0.0;
        [self.view addSubview:theSearchBar];
    }
    
    if (!searchController)
    {
        CGRect frame = CGRectMake(0.0, theSearchBar.frame.size.height, self.view.frame.size.width,
                                  self.view.frame.size.height - (theSearchBar.frame.size.height + activityView.frame.size.height));
        searchController = [[MITSearchDisplayController alloc] initWithFrame:frame searchBar:theSearchBar contentsController:self];
        searchController.delegate = self;
    }
    
    [self.view bringSubviewToFront:theSearchBar];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.4];
    theSearchBar.alpha = 1.0;
    [UIView commitAnimations];
    
    [searchController setActive:YES animated:YES];
}

- (void)hideSearchBar
{
    if (theSearchBar)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.4];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(releaseSearchBar)];
        theSearchBar.alpha = 0.0;
        [UIView commitAnimations];
    }
}

- (void)releaseSearchBar
{
    [theSearchBar removeFromSuperview];
    [theSearchBar release];
    theSearchBar = nil;
    
    [searchController release];
    searchController = nil;
}

#pragma mark UISearchBar delegation

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    // cancel any outstanding search
    if (self.xmlParser)
    {
        [self.xmlParser abort]; // cancel previous category's request if it's still going
        self.xmlParser = nil;
    }
    
    // hide search interface
    [self hideSearchBar];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //[self unfocusSearchBar];
    
    self.searchQuery = searchBar.text;
    [self loadSearchResultsFromServer:NO forQuery:self.searchQuery];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    // when query is cleared, clear search result and show category instead
    if ([searchText length] == 0)
    {
        if ([self.searchResults count] > 0)
        {
            [storyTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
        self.searchResults = nil;
        [self loadFromCache];
    }
}

#pragma mark -
#pragma mark News activity indicator

- (void)setupActivityIndicator
{
    activityView = [[UIView alloc] initWithFrame:CGRectZero];
    activityView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    activityView.tag = 9;
    activityView.backgroundColor = [UIColor blackColor];
    activityView.userInteractionEnabled = NO;
    
    // loading field
    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, 0, 0)];
    loadingLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    loadingLabel.tag = 10;
    loadingLabel.text = @"Loading...";
    loadingLabel.textColor = [UIColor colorWithHexString:@"#DDDDDD"];
    loadingLabel.font = [UIFont boldSystemFontOfSize:14.0];
    loadingLabel.backgroundColor = [UIColor blackColor];
    loadingLabel.opaque = YES;
    [activityView addSubview:loadingLabel];
    loadingLabel.hidden = YES;
    [loadingLabel release];
    
    CGSize labelSize = [loadingLabel.text sizeWithFont:loadingLabel.font forWidth:self.view.bounds.size.width lineBreakMode:UILineBreakModeTailTruncation];
    
    [self.view addSubview:activityView];
    
    CGFloat bottom = CGRectGetMaxY(storyTable.frame);
    CGFloat height = labelSize.height + 8;
    activityView.frame = CGRectMake(0, bottom - height, self.view.bounds.size.width, height);
    
    UIProgressView *progressBar = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    progressBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    progressBar.tag = 11;
    progressBar.frame = CGRectMake((8 + (NSInteger)labelSize.width) + 5, 0, activityView.frame.size.width - (8 + (NSInteger)labelSize.width) - 13, progressBar.frame.size.height);
    progressBar.center = CGPointMake(progressBar.center.x, (NSInteger)(activityView.frame.size.height / 2) + 1);
    [activityView addSubview:progressBar];
    progressBar.progress = 0.0;
    progressBar.hidden = YES;
    [progressBar release];
    
    // Update field
    UILabel *updatedLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, activityView.frame.size.width - 16, activityView.frame.size.height)];
    updatedLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    updatedLabel.tag = 12;
    updatedLabel.text = @"";
    updatedLabel.textColor = [UIColor colorWithHexString:@"#DDDDDD"];
    updatedLabel.font = [UIFont boldSystemFontOfSize:14.0];
    updatedLabel.textAlignment = UITextAlignmentRight;
    updatedLabel.backgroundColor = [UIColor blackColor];
    updatedLabel.opaque = YES;
    [activityView addSubview:updatedLabel];
    [updatedLabel release];
    
    // shrink table down to accomodate
    CGRect frame = storyTable.frame;
    frame.size.height = frame.size.height - height;
    storyTable.frame = frame;
}

#pragma mark -
#pragma mark Story loading

// TODO break off all of the story loading and paging mechanics into a separate NewsDataManager
// Having all of the CoreData logic stuffed into here makes for ugly connections from story views back to this list view
// It also forces odd behavior of the paging controls when a memory warning occurs while looking at a story

- (void)switchToCategory:(NewsCategoryId)category
{
    //NSLog(@"StoryList.m switchToCategory");
    if (category != self.activeCategoryId)
    {
        /*if (self.xmlParser)
         {
         [self.xmlParser abort]; // cancel previous category's request if it's still going
         self.xmlParser = nil;
         }*/
        self.activeCategoryId = category;
        self.stories = nil;
        self.storiesDate = nil;
        self.storiesContent = nil;
        if ([self.stories count] > 0)
        {
            [storyTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
        [storyTable reloadData];
        showingBookmarks = (category == BOOKMARK_BUTTON_TAG) ? YES : NO;
        
        if (self.activeCategoryId == NewsCategoryIdTopNews)
        {
            [self displayContentCampusFocus];
            
        }
        else if (self.activeCategoryId == NewsCategoryIdCampus)
        {
            [self displayContentSchoolBulletin];
        }
        else
        {
            [self displayContentExternalMessage];
        }
        
        
        //[self loadFromCache]; // makes request to server if no request has been made this session
    }
    
    [storyTable reloadData];
}

- (void)refresh:(id)sender
{
    if (!self.searchResults)
    {
        // get active category
        NSManagedObject *aCategory = [[self.categories filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"category_id == %d", self.activeCategoryId]] lastObject];
        
        // set its expectedCount to 0
        [aCategory setValue:[NSNumber numberWithInteger:0] forKey:@"expectedCount"];
        
        // reload
        [self loadFromCache];
    }
    else
    {
        [self loadSearchResultsFromServer:NO forQuery:self.searchQuery];
    }
    
}
/*
 - (void)loadFromCache
 {
 NSLog(@"StoryList.m loadFromCache");
 
 // if showing bookmarks, show those instead
 if (showingBookmarks)
 {
 [self setStatusText:@""];
 NSPredicate *predicate = [NSPredicate predicateWithFormat:@"bookmarked == YES"];
 NSMutableArray *allBookmarkedStories = [CoreDataManager objectsForEntity:NewsStoryEntityName matchingPredicate:predicate];
 self.stories = allBookmarkedStories;
 
 }
 else
 {
 // load what's in CoreData, up to categoryCount
 NSArray *sortDescriptors = [NSArray arrayWithObjects:
 //[NSSortDescriptor sortDescriptorWithKey:@"featured" ascending:NO],
 [NSSortDescriptor sortDescriptorWithKey:@"postDate" ascending:NO],
 [NSSortDescriptor sortDescriptorWithKey:@"story_id" ascending:NO],
 nil];
 
 NSPredicate *predicate = nil;
 if (self.activeCategoryId == NewsCategoryIdTopNews)
 {
 predicate = [NSPredicate predicateWithFormat:@"(topStory != nil) && (topStory == YES)"];
 }
 else
 {
 predicate = [NSPredicate predicateWithFormat:@"ANY categories.category_id == %d", self.activeCategoryId];
 }
 
 // if maxLength == 0, nothing's been loaded from the server this session -- show up to 10 results from core data
 // else show up to maxLength
 NSMutableArray *results = [NSMutableArray arrayWithArray:[CoreDataManager objectsForEntity:NewsStoryEntityName
 matchingPredicate:predicate
 sortDescriptors:sortDescriptors]];
 if ([results count] && ([[[results objectAtIndex:0] featured] boolValue] == NO))
 {
 [results enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
 NewsStory *story = (NewsStory*)obj;
 
 if ([story.featured boolValue] == YES)
 {
 [results exchangeObjectAtIndex:0
 withObjectAtIndex:idx];
 (*stop) = YES;
 }
 }];
 }
 
 NSManagedObject *aCategory = [[self.categories filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"category_id == %d", self.activeCategoryId]] lastObject];
 NSDate *lastUpdatedDate = [aCategory valueForKey:@"lastUpdated"];
 
 [self setLastUpdated:lastUpdatedDate];
 
 NSInteger maxLength = [[aCategory valueForKey:@"expectedCount"] integerValue];
 NSInteger resultsCount = [results count];
 if (maxLength == 0)
 {
 [self loadFromServer:NO]; // this creates a loop which will keep trying until there is at least something in this category
 // TODO: make sure this doesn't become an infinite loop.
 maxLength = 10;
 }
 if (maxLength > resultsCount)
 {
 maxLength = resultsCount;
 }
 self.stories = [results subarrayWithRange:NSMakeRange(0, maxLength)];
 }
 [storyTable reloadData];
 [storyTable flashScrollIndicators];
 }
 
 - (void)loadFromServer:(BOOL)loadMore
 {
 NSLog(@"StoryList.m loadFromServer");
 // make an asynchronous call for more stories
 
 // start new request
 NewsStory *lastStory = [self.stories lastObject];
 NSInteger lastStoryId = (loadMore) ? [lastStory.story_id integerValue] : 0;
 if (self.xmlParser)
 {
 [self.xmlParser abort];
 }
 self.xmlParser = [[[StoryXMLParser alloc] init] autorelease];
 xmlParser.delegate = self;
 [xmlParser loadStoriesForCategory:self.activeCategoryId
 afterStoryId:lastStoryId
 count:10]; // count doesn't do anything at the moment (no server support)
 }*/

- (void)loadSearchResultsFromCache
{
    //NSLog(@"StoryList.m loadSearchResultsFromCache");
    
    // make a predicate for everything with the search flag
    NSPredicate *predicate = nil;
    NSSortDescriptor *postDateSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"postDate" ascending:NO];
    NSSortDescriptor *storyIdSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"story_id" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:postDateSortDescriptor, storyIdSortDescriptor, nil];
    [storyIdSortDescriptor release];
    [postDateSortDescriptor release];
    
    predicate = [NSPredicate predicateWithFormat:@"searchResult == YES"];
    
    // show everything that comes back
    NSArray *results = [CoreDataManager objectsForEntity:NewsStoryEntityName matchingPredicate:predicate sortDescriptors:sortDescriptors];
    
    NSInteger resultsCount = [results count];
    
    [self setStatusText:@""];
    if (resultsCount == 0)
    {
        UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:nil message:@"No matching articles found." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
        [alertView show];
        self.searchResults = nil;
        self.stories = nil;
        [storyTable reloadData];
    }
    else
    {
        self.searchResults = results;
        self.stories = results;
        
        // hide translucent overlay
        [searchController hideSearchOverlayAnimated:YES];
        
        // show results
        [storyTable reloadData];
        [storyTable flashScrollIndicators];
    }
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    DLog(@"make sure search bar is first responder right now");
}
/*
 - (void)loadSearchResultsFromServer:(BOOL)loadMore forQuery:(NSString *)query
 {
 if (self.xmlParser)
 {
 [self.xmlParser abort];
 }
 self.xmlParser = [[[StoryXMLParser alloc] init] autorelease];
 xmlParser.delegate = self;
 
 [xmlParser loadStoriesforQuery:query afterIndex:((loadMore) ? [self.searchResults count] : 0) count:10];
 }*/
/*
 #pragma mark -
 #pragma mark StoryXMLParser delegation
 
 - (void)parserDidStartDownloading:(StoryXMLParser *)parser
 {
 if (parser == self.xmlParser)
 {
 [self setProgress:0.1];
 [storyTable reloadData];
 }
 }
 
 - (void)parserDidStartParsing:(StoryXMLParser *)parser
 {
 if (parser == self.xmlParser)
 {
 [self setProgress:0.3];
 }
 }
 
 - (void)parser:(StoryXMLParser *)parser didMakeProgress:(CGFloat)percentDone
 {
 if (parser == self.xmlParser)
 {
 [self setProgress:0.3 + 0.7 * percentDone * 0.01];
 }
 }
 
 - (void)parser:(StoryXMLParser *)parser didFailWithDownloadError:(NSError *)error
 {
 if (parser == self.xmlParser)
 {
 // TODO: communicate download failure to user
 if ([error code] == NSURLErrorNotConnectedToInternet)
 {
 ELog(@"News download failed because there's no net connection");
 }
 else
 {
 ELog(@"Download failed for parser %@ with error %@", parser, [error userInfo]);
 }
 [self setStatusText:@"Update failed"];
 
 [MITMobileWebAPI showErrorWithHeader:@"News"];
 if ([self.stories count] > 0)
 {
 [storyTable deselectRowAtIndexPath:[NSIndexPath indexPathForRow:[self.stories count] inSection:0] animated:YES];
 }
 }
 }
 
 - (void)parser:(StoryXMLParser *)parser didFailWithParseError:(NSError *)error
 {
 if (parser == self.xmlParser)
 {
 // TODO: communicate parse failure to user
 [self setStatusText:@"Update failed"];
 [MITMobileWebAPI showErrorWithHeader:@"News"];
 if ([self.stories count] > 0)
 {
 [storyTable deselectRowAtIndexPath:[NSIndexPath indexPathForRow:[self.stories count] inSection:0] animated:YES];
 }
 }
 }
 
 - (void)parserDidFinishParsing:(StoryXMLParser *)parser
 {
 NSLog(@"StoryList.m parserDidFinishParsing");
 if (parser == self.xmlParser)
 {
 // basic category request
 if (!parser.isSearch)
 {
 NSManagedObject *aCategory = [[self.categories filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"category_id == %d", self.activeCategoryId]] lastObject];
 NSInteger length = [[aCategory valueForKey:@"expectedCount"] integerValue];
 if (length == 0)
 { // fresh load of category, set its updated date
 [aCategory setValue:[NSDate date] forKey:@"lastUpdated"];
 }
 length += [self.xmlParser.addedStories count];
 [aCategory setValue:[NSNumber numberWithInteger:length] forKey:@"expectedCount"];
 if (!parser.loadingMore && [self.stories count] > 0)
 {
 [storyTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
 }
 self.xmlParser = nil;
 
 if (parser.loadingMore == NO)
 {
 [self pruneStories:NO];
 }
 
 [self loadFromCache];
 }
 // result of a search request
 else
 {
 searchTotalAvailableResults = self.xmlParser.totalAvailableResults;
 if (!parser.loadingMore && [self.stories count] > 0)
 {
 [storyTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
 }
 self.xmlParser = nil;
 [self loadSearchResultsFromCache];
 }
 }
 }*/

/*#pragma mark -
 #pragma mark Bottom status bar
 
 - (void)setStatusText:(NSString *)text
 {
 NSLog(@"StoryList.m setStatusText");
 UILabel *loadingLabel = (UILabel *)[activityView viewWithTag:10];
 UIProgressView *progressBar = (UIProgressView *)[activityView viewWithTag:11];
 UILabel *updatedLabel = (UILabel *)[activityView viewWithTag:12];
 loadingLabel.hidden = YES;
 progressBar.hidden = YES;
 updatedLabel.hidden = NO;
 updatedLabel.text = text;
 }
 
 - (void)setLastUpdated:(NSDate *)date
 {
 NSLog(@"StoryList.m setLastUpdated");
 NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
 [formatter setDateStyle:NSDateFormatterMediumStyle];
 [formatter setTimeStyle:NSDateFormatterShortStyle];
 [self setStatusText:(date) ? [NSString stringWithFormat:@"Last updated %@", [formatter stringFromDate:date]] : nil];
 [formatter release];
 }
 
 - (void)setProgress:(CGFloat)value
 {
 NSLog(@"StoryList.m setProgress");
 UILabel *loadingLabel = (UILabel *)[activityView viewWithTag:10];
 UIProgressView *progressBar = (UIProgressView *)[activityView viewWithTag:11];
 UILabel *updatedLabel = (UILabel *)[activityView viewWithTag:12];
 loadingLabel.hidden = NO;
 progressBar.hidden = NO;
 updatedLabel.hidden = YES;
 progressBar.progress = value;
 }*/

#pragma mark -
#pragma mark UITableViewDataSource and UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //NSLog(@"StoryList.m numberOfSectionsInTableView");
    return (self.stories.count > 0) ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSInteger n = 0;
    /*switch (section)
     {
     case 0:
     n = self.stories.count;
     // don't show "load x more" row if
     if (!showingBookmarks && // showing bookmarks
     !(searchResults && n >= searchTotalAvailableResults) && // showing all search results
     !(!searchResults && n >= 200))
     { // showing all of a category
     n += 1; // + 1 for the "Load more articles..." row
     }
     break;
     }*/
    //return n;
    return [self.stories count];
}

/*- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
 {
 if (section == 0 && self.searchResults)
 {
 return UNGROUPED_SECTION_HEADER_HEIGHT;
 }
 else
 {
 return 0.0;
 }
 }
 
 - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
 {
 UIView *titleView = nil;
 
 if (section == 0 && self.searchResults)
 {
 titleView = [UITableView ungroupedSectionHeaderWithTitle:[NSString stringWithFormat:@"%d found", searchTotalAvailableResults]];
 }
 
 return titleView;
 
 }*/


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat rowHeight = THUMBNAIL_WIDTH;
    
    switch (indexPath.section)
    {
        case 0:
        {
            if (indexPath.row < self.stories.count)
            {
                rowHeight = THUMBNAIL_WIDTH;
            }
            else
            {
                rowHeight = 50; // "Load more articles..."
            }
            
            break;
        }
    }
    return rowHeight;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"StoryList.m cellForRowAtIndexPath");
    //UITableViewCell *result = nil;
    static NSString *StoryCellIdentifier = @"StoryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:StoryCellIdentifier];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:StoryCellIdentifier];
    
    cell.textLabel.text = [self.stories objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.storiesDate objectAtIndex:indexPath.row];
    
    /*switch (indexPath.section)
     {
     case 0:
     {
     if (indexPath.row < self.stories.count)
     {
     NewsStory *story = [self.stories objectAtIndex:indexPath.row];
     
     static NSString *StoryCellIdentifier = @"StoryCell";
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:StoryCellIdentifier];
     
     UILabel *titleLabel = nil;
     UILabel *dekLabel = nil;
     StoryThumbnailView *thumbnailView = nil;
     
     if (cell == nil)
     {
     // Set up the cell
     cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:StoryCellIdentifier] autorelease];
     
     // Title View
     titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
     titleLabel.tag = 1;
     titleLabel.font = [UIFont boldSystemFontOfSize:STORY_TITLE_FONT_SIZE];
     titleLabel.numberOfLines = 0;
     titleLabel.lineBreakMode = UILineBreakModeTailTruncation;
     [cell.contentView addSubview:titleLabel];
     [titleLabel release];
     
     // Summary View
     dekLabel = [[UILabel alloc] initWithFrame:CGRectZero];
     dekLabel.tag = 2;
     dekLabel.font = [UIFont systemFontOfSize:STORY_DEK_FONT_SIZE];
     dekLabel.textColor = [UIColor colorWithHexString:@"#0D0D0D"];
     dekLabel.highlightedTextColor = [UIColor whiteColor];
     dekLabel.numberOfLines = 0;
     dekLabel.lineBreakMode = UILineBreakModeTailTruncation;
     [cell.contentView addSubview:dekLabel];
     [dekLabel release];
     
     thumbnailView = [[StoryThumbnailView alloc] initWithFrame:CGRectMake(0, 0, THUMBNAIL_WIDTH, THUMBNAIL_WIDTH)];
     thumbnailView.tag = 3;
     [cell.contentView addSubview:thumbnailView];
     [thumbnailView release];
     
     [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
     cell.selectionStyle = UITableViewCellSelectionStyleGray;
     }
     
     titleLabel = (UILabel *)[cell viewWithTag:1];
     dekLabel = (UILabel *)[cell viewWithTag:2];
     thumbnailView = (StoryThumbnailView *)[cell viewWithTag:3];
     
     titleLabel.text = story.title;
     dekLabel.text = story.summary;
     
     titleLabel.textColor = ([story.read boolValue]) ? [UIColor colorWithHexString:@"#666666"] : [UIColor blackColor];
     titleLabel.highlightedTextColor = [UIColor whiteColor];
     
     // Calculate height
     CGFloat availableHeight = STORY_TEXT_HEIGHT;
     CGSize titleDimensions = [titleLabel.text sizeWithFont:titleLabel.font constrainedToSize:CGSizeMake(STORY_TEXT_WIDTH, availableHeight) lineBreakMode:UILineBreakModeTailTruncation];
     availableHeight -= titleDimensions.height;
     
     CGSize dekDimensions = CGSizeZero;
     // if not even one line will fit, don't show the deck at all
     if (availableHeight > dekLabel.font.leading)
     {
     dekDimensions = [dekLabel.text sizeWithFont:dekLabel.font constrainedToSize:CGSizeMake(STORY_TEXT_WIDTH, availableHeight) lineBreakMode:UILineBreakModeTailTruncation];
     }
     
     
     titleLabel.frame = CGRectMake(THUMBNAIL_WIDTH + STORY_TEXT_PADDING_LEFT,
     STORY_TEXT_PADDING_TOP,
     STORY_TEXT_WIDTH,
     titleDimensions.height);
     dekLabel.frame = CGRectMake(THUMBNAIL_WIDTH + STORY_TEXT_PADDING_LEFT,
     ceil(CGRectGetMaxY(titleLabel.frame)),
     STORY_TEXT_WIDTH,
     dekDimensions.height);
     
     thumbnailView.imageRep = story.inlineImage.thumbImage;
     [thumbnailView loadImage];
     
     result = cell;
     }
     else if (indexPath.row == self.stories.count)
     {
     NSString *MyIdentifier = @"moreArticles";
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
     if (cell == nil)
     {
     // Set up the cell
     cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
     cell.selectionStyle = UITableViewCellSelectionStyleGray;
     
     UILabel *moreArticlesLabel = [[UILabel alloc] initWithFrame:cell.frame];
     moreArticlesLabel.font = [UIFont boldSystemFontOfSize:16];
     moreArticlesLabel.numberOfLines = 1;
     moreArticlesLabel.textColor = [UIColor colorWithHexString:@"#990000"];
     moreArticlesLabel.text = @"Load 10 more articles..."; // just something to make it place correctly
     [moreArticlesLabel sizeToFit];
     moreArticlesLabel.tag = 1234;
     CGRect frame = moreArticlesLabel.frame;
     frame.origin.x = 10;
     frame.origin.y = ((NSInteger)(50.0 - moreArticlesLabel.frame.size.height)) / 2;
     moreArticlesLabel.frame = frame;
     
     [cell.contentView addSubview:moreArticlesLabel];
     [moreArticlesLabel release];
     }
     
     UILabel *moreArticlesLabel = (UILabel *)[cell viewWithTag:1234];
     if (moreArticlesLabel)
     {
     NSInteger remainingArticlesToLoad = (!searchResults) ? (200 - [self.stories count]) : (searchTotalAvailableResults - [self.stories count]);
     moreArticlesLabel.text = [NSString stringWithFormat:@"Load %d more articles...", (remainingArticlesToLoad > 10) ? 10 : remainingArticlesToLoad];
     if (!self.xmlParser)
     { // disable when a load is already in progress
     moreArticlesLabel.textColor = [UIColor colorWithHexString:@"#990000"]; // enable
     }
     else
     {
     moreArticlesLabel.textColor = [UIColor colorWithHexString:@"#999999"]; // disable
     }
     
     
     [moreArticlesLabel sizeToFit];
     }
     
     result = cell;
     }
     else
     {
     ELog(@"%@ attempted to show non-existent row (%d) with actual count of %d", NSStringFromSelector(_cmd), indexPath.row, self.stories.count);
     }
     }
     break;
     }*/
    return cell;
}

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"StoryList.m didSelectRowAtIndexPath");
    
    StoryDetailViewController *detailViewController = [[StoryDetailViewController alloc] init];
    detailViewController.newsController = self;
    
    
    //NSLog(@"story ele: %@", [self.stories objectAtIndex:indexPath.row]);
    
    if (self.activeCategoryId == NewsCategoryIdTopNews)
    {
        NSArray *story = [[NSArray alloc] initWithObjects:[self.storiesContent objectAtIndex:indexPath.row], nil];
        detailViewController.story = story;
        detailViewController.type = @"CampusFocus";
    }
    else if (self.activeCategoryId == NewsCategoryIdCampus)
    {
        NSArray *story = [self.storiesContent objectAtIndex:indexPath.row];
        detailViewController.story = story;
        detailViewController.type = @"SchoolBulletin";
    }
    else
    {
        NSArray *story = [self.storiesContent objectAtIndex:indexPath.row];
        detailViewController.story = story;
        detailViewController.type = @"ExternalMessage";
    }
    
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    
    /*if (indexPath.row == self.stories.count)
     {
     if (!self.xmlParser)
     { // only "load x more..." if no other load is going on
     if (!self.searchResults)
     {
     [self loadFromServer:YES];
     }
     else
     {
     [self loadSearchResultsFromServer:YES forQuery:self.searchQuery];
     }
     }
     }
     else
     {
     StoryDetailViewController *detailViewController = [[StoryDetailViewController alloc] init];
     detailViewController.newsController = self;
     NewsStory *story = [self.stories objectAtIndex:indexPath.row];
     detailViewController.story = story;
     
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     }*/
}

#pragma mark -
#pragma mark Browsing hooks

- (BOOL)canSelectPreviousStory
{
    //NSLog(@"StoryList.m canSelectPreviousStory");
    NSIndexPath *currentIndexPath = [storyTable indexPathForSelectedRow];
    if (currentIndexPath.row > 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (BOOL)canSelectNextStory
{
    //NSLog(@"StoryList.m canSelectNextStory");
    NSIndexPath *currentIndexPath = [storyTable indexPathForSelectedRow];
    if (currentIndexPath.row + 1 < [self.stories count])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (NewsStory *)selectPreviousStory
{
    //NSLog(@"StoryList.m selectPreviousStory");
    NewsStory *prevStory = nil;
    if ([self canSelectPreviousStory])
    {
        NSIndexPath *currentIndexPath = [storyTable indexPathForSelectedRow];
        NSIndexPath *prevIndexPath = [NSIndexPath indexPathForRow:currentIndexPath.row - 1 inSection:currentIndexPath.section];
        prevStory = [self.stories objectAtIndex:prevIndexPath.row];
        [storyTable selectRowAtIndexPath:prevIndexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    }
    return prevStory;
}

- (NewsStory *)selectNextStory
{
    //NSLog(@"StoryList.m selectNextStory");
    NewsStory *nextStory = nil;
    if ([self canSelectNextStory])
    {
        NSIndexPath *currentIndexPath = [storyTable indexPathForSelectedRow];
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:currentIndexPath.row + 1 inSection:currentIndexPath.section];
        nextStory = [self.stories objectAtIndex:nextIndexPath.row];
        [storyTable selectRowAtIndexPath:nextIndexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    }
    return nextStory;
}

@end
