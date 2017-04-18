//
//  DemoModuleADetailViewController.m
//  CTMediator
//
//  Created by casa on 16/3/13.
//  Copyright © 2016年 casa. All rights reserved.
//

#import "MyQuestionModuleViewController.h"
#import "Definition.h"
#import "Masonry.h"
#import "MyQuestionTableDataSource.h"
#import "NetRequestUrl.h"
#import "NetworkManager.h"
#import "MyQuestionModel.h"
#import "MJExtension.h"
#import "QuestionDetailViewController.h"
@interface MyQuestionModuleViewController ()<MyQuestionDataSourceDelegate>
@property (nonatomic, strong)MyQuestionModel *myQuestionModel;
@property (nonatomic, strong)NSArray *responeArray;
@property (nonatomic, strong)NSMutableArray *modelArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, retain) MyQuestionTableDataSource *dataSource;
@end

@implementation MyQuestionModuleViewController
/*
 解决push 到下一个页面时 底部tabbar 空白的问题
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    self.title = @"问题详情";
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    [super viewWillAppear:YES];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.000]];
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self isLogin:^(BOOL isLogin) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!isLogin) return;
             [self netRequest];
        });
    }];
}

- (void)netRequest{

    NSDictionary *postParamDict = @{
                                    @"action" : @"MyQuestion",
                                    @"method" : @"myQuestion",
                                    @"data" : @{@"user_id": [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"],
                                                @"page": @10,
                                                @"current_page": @1}
                                    };
    LWWeakSelf(self);
    [self showActivityView:MBProgressHUDModeIndeterminate text:@"加载中"];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 精选套餐
        [NetworkManager POST:MyQuestionAnswer params:postParamDict success:^(NSURLSessionDataTask *task, id responseObject, AFHTTPSessionManager *manager) {
             weakself.responeArray = responseObject[@"data"][@"questions"][@"data"];
            for (NSDictionary *item in weakself.responeArray) {
                weakself.myQuestionModel = [MyQuestionModel mj_objectWithKeyValues:item];
                weakself.myQuestionModel.descrip=[item objectForKey:@"description"];
                [weakself.modelArray addObject:weakself.myQuestionModel];
            }

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
    MyQuestionTableDataSource *dataSource = [[MyQuestionTableDataSource alloc] initWithItems:array cellName:@"MyQuestionCell" cellIdentifier:@"MyQuestionCell" cellType:kFYCellTypeDefault];
    dataSource.delegate = self;
    self.tableView.dataSource = dataSource;
    self.tableView.delegate = dataSource;
    self.dataSource = dataSource;

}

#pragma mark table delegate
- (void)didSelectedCellWithItem:(id)item tableView:(UITableView *)tableView{

    QuestionDetailViewController *detail = [[QuestionDetailViewController alloc]init];
    detail.questionID = ((MyQuestionModel *)item).id;
    [self.navigationController pushViewController:detail animated:YES];
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}


- (UITableView *)tableView{
    if (_tableView==nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_tableView];
        LWWeakSelf(self);
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.view);
            make.left.equalTo(weakself.view);
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
@end
