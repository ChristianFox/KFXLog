
# Change Log #

## v1.5.0 | Improved swift support
- Un-deprecated methods that were previously deprecated in v1.1.0. These were methods that took a string argument but were superseeded by methods that took a format string argument. These methods port nicely to swift so have been re-precated(?).  
- Added +logResult as an alternative to +logSuccess

## v1.4.0 | Removed -logWillDeallocateObject:

## v1.3.1 - bug fixes

## v1.3.0
- Adds shouldLogOnBackgroundQueue flag to KFXLogConfigurator and sets to default to NO


## [1.2.0]

#### Fixed 
- Log File Viewer search bar autolayout fixes

#### Changes

#### Enhancements
- Improvements to Log File Viewer.
    - Display number of matches
    - Previous & next match buttons
- File Logs can now be deleted after x days by calling -purgeLogFilesOlderThan: withError: method of KFXLogConfigurator


## [1.1.0](https://github.com/ChristianFox/KFXLog/releases/tag/1.1.0) 2016/10/04

#### Fixed 

- Fixed bug which would cause custom prefixes to not be enclosed in bookends
- Fixed bug which meant uncaught exception setting was ignored

#### Changes

- Changed default file log directory from /Documents to /Application Support/LogFiles
- Changed log file naming system from abbreviated (Dy, Wk, Mo etc) to full (Day, Week, Month etc)

#### Enhancements

- Added methods to replace those that take a standard NSString with methods that take a format string instead.

	Eg.

	```+(void)logInfo:(NSString*)message sender:(id)sender; ```

	Is superseeded by 

	``` +(void)logInfoWithSender:(id)sender format:(NSString*)format,...; ```
	
	Old methods are still available but deprecated.

- Added methods that take a format string but without the sender parameter. 

	Eg.
	
	``` +(void)logInfo:(NSString*)format,...; ```
	
- Added new log methods for 'NOTICE' & 'OPERATION_QUEUE'

- Added a new log method for logging NSError that does not log if the error is nil
	``` +(void)logErrorIfExists:(NSError *)error sender:(i)sender; ```

- Adds some UI classes to provide a log files viewer.

#### Example project
- Made improvements to the example project





## [1.0.0](https://github.com/ChristianFox/KFXLog/releases/tag/1.0.0) 2016/10/04

Initial Release
