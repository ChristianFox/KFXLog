

/**********************************************************************
 *
 Copyright (c) 2016 Christian Fox <christianfox890@icloud.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 *
 **********************************************************************/





#import "KFXLogFileDetailVC.h"
// Frameworks
@import MessageUI;
// Pods
#import <KFXLog/KFXLog.h>

@interface KFXLogFileDetailVC () <MFMailComposeViewControllerDelegate, UISearchBarDelegate>

@property (strong, nonatomic)  UITextView *textView;
@property (strong,nonatomic) NSString *filePath;
@property (strong,nonatomic) UISearchBar *searchBar;
@end

@implementation KFXLogFileDetailVC




//======================================================
#pragma mark - ** Public Methods **
//======================================================
-(void)injectLogFilePath:(NSString *)filePath{
    self.filePath = filePath;
    if (self.textView != nil) {
        [self refreshTextViewText];
    }
}


//======================================================
#pragma mark - ** Inherited Methods **
//======================================================
//--------------------------------------------------------
#pragma mark - UIViewController
//--------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // ## Add Text View ##
    CGRect textViewFrame = self.view.bounds;
    self.textView = [[UITextView alloc]initWithFrame:textViewFrame];
    self.textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.textView.textContainerInset = UIEdgeInsetsMake(50.0, 0.0, 0.0, 0.0);
    [self.view addSubview:self.textView];
    
    // ## Add Search Bar ##
    self.searchBar = [[UISearchBar alloc]init];
    self.searchBar.delegate = self;
    self.searchBar.returnKeyType = UIReturnKeyDone;
    self.searchBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.searchBar];

    if (self.navigationController.navigationBar != nil) {
        // ## Add Bar Buttons ##
        UIBarButtonItem *emailButton = [[UIBarButtonItem alloc]initWithTitle:@"Email" style:UIBarButtonItemStylePlain target:self action:@selector(emailButtonTapped:)];
        UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshButtonTapped:)];
        UIBarButtonItem *jumpToEndButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(jumpToBottomButtonTapped:)];
        UIBarButtonItem *jumpToStartButton  = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(jumpToTopButtonTapped:)];;
        
        self.navigationItem.rightBarButtonItems = @[emailButton,refreshButton,jumpToEndButton,jumpToStartButton];
    }

    // ## Display file log text ##
    if (self.filePath != nil) {
        [self refreshTextViewText];
    }

    // The search bar needs to have constraints set
    [self.view setNeedsUpdateConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)updateViewConstraints{
    
    [self.view removeConstraints:self.view.constraints];
    NSDictionary *viewsDict = @{@"searchBar":self.searchBar};
    CGFloat searchBarOriginY = 0.0;
    if (self.navigationController.navigationBar != nil) {
        searchBarOriginY += self.navigationController.navigationBar.bounds.size.height;
    }
    if (![UIApplication sharedApplication].isStatusBarHidden) {
        searchBarOriginY += 20.0;
    }
    
    NSDictionary *metrics = @{@"searchBarY":@(searchBarOriginY)};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[searchBar]|"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:viewsDict]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-searchBarY-[searchBar(50)]"
                                                                      options:kNilOptions
                                                                      metrics:metrics
                                                                        views:viewsDict]];
    

    [super updateViewConstraints];
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
    
    [self refreshTextViewText];
    
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


//--------------------------------------------------------
#pragma mark - UISearchBarDelegate
//--------------------------------------------------------
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    [self highlightInstancesOfString:searchText];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
}


-(void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [self.view setNeedsUpdateConstraints];
}

//======================================================
#pragma mark - ** Private Methods **
//======================================================
-(void)refreshTextViewText{
    NSAttributedString *attString = [[NSAttributedString alloc]initWithString:[self textFromFileAtPath:self.filePath]
                                                                   attributes:nil];
    
    self.textView.attributedText = attString;
}


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


-(void)highlightInstancesOfString:(NSString*)needle{
    
    // Clear old highlights first
    NSMutableAttributedString *mutAttString = [self.textView.attributedText mutableCopy];
    [mutAttString removeAttribute:NSBackgroundColorAttributeName range:NSMakeRange(0, mutAttString.length)];
    self.textView.attributedText = [mutAttString copy];
    
    NSDictionary *highlightAttributes = @{NSBackgroundColorAttributeName:[UIColor greenColor]};
    NSString *haystack = self.textView.attributedText.string;

    // From: http://stackoverflow.com/questions/7033574/find-all-locations-of-substring-in-nsstring-not-just-first
    
    NSRange searchRange = NSMakeRange(0,haystack.length);
    NSRange foundRange;
    while (searchRange.location < haystack.length) {
        searchRange.length = haystack.length-searchRange.location;
        foundRange = [haystack rangeOfString:needle options:NSCaseInsensitiveSearch range:searchRange];
        if (foundRange.location != NSNotFound) {
            // found an occurrence of the substring! do stuff here
            searchRange.location = foundRange.location+foundRange.length;
            [mutAttString beginEditing];
            [mutAttString addAttribute:NSBackgroundColorAttributeName
                              value:[UIColor greenColor]
                              range:foundRange];
            [mutAttString endEditing];
        } else {
            // no more substring to find
            self.textView.attributedText = [mutAttString copy];
            break;
        }
    }

    
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
