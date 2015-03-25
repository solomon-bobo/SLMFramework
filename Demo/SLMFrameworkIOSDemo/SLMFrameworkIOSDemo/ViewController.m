//
//  ViewController.m
//  SLMFrameworkIOSDemo
//
//  Created by solomon on 3/24/15.
//  Copyright (c) 2015 solomon. All rights reserved.
//

#import "ViewController.h"
#import "SLMFramework.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *jsonString = @"{\"key\":\"value\",\"key1\":null}";
    
    NSDictionary *dictionary = [jsonString slm_JSONValue];
    
    SLMLogObject(dictionary);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
