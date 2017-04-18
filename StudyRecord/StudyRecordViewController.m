//
//  StudyRecordViewController.m
//  ZWEducation
//
//  Created by 李炜 on 2017/3/23.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import "StudyRecordViewController.h"
//#import "LWTableViewDataSource.h"
#import "NetworkManager.h"
#import "NetRequestUrl.h"
#import "Definition.h"

@interface StudyRecordViewController ()

@end

@implementation StudyRecordViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.000]];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    title.text = @"学习记录";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor blackColor];
    self.navigationItem.titleView = title;
}

#pragma mark --cell已经布局完成，本页面的数据由网络获取。不是本地数据库
- (void)viewDidLoad {
    [super viewDidLoad];
    [self isLogin:^(BOOL isLogin) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!isLogin) return;
            self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
            self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        });
    }];
 }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
