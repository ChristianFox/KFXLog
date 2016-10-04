

#import <Foundation/Foundation.h>

@interface DEMOLogExamples : NSObject


//--------------------------------------------------------
#pragma mark - Standard Logs
//--------------------------------------------------------
-(void)logInfo;
-(void)logNotice;
-(void)logWarning;
-(void)logFail;
-(void)logInfoFullTests;
-(void)logNoticeFullTests;
-(void)logWarningFullTests;
-(void)logFailFullTests;
-(void)logCustomPrefix;
-(void)logCustomPrefixFullTests;

//--------------------------------------------------------
#pragma mark - Errors & Exceptions
//--------------------------------------------------------
-(void)logError;
-(void)logErrorIfExists;
-(void)logException;
-(void)logUncaughtException;

//--------------------------------------------------------
#pragma mark - Object Lifecycle Logs
//--------------------------------------------------------
-(void)logConfiguredObject;
-(void)logInitilisedObject;
-(void)logWillDeallocateObject;

//--------------------------------------------------------
#pragma mark - Method Lifecycle Logs
//--------------------------------------------------------
-(void)logMethodStart;
-(void)logMethodEnd;


//--------------------------------------------------------
#pragma mark - UI Logs
//--------------------------------------------------------
-(void)logUIEvent;
-(void)logUIEventFullTests;

//--------------------------------------------------------
#pragma mark - Notification Logs
//--------------------------------------------------------
-(void)logNotificationPosted;
-(void)logNotificationReceived;

//--------------------------------------------------------
#pragma mark - Value Lifecycle Logs
//--------------------------------------------------------
-(void)logObjectChanged;
-(void)logNumberChanged;


//--------------------------------------------------------
#pragma mark - Log Collections
//--------------------------------------------------------
-(void)logArrayWithContents;
-(void)logArrayWithoutContents;
-(void)logDictionaryWithContents;
-(void)logDictionaryWithoutContents;
-(void)logSetWithContents;
-(void)logSetWithoutContents;


//--------------------------------------------------------
#pragma mark - Progress & Success
//--------------------------------------------------------
-(void)logProgress;
-(void)logSuccess;
-(void)logValidity;
-(void)logProgressFullTests;
-(void)logSuccessFullTests;
-(void)logValidityFullTests;


//--------------------------------------------------------
#pragma mark - Blocks
//--------------------------------------------------------
-(void)logBlockStart;
-(void)logBlockEnd;

//--------------------------------------------------------
#pragma mark - Threads, Queues, Operations
//--------------------------------------------------------
-(void)logThread;
-(void)logQueue;
-(void)logOperation;
-(void)logOperationQueue;
-(void)logThreadFullTests;
-(void)logQueueFullTests;
-(void)logOperationFullTests;
-(void)logOperationQueueFullTests;


//--------------------------------------------------------
#pragma mark - URLs
//--------------------------------------------------------
-(void)logSendToURL;
-(void)logReceivedFromURL;

//--------------------------------------------------------
#pragma mark - Search, Filter, Compare
//--------------------------------------------------------
-(void)logPredicate;
-(void)logSearchString;
-(void)logComparison;
-(void)logEquality;







@end





























