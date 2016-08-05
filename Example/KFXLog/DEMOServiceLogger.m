

#import "DEMOServiceLogger.h"

@implementation DEMOServiceLogger

//======================================================
#pragma mark - ** Public Methods **
//======================================================
//--------------------------------------------------------
#pragma mark - Initilisers
//--------------------------------------------------------
+(instancetype)serviceLogger{
    
    DEMOServiceLogger *logger = [[[self class]alloc]init];
    return logger;
}

//--------------------------------------------------------
#pragma mark - KFXloggerInterface
//--------------------------------------------------------
-(void)logInfo:(NSString*)message sender:(id)sender{
    
    // Send to some web service...
    
    NSLog(@"\n## DEMOSERVICELOG ## <INFO> %@, %@",message,sender);
}


@end
