


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
    config.fileLogDescriptor.fileNameBase = @"Logs";
    config.fileLogDescriptor.split = KFXFileLogsSplitByBuild;
    config.fileLogDescriptor.showDate = YES;

    // ### AlertLogDescriptor ###
    [config.alertLogDescriptor configureWithLogFormat:KFXLogFormatPine];
    config.alertLogDescriptor.whitelist = KFXLogTypeNotice;
    config.alertLogDescriptor.showDate = NO;

    // ### ServiceLogDescriptor  ###
    [config.serviceLogDescriptor configureWithLogFormat:KFXLogFormatBalsa];
    
    // 4.
    // ## Service Logger (custom class that conforms to KFXServiceLogger protocol ##
    config.serviceLogger = [DEMOServiceLogger serviceLogger];
    
    // 5.
    // Log a summary of the current settings to the console
    [config printSettings];
    
    return YES;
}

















@end
