//
//  Des_decrypt.h
//  APITest
//
//  Created by R MAC on 12/12/7.
//  Copyright (c) 2012年 R MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Moodle_API : NSObject
/*
   登入界面
   參數為學號以及登入moodle的密碼
   回傳一個Dictionary
   EX: {“result”=”1”,”token”=”token”}
   token是一個登入識別碼
 */

+(NSDictionary *)Login:(NSString *)username andPassword:(NSString*)password;



/*依照學生學號與學年度回傳選課課表
  參數為登入後的識別碼token
  回傳一個Dictionary
  EX: {"list":[{"course":[{"id":"M57011D0","classroom":"INS407","time":2,"name":"3D實景拍攝技術"},{"id":"M57011D0","classroom":"INS407","time":4,"name":"3D實景拍攝技術"},{"id":"M5701P99","classroom":"INSB14","time":7,"name":"高等演算法"},{"id":"M5701P99","classroom":"INSB14","time":8,"name":"高等演算法"}],"day":"Wed"},{"course":[{"id":"M5711I38","classroom":"CE-001","time":8,"name":"專題討論"}],"day":"Thu"},{"course":[{"id":"M60010HS","classroom":"EE1206","time":7,"name":"RFID概論"},{"id":"M60010HS","classroom":"EE1206","time":8,"name":"RFID概論"}],"day":"Fri"}]}
 */
+(NSDictionary *)GetCourse_AndUseToken:(NSString*)token;


/*
 回傳課程資訊
 參數: token:識別碼
      cosid:課程課號
      clsid:開課班號(班別)
 回傳範例:
   {"crd":3,"ch_lesson":"網際服務軟體工程","ch_type":"期中考\r\nHomework\r\n期末專案(新穎技術報告+網際服務應用規劃)\r\n","ch_preobj":"網路概論、網路程式設計(建議)、Java程式設計(建議)","ch_target":"本課程針對網際服務應用軟體(Web-based Applications)特性，透過原理與實作的結合，引導學生有效運用軟體工程建構Web應用系統。課程主軸分為兩部分，分別為以J2EE為主軸的Web軟體技術(Web technology)與網際服務軟體工程流程(Web-based software engineering process)，希望透過技術與流程之整合以開發高品質網際服務軟體。\r\n\r\n修過網路程式設計與Java程式設計課程的同學可透過此課程學習到Java-based的伺服器端Web技術(Server-Side Web Programming)，並可熟悉完整的Web應用系統之開發方法。目前Web技術之重要性不言可喻，不論是一般應用軟體或進階之雲端運算(Cloud Computing)與行動運算(Mobile Computing)均需仰賴Web技術。修習此課程將可學習到實務完整的Web技術與Web系統開發方法。","ch_ref":"\"Head First Servlets & JSP, 2nd Version\", by Bryan Basham, Kathy Sierra and Bert Bates, O'Reilly, 2008\r\n\"軟體工程\"，李允中著，高立圖書有限公司，2009\r\n","ch_teach":"1.上課講義講解與實例解釋\r\n2.專題製作\r\n","ch_object":"1.Web App Architecture: high-level overview\r\n2.Mini MVC Tutorial\r\n3.Servlet: request AND response\r\n4.Web App: attributes and listeners\r\n5.Conversational state: session management\r\n6.Using JSP + Scriptless JSP\r\n7.JSTL (JavaServer Pages Standard Tag Library)\r\n8.JavaScript for AJAX\r\n9.XML and JSON\r\n10.建立大規模的Web應用系統\r\n11.軟體需求分析\r\n12.新穎Web 技術報告 ＋ 專案提案\r\n13.Web軟體設計 + StarUML實習\r\n14.需求分析文件報告\r\n15.Web軟體測試 + Mantis實習 (Bug Tracking)\r\n16.Selenium實習 (功能測試) + JMeter (效能測試)\r\n","teacher":"馬尚彬","must":"B","download_addr":"Moodle","ch_teachsch":"1.Web App Architecture: high-level overview\r\n2.Mini MVC Tutorial\r\n3.Servlet: request AND response\r\n4.Web App: attributes and listeners\r\n5.Conversational state: session management\r\n6.Using JSP + Scriptless JSP\r\n7.JSTL (JavaServer Pages Standard Tag Library)\r\n8.JavaScript for AJAX\r\n9.XML and JSON\r\n10.建立大規模的Web應用系統\r\n11.軟體需求分析\r\n12.新穎Web 技術報告 ＋ 專案提案\r\n13.Web軟體設計 + StarUML實習\r\n14.需求分析文件報告\r\n15.Web軟體測試 + Mantis實習 (Bug Tracking)\r\n16.Selenium實習 (功能測試) + JMeter (效能測試)\r\n"}
 */
+(NSDictionary *)GetCourseInfo_AndUseToken:(NSString *)token
                                  courseID:(NSString *)cosID
                                   classID:(NSString *)clsID;



/*
 回傳moodle最新消息
 參數: token:識別碼
 cosid:課程課號
 clsid:開課班號(班別)
 回傳範例:
 {"list":[{"infos":[{"module":"resource","title":"WBSE Homework 3","url":"http://moodle.ntou.edu.tw/mod/resource/view.php?id=75192"},{"module":"assignment","title":"WBSE Homework 3","url":"http://moodle.ntou.edu.tw/mod/assignment/view.php?id=75193"},{"module":"resource","title":"第三次作業上傳位址","url":"http://moodle.ntou.edu.tw/mod/resource/view.php?id=75194"},{"module":"resource","title":"下週考試地點：INS B14","url":"http://moodle.ntou.edu.tw/mod/resource/view.php?id=75929"}],"cosid":"B5704R2A","course_name":"1011_網際服務軟體工程A","clsid":"A"}]}
 
 */
+(NSDictionary *)GetMoodleInfo_AndUseToken:(NSString *)token
                                  courseID:(NSString *)cosID
                                   classID:(NSString *)clsID;


/*
 依照學生學號與課號，回傳該生在moodle上作業成績等
 參數: token:識別碼
 cosid:課程課號
 clsid:開課班號(班別)
 回傳範例:
 {"list":[{"id":"4145","name":"WBSE Homework 1","grade":"7","comment":"檔案結構錯誤\r\nweb.xml設定錯誤，無法直接連線\r\nhtml sumbit 404 failed","end":"1350453600"},{"id":"4307","name":"WBSE Homework 2","grade":"8","comment":"補demo八折分數","end":"1352822400"},{"id":"4408","name":"WBSE Homework 3","end":"0"},{"id":"4637","name":"期末專案","end":"1357723800"}]}
 */
+(NSDictionary *)GetGrade_AndUseToken:(NSString *)token
                                  courseID:(NSString *)cosID
                                   classID:(NSString *)clsID;



/*
 依照課號等資訊，回傳moodle上實際使用之id
 EX: 作業系統的實際課程課號是B5703660，但其實moodle都有一個id來使用，作業系統在moodle上的id就是19391
     
 參數: token:識別碼
 cosid:課程課號
 clsid:開課班號(班別)
 
 */

+(NSDictionary *)GetMoodleID_AndUseToken:(NSString *)token
                                courseID:(NSString *)cosID
                                 classID:(NSString *)clsID;
@end
