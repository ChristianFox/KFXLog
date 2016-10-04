//
//  DEMOLogTypeBitMaskTests.m
//  KFXLog
//
//  Created by Leu on 03/10/2016.
//  Copyright © 2016 Christian Fox. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <KFXLog/KFXLog.h>

@interface DEMOLogTypeBitMaskTests : XCTestCase

@end

@implementation DEMOLogTypeBitMaskTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testLogTypeValues{

    // Not really a unit test but I needed to check the values to make sure the LL (long long) thing was working
    NSLog(@"%@ : KFXLogTypeNone",@(KFXLogTypeNone));
    NSLog(@"%@ : KFXLogTypeInfo",@(KFXLogTypeInfo));
    NSLog(@"%@ : KFXLogTypeWarning",@(KFXLogTypeWarning));
    NSLog(@"%@ : KFXLogTypeFail",@(KFXLogTypeFail));
    NSLog(@"%@ : KFXLogTypeError",@(KFXLogTypeError));
    NSLog(@"%@ : KFXLogTypeException",@(KFXLogTypeException));
    NSLog(@"%@ : KFXLogTypeConfiguredObject",@(KFXLogTypeConfiguredObject));
    NSLog(@"%@ : KFXLogTypeInitilisedObject",@(KFXLogTypeInitilisedObject));
    NSLog(@"%@ : KFXLogTypeWillDeallocateObject",@(KFXLogTypeWillDeallocateObject));
    NSLog(@"%@ : KFXLogTypeMethodStart",@(KFXLogTypeMethodStart));
    NSLog(@"%@ : KFXLogTypeMethodEnd",@(KFXLogTypeMethodEnd));
    NSLog(@"%@ : KFXLogTypeObjectChanged",@(KFXLogTypeObjectChanged));
    NSLog(@"%@ : KFXLogTypeNumberChanged",@(KFXLogTypeNumberChanged));
    NSLog(@"%@ : KFXLogTypeUIEvent",@(KFXLogTypeUIEvent));
    NSLog(@"%@ : KFXLogTypeNotificationPosted",@(KFXLogTypeNotificationPosted));
    NSLog(@"%@ : KFXLogTypeNotificationReceived",@(KFXLogTypeNotificationReceived));
    NSLog(@"%@ : KFXLogTypeArray",@(KFXLogTypeArray));
    NSLog(@"%@ : KFXLogTypeDictionary",@(KFXLogTypeDictionary));
    NSLog(@"%@ : KFXLogTypeSet",@(KFXLogTypeSet));
    NSLog(@"%@ : KFXLogTypeCustom",@(KFXLogTypeCustom));
    NSLog(@"%@ : KFXLogTypeProgress",@(KFXLogTypeProgress));
    NSLog(@"%@ : KFXLogTypeSuccess",@(KFXLogTypeSuccess));
    NSLog(@"%@ : KFXLogTypeValidity",@(KFXLogTypeValidity));
    NSLog(@"%@ : KFXLogTypeBlockStart",@(KFXLogTypeBlockStart));
    NSLog(@"%@ : KFXLogTypeBlockEnd",@(KFXLogTypeBlockEnd));
    NSLog(@"%@ : KFXLogTypeThread",@(KFXLogTypeThread));
    NSLog(@"%@ : KFXLogTypeQueue",@(KFXLogTypeQueue));
    NSLog(@"%@ : KFXLogTypeOperation",@(KFXLogTypeOperation));
    NSLog(@"%@ : KFXLogTypeSendToURL",@(KFXLogTypeSendToURL));
    NSLog(@"%@ : KFXLogTypeReceiveFromURL",@(KFXLogTypeReceiveFromURL));
    NSLog(@"%@ : KFXLogTypePredicateResult",@(KFXLogTypePredicateResult));
    NSLog(@"%@ : KFXLogTypeSearchString",@(KFXLogTypeSearchString));
    NSLog(@"%@ : KFXLogTypeCompare",@(KFXLogTypeCompare));
    NSLog(@"%@ : KFXLogTypeEquality",@(KFXLogTypeEquality));
    NSLog(@"%@ : KFXLogTypeUncaughtException",@(KFXLogTypeUncaughtException));
    NSLog(@"%@ : KFXLogTypeNotice",@(KFXLogTypeNotice));

    
    
}


@end
