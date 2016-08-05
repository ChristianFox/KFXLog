


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
    config.shouldCatchUncaughtExceptions = NO;
    
    // 3.
    // ## Log Descriptors ##
    // ### BasicLogDescriptor ###
    config.basicLogDescriptor.showSender = KFXShowSenderClassOnly;
    config.basicLogDescriptor.senderPlacement = KFXSenderPlacementEnd;
    
    // ### CleanLogDescriptor ###
    [config.cleanLogDescriptor configureWithLogFormat:KFXLogFormatFir];
    config.cleanLogDescriptor.blacklist = KFXLogTypeNone;
    
    // ### FileLogDescriptor ###
    [config.fileLogDescriptor configureWithLogFormat:KFXLogFormatBirch];
    config.fileLogDescriptor.directoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
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
    
    // * Commented out because they take up loads of space in the console, feel free to uncomment
//    [self testLogArrayWithAllOptions];
//    [self testLogDictionaryWithAllOptions];
//    [self testLogSetWithAllOptions];
    
    // * Commented out because this method deliberately causes a crash, feel free to uncomment
//    [self testLogUncaughtException];
    
        return YES;
}


-(void)testLogInfo{
    [KFXLog logInfo:@"This is some info." sender:self];
}

-(void)testLogWarning{
    [KFXLog logWarning:@"This is a warning, warning, warning" sender:self];
}

-(void)testLogFail{
    [KFXLog logFail:@"Something has failed." sender:self];
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
    [KFXLog logUIEvent:@"Some button tapped or gesture recognised" sender:self];
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
    
    [KFXLog logWithCustomPrefix:@"<BALLS!>" message:@"This is a message" sender:self];
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
    [KFXLog logProgress:0.99 withMessage:@"Downloading images" sender:self];
}

-(void)testLogSuccess{
    [KFXLog logSuccess:YES withMessage:@"Log in successful?" sender:self];
}

-(void)testLogValidity{
    [KFXLog logValidity:NO ofObject:self sender:self];
}

-(void)testLogBlockStart{
    [KFXLog logBlockStartWithName:@"MyGreatBlock" sender:self];
}

-(void)testLogBlockEnd{
    [KFXLog logBlockEndWithName:@"MyGreatBlock" sender:self];
}

-(void)testLogThread{
    NSThread *thread = [NSThread mainThread];
    [KFXLog logThread:thread withMessage:@"Thread is on the go" sender:self];
}

-(void)testLogQueue{
    [KFXLog logQueue:@"com.kfx.logger.someQueue" withMessage:@"Queue is up and running" sender:self];
}

-(void)testLogOperation{
    NSMethodSignature *sig = [self methodSignatureForSelector:@selector(testLogOperation)];
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:sig];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]initWithInvocation:inv];
    operation.name = @"MrOperation";
    [KFXLog logOperation:operation withMessage:@"Operation with invocation" sender:self];
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




-(void)testLogUncaughtException{
    
    NSArray *array = @[@"One"];
    NSString *two = array[99];
    // To stop unused variable warnings
    NSString *aString = two;
    two = aString;
}


















@end
