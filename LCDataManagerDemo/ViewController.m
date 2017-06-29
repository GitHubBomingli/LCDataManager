//
//  ViewController.m
//  LCDataManagerDemo
//
//  Created by 伯明利 on 2017/6/29.
//  Copyright © 2017年 伯明利. All rights reserved.
//

#import "ViewController.h"
#import <LCDataManager/LCDataManager.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [LCDataManager valueChangedForKey:@"messageKey" reuseIdentifier:@"reuseIdentifierForViewController" changed:^(id object, id oldObject) {
        if (object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.messageLabel.text = (NSString *)object;
            });
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
