//
//  QuestionDetailViewController.m
//  ZWEducation
//
//  Created by 李炜 on 2017/4/14.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import "QuestionDetailViewController.h"
#import "Definition.h"
#import "Masonry.h"
#import "MyQuestionTableDataSource.h"
#import "NetRequestUrl.h"
#import "NetworkManager.h"
#import "MJExtension.h"

#import "AnswerModel.h"
#import "QuestionModel.h"

@interface QuestionDetailViewController ()<MyQuestionDataSourceDelegate>

@property (nonatomic, strong)AnswerModel *answerModel;
@property (nonatomic, strong)QuestionModel *questionModel;

@property (nonatomic, strong)NSArray *responeArray;
@property (nonatomic, strong)NSMutableArray *modelArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, retain) MyQuestionTableDataSource *dataSource;
@end

@implementation QuestionDetailViewController
- (void)viewWillAppear:(BOOL)animated{
    
    self.title = @"我的答疑";
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];
    [super viewWillAppear:YES];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.000]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
     [self netRequest];
}

- (void)netRequest{
    
    NSDictionary *postParamDict = @{
                                    @"action" : @"Question",
                                    @"method" : @"showQuestion",
                                    @"data" : @{@"user_id": [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"],
                                                @"id": self.questionID}
                                    };
    LWWeakSelf(self);
    [self showActivityView:MBProgressHUDModeIndeterminate text:@"加载中"];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 精选套餐
        [NetworkManager POST:MyQuestionAnswer params:postParamDict success:^(NSURLSessionDataTask *task, id responseObject, AFHTTPSessionManager *manager) {
            weakself.responeArray = responseObject[@"data"][@"answers"];
            weakself.questionModel = [QuestionModel mj_objectWithKeyValues:responseObject[@"data"][@"question"]];
          weakself.questionModel.descrip=[responseObject[@"data"][@"question"] objectForKey:@"description"];
            for (NSDictionary *item in weakself.responeArray) {
                weakself.answerModel = [AnswerModel mj_objectWithKeyValues:item];
                [weakself.modelArray addObject:weakself.answerModel];
            }
            
            [weakself.modelArray setObject:weakself.questionModel atIndexedSubscript:0];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself removeActivity];
                [self displayUI:weakself.modelArray];
            });
        } fail:^(NSURLSessionDataTask *task, NSError *error, AFHTTPSessionManager *manager) {
            DLog(@"error----%@",error);
        }];
    });
 }


- (void)displayUI:(NSArray *)array{
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    MyQuestionTableDataSource *dataSource = [[MyQuestionTableDataSource alloc] initWithItems:array cellName:@"DetailQuestionCell" cellIdentifier:@"DetailQuestionCell" cellType:kFYCellTypeDefault];
    dataSource.delegate = self;
    self.tableView.dataSource = dataSource;
    self.tableView.delegate = dataSource;
    self.dataSource = dataSource;
    
}

- (UITableView *)tableView{
    if (_tableView==nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_tableView];
        LWWeakSelf(self);
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.view).offset(64);
            make.left.equalTo(weakself.view.mas_left);
            make.width.equalTo(weakself.view);
            make.height.equalTo(weakself.view);
        }];
    }
    return _tableView;
}
- (NSArray *)responeArray{
    
    if (_responeArray == nil) {
        _responeArray  = [NSArray array];
    }
    
    return _responeArray;
}

- (NSMutableArray *)modelArray{
    
    if (_modelArray == nil) {
        _modelArray  = [NSMutableArray array];
    }
    
    return _modelArray;
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
