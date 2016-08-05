# KFXLog


[![Version](https://img.shields.io/cocoapods/v/KFXLog.svg?style=flat)](http://cocoapods.org/pods/KFXLog)
[![License](https://img.shields.io/cocoapods/l/KFXLog.svg?style=flat)](http://cocoapods.org/pods/KFXLog)
[![Platform](https://img.shields.io/cocoapods/p/KFXLog.svg?style=flat)](http://cocoapods.org/pods/KFXLog)

## Example
To run the example project, clone the repo, run the app and watch the console for various log messages, you will also see an alert pop up in the app.

All the configuration is set in the AppDelegate also all console log messages are called from the AppDelegate, you can play around with the configuration properties to see how they effect the formatting.
The alert log is called from DEMOViewController because the sender of the message needs to be a UIViewController subclass.


## Requirements
iOS 8
Xcode 7
* I don't know any reason why it wouldn't work on earlier versions, I just haven't tested it on them.

## Installation

KFXLog is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "KFXLog"
```



## Usage
#### Configuration 
Before calling any of the KFXLog methods you should customise KFXLogConfigurator.

1. Get a reference to the KFXLogConfigurator singleton (do not initilise an instance directly).

    ```objective-c
    KFXLogConfigurator *config = [KFXLogConfigurator sharedConfigurator];
    ```

2. Customise any global settings you want to change from the defaults

    ```objective-c
    config.buildConfiguration = KFXBuildConfigurationDebug;
    config.consoleLogType = KFXConsoleLogTypeClean;
    config.debugLogOptions = KFXLogToConsole | KFXLogToFile | KFXLogToAlert;
    config.adHocLogOptions =  KFXLogToFile | KFXLogToAlert;
    config.releaseLogOptions = KFXLogToFile | KFXLogToService;
    config.shouldCatchUncaughtExceptions = NO;
    ```

3. Customise the descriptors for specific logging mediums (Console, File, Alert, Service) that you need to

    ```objective-c
    [config.cleanLogDescriptor configureWithLogFormat:KFXLogFormatFir];
    config.cleanLogDescriptor.leadingNewLines = 0;
    [config.fileLogDescriptor configureWithLogFormat:KFXLogFormatBirch];
    config.fileLogDescriptor.split = KFXFileLogsSplitByBuild;
    [config.alertLogDescriptor configureWithLogFormat:KFXLogFormatPine];
    config.alertLogDescriptor.whitelist = KFXLogTypeError | KFXLogTypeFail | KFXLogTypeWarning;
    [config.serviceLogDescriptor configureWithLogFormat:KFXLogFormatBalsa];
    ```

4. Create an instance of your service logger class if you are using one and set the serviceLogger property on the configurator

    ```objective-c
    config.serviceLogger = [DEMOServiceLogger serviceLogger];
    ```

5. Print a settings summary if you want to

    ```objective-c
    [config printSettings];
    ```


#### Logging

1. Import ```<KFXLog/KFXLog.h> ```
2. Log

    ```objective-c
    [KFXLog logInfo:@"This is some info." sender:nil];
    [KFXLog logWarning:@"This is a warning, warning, warning" sender:self];
    [KFXLog logError:error sender:self];
    [KFXLog logWithCustomPrefix:@"<MESSAGE!!!>" message:@"This is a message" sender:self];
    [KFXLog logSuccess:success withMessage:@"Log in successful?" sender:self];
    ```


## Architecture

#### Public
- KFXLog 
- KFXLogConfigurator
- KFXLoggerDefinitions
- KFXLogDescriptor
    - KFXBasicLogDescriptor
    - KFXFormattedLogDescriptor
        - KFXCleanLogDescriptor
        - KFXFileLogDescriptor
        - KFXAlertLogDescriptor
        - KFXServiceLogDescriptor

#### Protocols
- KFXLoggerInterface
    - KFXServiceLoggerInterface (conform to & implement to be able to log to a service)

#### Helpers (Possibly useful if you are implementing a service logger)
- KFXLogFormatter
- KFXOptionsReader


#### Internal
- KFXLogger
    - KFXAlertLogger
    - KFXConsoleLogger
    - KFXFileLogger


## Threads
KFXLog's methods can be called from any thread quite safely provided you follow one simple rule:

    1. Make your customisations to KFXLogConfigurator before using any of the KFXLog methods.

It is recommended you don't change the configuration settings of KFXLogConfigurator once set. The properties are nonatomic and so not thread safe. If you only set the configuration settings before you start logging then you can call the methods of KFXLog from any thread without any issues as internally we only read from those properties. I considered making all the configuration properties atomic but the overhead seemed unnecessary because even if all the properties were thread safe it still makes more sense to keep the configuration settings the same for the lifetime of the application.


## Common Tasks

#### Logging to Console

1. Open AppDelegate.m
2. Add: #import "KFXLogConfigurator.h"
3. In -application: didFinishLaunchingWithOptions:

    ```objective-c
    KFXLogConfigurator *config = [KFXLogConfigurator sharedConfigurator];
    config.buildConfiguration = KFXBuildConfigurationDebug;
    // Set to clean (print) or standard (NSLog)
    config.consoleLogType = KFXConsoleLogTypeClean; 
    config.debugLogMediums = KFXLogMediumConsole;
    // Set your log format style (look at KFXFormattedLogDescriptor to see the options)
    [config.cleanLogDescriptor configureWithLogFormat:KFXLogFormatFir];

    ```

4. Then start logging.

    ```objective-c
    [KFXLog logConfiguredObject:config sender:self];

    ```


#### Logging to Files

1. Open AppDelegate.m
2. Add: #import "KFXLogConfigurator.h"
3. In -application: didFinishLaunchingWithOptions:

    ```objective-c
    KFXLogConfigurator *config = [KFXLogConfigurator sharedConfigurator];
    config.buildConfiguration = KFXBuildConfigurationDebug;
    config.debugLogMediums = KFXLogMediumFile;
    // Set your log format style (look at KFXFormattedLogDescriptor to see the options)
    [config.fileLogDescriptor configureWithLogFormat:KFXLogFormatOak];

    ```

4. Then start logging.

    ```objective-c
    [KFXLog logConfiguredObject:config sender:self];

    ```

#### Logging to Alerts

1. Open AppDelegate.m
2. Add: #import "KFXLogConfigurator.h"
3. In -application: didFinishLaunchingWithOptions:

    ```objective-c
    KFXLogConfigurator *config = [KFXLogConfigurator sharedConfigurator];
    config.buildConfiguration = KFXBuildConfigurationDebug;
    config.debugLogMediums = KFXLogMediumAlert;
    // Set your log format style (look at KFXFormattedLogDescriptor to see the options)
    [config.alertLogDescriptor configureWithLogFormat:KFXLogCherry];

    ```

4. Then start logging.

    ```objective-c
    [KFXLog logConfiguredObject:config sender:self];

    ```

#### Logging to a Service

1. Create a new class to act as the ServiceLogger, make it conform to KFXServiceLoggerInterface protocol (inherits from KFXLoggerInterface)
2. Implement any of the optional methods defined in the protocol KFXLoggerInterface so that your implementation sends the message etc to your WebService.

3. Open AppDelegate.m
4. Add: #import "KFXLogConfigurator.h" + Your service logger class
5. In -application: didFinishLaunchingWithOptions:

    ```objective-c
    KFXLogConfigurator *config = [KFXLogConfigurator sharedConfigurator];
    config.buildConfiguration = KFXBuildConfigurationDebug;
    config.debugLogMediums = KFXLogMediumService;
    // Set your log format style (look at KFXFormattedLogDescriptor to see the options)
    [config.serviceLogDescriptor configureWithLogFormat:KFXLogMaple];
    // Set your class as the serviceLogger
    config.serviceLogger = [[DEMOServiceLogger alloc]init];

    ```

6. Then start logging.

    ```objective-c
    [KFXLog logConfiguredObject:config sender:self];

    ```


## Log Format Styles

For the subclasses of KFXFormattedLogDescriptor there are many properties you can change. To simplify things a bit I've set up a bunch of styles which can you use with the Enum KFXLogFormat like so:

    [config.fileLogDescriptor configureWithLogFormat:KFXLogFormatBirch];

You can take a look in KFXFormattedLogDescriptor.m to see the settings for each style - I couldn't think of a more user friendly place to do it. I've including some samples of each style below. Find one that is close to what you want and then tweak the settings to your liking.


##### KFXLogFormatFir

    ◎ <INFO>                    This is some info.; Sender: <AppDelegate: 0x7fb220d01eb0>;
    ◎ <WARNING>                 This is a warning, warning, warning; Sender: <AppDelegate: 0x7fb220d01eb0>;

##### KFXLogFormatAsh

    ◎  [8/5/16, 4:49:59 PM] <INFO>          This is some info.; Sender: AppDelegate;

    ◎  [8/5/16, 5:08:33 PM] <WARNING>       This is a warning, warning, warning; Sender: AppDelegate;

##### KFXLogFormatWalnut

    <INFO> This is some info.;
    <WARNING> This is a warning, warning, warning;

##### KFXLogFormatTeak

    <INFO> This is some info.; Sender: <AppDelegate: 0x7fde0be079a0>;
    <WARNING> This is a warning, warning, warning; Sender: <AppDelegate: 0x7fde0be079a0>;

##### KFXLogFormatBalsa

    * [INFO]         This is some info.;

    * [WARNING]      This is a warning, warning, warning;

##### KFXLogFormatMahogany

    • <INFO>--------- This is some info.; Sender: <AppDelegate: 0x7f990a508330>;
    • <WARNING>------ This is a warning, warning, warning; Sender: <AppDelegate: 0x7f990a508330>;

##### KFXLogFormatBirch

    ★ [8/5/16, 5:10:44 PM] <INFO>~~~~~~~~~~~~~~~~~~~ This is some info.; Sender: AppDelegate; <AppDelegate: 0x7fddeaf0b840>;

    ★ [8/5/16, 5:10:44 PM] <WARNING>~~~~~~~~~~~~~~~~ This is a warning, warning, warning; Sender: AppDelegate; <AppDelegate: 0x7fddeaf0b840>;


##### KFXLogFormatOak

    ##  [8/5/16, 5:11:28 PM] _________________<*INFO*> Sender: <AppDelegate: 0x7fd9b8411a30>; This is some info.;
    ##  [8/5/16, 5:11:28 PM] ______________<*WARNING*> Sender: <AppDelegate: 0x7fd9b8411a30>; This is a warning, warning, warning;


##### KFXLogFormatPine

    [8/5/16, 5:12:08 PM] !INFO! This is some info.;
    [8/5/16, 5:12:08 PM] !WARNING! This is a warning, warning, warning;

##### KFXLogFormatMaple

    (INFO)             This is some info.;
    (WARNING)          This is a warning, warning, warning;

##### KFXLogFormatCherry

    (INFO) Sender: AppDelegate; This is some info.;
    (WARNING) Sender: AppDelegate; This is a warning, warning, warning;

##### KFXLogFormatRedwood

    + [8/5/16, 5:13:58 PM] [INFO]______________ Sender: <AppDelegate: 0x7fe5cae05b80>; This is some info.;

    + [8/5/16, 5:13:58 PM] [WARNING]___________ Sender: <AppDelegate: 0x7fe5cae05b80>; This is a warning, warning, warning;


##### KFXLogFormatHolly

    Δ [8/5/16, 5:14:27 PM]            [INFO] This is some info.; Sender: <AppDelegate: 0x7ffa93507340>;
    Δ [8/5/16, 5:14:27 PM]         [WARNING] This is a warning, warning, warning; Sender: <AppDelegate: 0x7ffa93507340>;


## Author

Christian Fox, christianfox@kfxtech.com

## License

KFXLog is available under the MIT license. See the LICENSE file for more info.
