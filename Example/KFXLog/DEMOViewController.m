


#import "DEMOViewController.h"
#import "KFXLog.h"

@interface DEMOViewController ()

@end

@implementation DEMOViewController



//======================================================
#pragma mark - ** Public Methods **
//======================================================
//--------------------------------------------------------
#pragma mark - UIViewController
//--------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    // logs that will appear as alerts if the KFXLogToAlert bit is set for current build configuration
    [KFXLog logWarning:@"This is a warning, warning, warning" sender:self];
    //    [KFXLog logInfo:@"This is for an alert" sender:self];
    //    [KFXLog logWillDeallocateObject:self];
//    NSError *error = [NSError errorWithDomain:@"com.company.app.other"
//                                         code:666
//                                     userInfo:@{NSLocalizedDescriptionKey:@"Uh-Oh some error happened"}];
//    [KFXLog logError:error sender:self];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//--------------------------------------------------------
#pragma mark - Actions
//--------------------------------------------------------





//======================================================
#pragma mark - ** Protocol Methods **
//======================================================





//======================================================
#pragma mark - ** Private Methods **
//======================================================
//--------------------------------------------------------
#pragma mark - Lazy Load
//--------------------------------------------------------





//======================================================
#pragma mark - ** Navigation **
//======================================================
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}




@end
