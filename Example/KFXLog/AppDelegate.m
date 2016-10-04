


#import "AppDelegate.h"
#import "KFXLogConfigurator.h"
#import "KFXLog.h"
#import "DEMOServiceLogger.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    /***
     Quick Start Guide:
     1. Get a reference to the KFXLogConfigurator singleton (do not initilise an instance directly)
     2. Customise any global settings you want to change from the defaults
     3. Customise the descriptors you need to
     4. Create an instance of your service logger class if you are using one and set the serviceLogger property on the configurator
     5. Print a settings summary if you want to
     ***/
    
    // 1.
    KFXLogConfigurator *config = [KFXLogConfigurator sharedConfigurator];
    
    // 2.
    // ## Global Settings
    config.buildConfiguration = KFXBuildConfigurationDebug;
    config.consoleLogType = KFXConsoleLogTypeClean;
    config.debugLogMediums = KFXLogMediumConsole | KFXLogMediumFile | KFXLogMediumAlert;
    config.adHocLogMediums =  KFXLogMediumFile | KFXLogMediumAlert;
    config.releaseLogMediums = KFXLogMediumFile | KFXLogMediumService;
    config.shouldCatchUncaughtExceptions = YES;
    
    // 3.
    // ## Log Descriptors ##
    // ### BasicLogDescriptor ###
    config.basicLogDescriptor.showSender = KFXShowSenderClassOnly;
    config.basicLogDescriptor.senderPlacement = KFXSenderPlacementEnd;
    
    // ### CleanLogDescriptor ###
    [config.cleanLogDescriptor configureWithLogFormat:KFXLogFormatFir];
    config.cleanLogDescriptor.blacklist = KFXLogTypeNone;
    config.cleanLogDescriptor.showSender = KFXShowSenderClassOnly;
    
    // ### FileLogDescriptor ###
    [config.fileLogDescriptor configureWithLogFormat:KFXLogFormatBirch];
//    config.fileLogDescriptor.directoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    config.fileLogDescriptor.fileNameBase = @"Logs";
    config.fileLogDescriptor.split = KFXFileLogsSplitByBuild;
    config.fileLogDescriptor.showDate = YES;

    // ### AlertLogDescriptor ###
    [config.alertLogDescriptor configureWithLogFormat:KFXLogFormatPine];
    config.alertLogDescriptor.whitelist = KFXLogTypeError | KFXLogTypeFail | KFXLogTypeWarning;
    config.alertLogDescriptor.showDate = NO;

    // ### ServiceLogDescriptor  ###
    [config.serviceLogDescriptor configureWithLogFormat:KFXLogFormatBalsa];
    
    // 4.
    // ## Service Logger (custom class that conforms to KFXServiceLogger protocol ##
    config.serviceLogger = [DEMOServiceLogger serviceLogger];
    
    // 5.
    // Log a summary of the current settings to the console
    [config printSettings];
    
    
    
    // # Test Logs #
    // NB. I do know how to do unit tests but as the verification will be done by looking at the console it makes more sense to do tests here
    [self testLogInfo];
    [self testLogWarning];
    [self testLogFail];
    [self testLogError];
    [self testLogConfiguredObject];
    [self testLogInitilisedObject];
    [self testLogWillDeallocateObject];
    [self testLogMethodStart];
    [self testLogMethodEnd];
    [self testLogUIEvent];
    [self testLogNotificationPosted];
    [self testLogNotificationReceived];
    [self testLogObjectChange];
    [self testLogNumberChange];
    [self testLogException];
    [self testLogWithCustomPrefix];
    [self testLogArrayWithCountAndClassesAndNesting];
    [self testLogDictionaryWithCountAndClassesAndNesting];
    [self testLogSetWithAllCountAndClassesAndNesting];
    [self testLogProgress];
    [self testLogSuccess];
    [self testLogValidity];
    [self testLogBlockStart];
    [self testLogBlockEnd];
    [self testLogThread];
    [self testLogQueue];
    [self testLogOperation];
    [self testLogSendToURL];
    [self testLogReceivedFromURL];
    [self testLogPredicateWithResult];
    [self testLogSearchString];
    [self testLogComparisonWithObjects];
    [self testLogEquality];
    [self testLogNotice];
    
    /* 
     Commented out because they take up loads of space in the console, feel free to uncomment
     */
//    [self testLogArrayWithAllOptions];
//    [self testLogDictionaryWithAllOptions];
//    [self testLogSetWithAllOptions];
    
    /* 
     Commented out because this method deliberately causes a crash, feel free to uncomment
     */
    [self testLogUncaughtException];

    
        return YES;
}


-(void)testLogInfo{
  //  [KFXLog logInfo:@"This is some info." sender:self]; // deprecated
    [KFXLog logInfo:nil];
    [KFXLog logInfo:@"This is some info with a number: %@",@665];
    [KFXLog logInfoWithSender:nil format:nil];
    [KFXLog logInfoWithSender:self format:nil];
    [KFXLog logInfoWithSender:nil format:@"This is some info with a number: %@",@665];
    [KFXLog logInfoWithSender:self format:@"Info without args"];

}

-(void)testLogWarning{
  //  [KFXLog logWarning:@"This is a warning, warning, warning" sender:self];  // deprecated
    [KFXLog logWarning:nil];
    [KFXLog logWarning:@"This is a warning, warning, %@",@"warning"];
    [KFXLog logWarningWithSender:nil format:nil];
    [KFXLog logWarningWithSender:self format:nil];
    [KFXLog logWarningWithSender:nil format:@"This is a warning, warning, %@",@"warning"];
    [KFXLog logWarningWithSender:self format:@"This is a warning, warning, %@",@"warning"];
    [KFXLog logWarningWithSender:self format:@"Warning without args"];

    
}

-(void)testLogFail{
 //   [KFXLog logFail:@"Something has failed." sender:self];  // deprecated
    [KFXLog logFail:nil];
    [KFXLog logFail:@"Reporting a failure makes me %@",@":]"];
    [KFXLog logFailWithSender:nil format:nil];
    [KFXLog logFailWithSender:self format:nil];
    [KFXLog logFailWithSender:nil format:@"Not reporting a failure makes me %@",@"a sad panda"];
    [KFXLog logFailWithSender:self format:@"Failure is just %@ that hasn't happened yet", @"success"];
    [KFXLog logFailWithSender:self format:@"Fail without args"];
}

-(void)testLogError{
    NSError *error = [NSError errorWithDomain:@"com.company.app.other"
                                         code:666
                                     userInfo:@{NSLocalizedDescriptionKey:@"Uh-Oh some error happened"}];
    [KFXLog logError:error sender:self];
}

-(void)testLogConfiguredObject{
    [KFXLog logConfiguredObject:self sender:self];
}

-(void)testLogInitilisedObject{
    [KFXLog logInitilisedObject:self];
}

-(void)testLogWillDeallocateObject{
    [KFXLog logWillDeallocateObject:self];
}

-(void)testLogMethodStart{
    [KFXLog logMethodStart:@selector(testLogMethodStart) sender:self];
}

-(void)testLogMethodEnd{
    [KFXLog logMethodEnd:@selector(testLogMethodEnd) sender:self];
}

-(void)testLogUIEvent{
 //   [KFXLog logUIEvent:@"Some button tapped or gesture recognised" sender:self];  // deprecated
    [KFXLog logUIEventWithSender:nil format:nil];
    [KFXLog logUIEventWithSender:nil format:@"The user touched a button or something %@",@"#ftw"];
    [KFXLog logUIEventWithSender:self format:@"Did recognise gesture or something %@",@"#awesomeness"];
    
}

-(void)testLogNotificationPosted{
    NSNotification *note = [NSNotification notificationWithName:@"FakeNotification"
                                                         object:nil
                                                       userInfo:@{}];
    [KFXLog logNotificationPosted:note sender:self];
}

-(void)testLogNotificationReceived{
    NSNotification *note = [NSNotification notificationWithName:@"FakeNotification"
                                                         object:nil
                                                       userInfo:@{}];
    [KFXLog logNotificationReceived:note sender:self];
}

-(void)testLogObjectChange{
    [KFXLog logObjectChangeAtKeyPath:@"object.property" oldValue:@99 newValue:@100 sender:self];
}

-(void)testLogNumberChange{
    [KFXLog logNumberChangedAtKeyPath:@"object.property" oldNumber:@100 newNumber:@101 sender:self];
}

-(void)testLogException{
    
    NSException *exception = [[NSException alloc]initWithName:@"Exception Name"
                                                       reason:@"Some Reason"
                                                     userInfo:nil];
    
    [KFXLog logException:exception sender:nil];
}



-(void)testLogWithCustomPrefix{
    
  //  [KFXLog logWithCustomPrefix:@"<BALLS!>" message:@"This is a message" sender:self];  // deprecated
    [KFXLog logWithCustomPrefix:nil format:nil];
    [KFXLog logWithCustomPrefix:@"Le grand prefix" format:nil];
    [KFXLog logWithCustomPrefix:@"nil" format:@"Lolz%@",@"!!!"];
    [KFXLog logWithCustomPrefix:nil sender:nil format:nil];
    [KFXLog logWithCustomPrefix:@"-> HERE" sender:nil format:nil];
    [KFXLog logWithCustomPrefix:nil sender:self format:nil];
    [KFXLog logWithCustomPrefix:nil sender:nil format:@"Some message about %@",@"something"];
    [KFXLog logWithCustomPrefix:@"FULL" sender:self format:@"Some message about %@",@"something"];

}

-(void)testLogArrayWithCountAndClassesAndNesting{
    
    NSArray *array = @[@"one",@"Two",@3,@4,@YES,@9410.123,
                       @[@"Red",@"Orange",@"Blue"],
                       @{@"key1":@"value1",@2:@2},
                       ];
    KFXCollectionLogOptions options = KFXCollectionLogCount | KFXCollectionLogClasses | KFXCollectionLogDepth;
    [KFXLog logArray:array options:options sender:self];
}

-(void)testLogArrayWithAllOptions{
    
    NSArray *array = @[@"one",@"Two",@3,@4,@YES,@9410.123,
                       @[@"Red",@"Orange",@"Blue"],
                       @{@"key1":@"value1",@2:@2},
                       @[@[@"Depth3"]]
                       ];
    KFXCollectionLogOptions options = KFXCollectionLogCount | KFXCollectionLogClasses | KFXCollectionLogDepth | KFXCollectionLogContents;
    [KFXLog logArray:array options:options sender:self];

}

-(void)testLogDictionaryWithCountAndClassesAndNesting{
    
    NSDictionary *dict = @{@"keyA":@"ValueA",@"KeyB":@2,
                           @"keyC":@[@"one",@"Two",@3,@4,@YES,@9410.123,
                                     @[@"Red",@"Orange",@"Blue"],
                                     @{@"key1":@"value1",@2:@2},
                                     @[@[@"Depth3"]]
                                     ]
                           };
    
    KFXCollectionLogOptions options = KFXCollectionLogCount | KFXCollectionLogClasses | KFXCollectionLogDepth;
    [KFXLog logDictionary:dict options:options sender:self];

}
-(void)testLogDictionaryWithAllOptions{
    
    NSDictionary *dict = @{@"keyA":@"ValueA",@"KeyB":@2,
                           @"keyC":@[@"one",@"Two",@3,@4,@YES,@9410.123,
                                     @[@"Red",@"Orange",@"Blue"],
                                     @{@"key1":@"value1",@2:@2},
                                     @[@[@"Depth3"]]
                                     ]
                           };
    
    KFXCollectionLogOptions options = KFXCollectionLogCount | KFXCollectionLogClasses | KFXCollectionLogDepth | KFXCollectionLogContents;
    [KFXLog logDictionary:dict options:options sender:self];
    
}

-(void)testLogSetWithAllCountAndClassesAndNesting{
 
    NSSet *set = [NSSet setWithObjects:@"setObj1",@"setObj2",@{@"keyA":@"ValueA",@"KeyB":@2,
                                                              @"keyC":@[@"one",@"Two",@3,@4,@YES,@9410.123,
                                                                        @[@"Red",@"Orange",@"Blue"],
                                                                        @{@"key1":@"value1",@2:@2},
                                                                        @[@[@"Depth3"]]
                                                                        ]
                                                              }, nil];
    KFXCollectionLogOptions options = KFXCollectionLogCount | KFXCollectionLogClasses | KFXCollectionLogDepth;
    [KFXLog logSet:set options:options sender:self];
}

-(void)testLogSetWithAllOptions{
    
    NSSet *set = [NSSet setWithObjects:@"setObj1",@"setObj2",@{@"keyA":@"ValueA",@"KeyB":@2,
                                                               @"keyC":@[@"one",@"Two",@3,@4,@YES,@9410.123,
                                                                         @[@"Red",@"Orange",@"Blue"],
                                                                         @{@"key1":@"value1",@2:@2},
                                                                         @[@[@"Depth3"]]
                                                                         ]
                                                               }, nil];
    KFXCollectionLogOptions options = KFXCollectionLogCount | KFXCollectionLogClasses | KFXCollectionLogDepth | KFXCollectionLogContents;
    [KFXLog logSet:set options:options sender:self];
}

-(void)testLogProgress{
   // [KFXLog logProgress:0.99 withMessage:@"Downloading images" sender:self];  // deprecated
    [KFXLog logProgress:0.001 withSender:nil format:nil];
    [KFXLog logProgress:0.1111 withSender:nil format:@"Just started, %@",@"errrr..."];
    [KFXLog logProgress:0.5002 withSender:self format:nil];
    [KFXLog logProgress:1.000000 withSender:self format:@"All done, complete, finito, the end, %@",@"fin"];
}

-(void)testLogSuccess{
  //  [KFXLog logSuccess:YES withMessage:@"Log in successful?" sender:self];  // deprecated
    [KFXLog logSuccess:NO withSender:nil format:nil];
    [KFXLog logSuccess:YES withSender:nil format:@"Attempted to do %@",@"xyz"];
    [KFXLog logSuccess:NO withSender:self format:nil];
    [KFXLog logSuccess:YES withSender:self format:@"Save to disk"];
}

-(void)testLogValidity{
 //   [KFXLog logValidity:NO ofObject:self sender:self]; // deprecated
    [KFXLog logValidity:NO ofObject:nil sender:nil format:nil];
    [KFXLog logValidity:(self != nil)  ofObject:self sender:nil format:nil];
    [KFXLog logValidity:NO ofObject:nil sender:self format:nil];
    [KFXLog logValidity:NO ofObject:nil sender:nil format:@"Is %@ valid?",@"nil"];
    [KFXLog logValidity:(self != nil) ofObject:self sender:self format:@"Am @% valid?",@"I"];
    
}

-(void)testLogBlockStart{
    [KFXLog logBlockStartWithName:@"MyGreatBlock" sender:self];
}

-(void)testLogBlockEnd{
    [KFXLog logBlockEndWithName:@"MyGreatBlock" sender:self];
}

-(void)testLogThread{
    NSThread *thread = [NSThread mainThread];
  // [KFXLog logThread:thread withMessage:@"Thread is on the go" sender:self]; // deprecated
    [KFXLog logThread:nil withSender:nil format:nil];
    [KFXLog logThread:thread withSender:nil format:nil];
    [KFXLog logThread:nil withSender:self format:nil];
    [KFXLog logThread:nil withSender:nil format:@"This thread is great!!!  %@",@"..."];
    [KFXLog logThread:thread withSender:self format:@"This thread is called %@",@"Fred"];
    
}

-(void)testLogQueue{
 //   [KFXLog logQueue:@"com.kfx.logger.someQueue" withMessage:@"Queue is up and running" sender:self]; // deprecated
    [KFXLog logQueue:nil withSender:nil format:nil];
    [KFXLog logQueue:@"com.kfx.logger.someQueue" withSender:nil format:nil];
    [KFXLog logQueue:nil withSender:self format:nil];
    [KFXLog logQueue:nil withSender:nil format:@"QQQQ%@QQQ",@"Q"];
    [KFXLog logQueue:@"com.kfx.logger.someQueue" withSender:self format:@"%@82QB4%@P",@"I",@"I"];

    
}

-(void)testLogOperation{
    NSMethodSignature *sig = [self methodSignatureForSelector:@selector(testLogOperation)];
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:sig];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]initWithInvocation:inv];
    operation.name = @"MrOperation";
 //   [KFXLog logOperation:operation withMessage:@"Operation with invocation" sender:self]; // deprecated
    [KFXLog logOperation:nil withSender:nil format:nil];
    [KFXLog logOperation:operation withSender:nil format:nil];
    [KFXLog logOperation:nil withSender:self format:nil];
    [KFXLog logOperation:nil withSender:nil format:@"The operation was a %@ Mrs Smith",@"failure"];
    [KFXLog logOperation:operation withSender:self format:@"The operation was a %@ Mrs Smith",@"success"];
}

-(void)testLogSendToURL{
    NSURL *url = [NSURL URLWithString:@"https://www.google.co.uk"];
    [KFXLog logSendToURL:url sender:self];
}

-(void)testLogReceivedFromURL{
    NSURL *url = [NSURL URLWithString:@"https://www.google.co.uk"];
    [KFXLog logReceivedFromURL:url data:@"important info. gotten from on the line" sender:self];
}

-(void)testLogPredicateWithResult{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"%K = %@",@"someKey",@"someValue"];
    NSArray *result = @[@"Holy Grail", @"Ark of the Covenent", @"Atlantis"];
    [KFXLog logPredicate:pred withResult:result sender:self];
}

-(void)testLogSearchString{
    NSString *string = @"Atlantis";
    [KFXLog logSearchString:string sender:self];
}

-(void)testLogComparisonWithObjects{
    NSString *objA = @"Duck";
    NSString *objB = @"Quacking Machine";
    [KFXLog logComparisonWithObjectA:objA objectB:objB sender:self];
}

-(void)testLogEquality{
    NSString *objA = @"Duck";
    NSString *objB = @"Quacking Machine";
    [KFXLog logEqualityWithObjectA:objA objectB:objB sender:self];
    [KFXLog logEqualityWithObjectA:objA objectB:objA sender:self];

}

-(void)testLogNotice{
    
    [KFXLog logNotice:nil];
    [KFXLog logNotice:@"This is some Notice with a number: %@",@665];
    [KFXLog logNoticeWithSender:nil format:nil];
    [KFXLog logNoticeWithSender:self format:nil];
    [KFXLog logNoticeWithSender:nil format:@"If you notice this notice you will notice that is is not worth %@",@"noticing"];

}


-(void)testLogUncaughtException{
    
    NSArray *array = @[@"One"];
    NSString *two = array[99];
    // To stop unused variable warnings
    NSString *aString = two;
    two = aString;
}


















@end
