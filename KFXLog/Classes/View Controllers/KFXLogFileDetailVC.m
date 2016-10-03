

#import "KFXLogFileDetailVC.h"
// Frameworks
@import MessageUI;
// Pods
#import <KFXLog/KFXLog.h>

@interface KFXLogFileDetailVC () <MFMailComposeViewControllerDelegate>

@property (strong, nonatomic)  UITextView *textView;
@property (strong,nonatomic) NSString *filePath;
@end

@implementation KFXLogFileDetailVC




//======================================================
#pragma mark - ** Public Methods **
//======================================================
-(void)injectLogFilePath:(NSString *)filePath{
    self.filePath = filePath;
    if (self.textView != nil) {
        self.textView.text = [self textFromFileAtPath:self.filePath];
    }
}

//--------------------------------------------------------
#pragma mark - UIViewController
//--------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // ## Create Text View ##
    self.textView = [[UITextView alloc]initWithFrame:self.view.bounds];
    self.textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.textView];
    
    if (self.filePath != nil) {
        self.textView.text = [self textFromFileAtPath:self.filePath];
    }

    // ## Add Bar Buttons ##
    UIBarButtonItem *emailButton = [[UIBarButtonItem alloc]initWithTitle:@"Email" style:UIBarButtonItemStylePlain target:self action:@selector(emailButtonTapped:)];
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshButtonTapped:)];
    UIBarButtonItem *jumpToEndButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(jumpToBottomButtonTapped:)];
    UIBarButtonItem *jumpToStartButton  = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(jumpToTopButtonTapped:)];;
    
    self.navigationItem.rightBarButtonItems = @[emailButton,refreshButton,jumpToEndButton,jumpToStartButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//--------------------------------------------------------
#pragma mark - Actions
//--------------------------------------------------------
-(IBAction)emailButtonTapped:(id)sender{
    
    
    if (![MFMailComposeViewController canSendMail]) {
        [KFXLog logFail:@"Cannot send mail from this device"];
        return;
    }
    
    
    NSString *subject = [self.filePath lastPathComponent];
    
    MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc]init];
    [mailVC setMailComposeDelegate:self]; // Note the delegate is called MailComposeDelegate
    [mailVC setSubject:subject];
    NSData *data = [[NSFileManager defaultManager]contentsAtPath:self.filePath];
    if (data == nil) {
        [mailVC setMessageBody:self.textView.text isHTML:NO];
    }else{
        
        [mailVC addAttachmentData:data
                         mimeType:@"text/plain"
                         fileName:[self.filePath lastPathComponent]];
    }
    [self presentViewController:mailVC animated:YES completion:NULL];
}

-(IBAction)refreshButtonTapped:(id)sender{
    
    self.textView.text = [self textFromFileAtPath:self.filePath];
    
}

-(IBAction)jumpToTopButtonTapped:(id)sender{
    [self.textView scrollRangeToVisible:NSMakeRange(0, 0)];
}

-(IBAction)jumpToBottomButtonTapped:(id)sender{
    [self.textView scrollRangeToVisible:NSMakeRange([self.textView.text length], 0)];
    
}

//======================================================
#pragma mark - ** Protocol Methods **
//======================================================
//--------------------------------------------------------
#pragma mark - MFMailComposeViewControllerDelegate
//--------------------------------------------------------
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MFMailComposeResultSent:
            [KFXLog logInfo:@"Sent Log File by Email"];
            break;
        case MFMailComposeResultSaved:
            [KFXLog logInfo:@"Saved email with log file"];
            break;
        case MFMailComposeResultFailed:
            [KFXLog logInfo:@"Log file sending by email failed"];
            break;
        case MFMailComposeResultCancelled:
            [KFXLog logInfo:@"Log file email sending cancelled"];
            break;
            
        default:
            break;
    }
    
    if (error != nil) {
        [KFXLog logError:error sender:self];
    }
}






//======================================================
#pragma mark - ** Private Methods **
//======================================================
-(NSString*)textFromFileAtPath:(NSString*)filePath{
    
    NSString *logText;
    NSFileManager *fileMan = [NSFileManager defaultManager];
    if ([fileMan fileExistsAtPath:filePath]) {
        
        NSError *error;
        logText = [[NSString alloc]initWithContentsOfFile:filePath
                                                 encoding:NSUTF8StringEncoding
                                                    error:&error];
        if (logText == nil) {
            [KFXLog logFail:@"Failed to get text from log file at path: %@",filePath];
            if (error) {
                [KFXLog logError:error sender:self];
            }
        }
    }
    return logText;
    
}

//--------------------------------------------------------
#pragma mark - Lazy Load
//--------------------------------------------------------





//======================================================
#pragma mark - ** Navigation **
//======================================================
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}



@end
