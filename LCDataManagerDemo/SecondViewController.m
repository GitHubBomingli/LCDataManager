//
//  SecondViewController.m
//  LCDataManagerDemo
//
//  Created by 伯明利 on 2017/6/29.
//  Copyright © 2017年 伯明利. All rights reserved.
//

#import "SecondViewController.h"
#import <LCDataManager/LCDataManager.h>

@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChanged) name:UITextFieldTextDidChangeNotification object:nil];
    
    [LCDataManager valueChangedForKey:@"messageKey" reuseIdentifier:@"reuseIdentifierForSecondViewController" changed:^(id object, id oldObject) {
        if (object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.messageLabel.text = (NSString *)object;
            });
        }
    }];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    
    [LCDataManager resignCallbackWithReuseIdentifier:@"reuseIdentifierForSecondViewController"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldTextDidChanged {
    [LCDataManager save:self.textField.text forKey:@"messageKey"];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
