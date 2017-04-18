//
//  CityPickerView.m
//  ZWEducation
//
//  Created by 李炜 on 2017/3/30.
//  Copyright © 2017年 Evyn. All rights reserved.
//

#import "CityPickerView.h"
#import "AreaModel.h"
#import "CityModel.h"
#import "ProvinceModel.h"
#import "Definition.h"
#import "Masonry.h"
@interface CityPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIPickerView *_pickerView;
    NSDictionary *_areaDic;
    NSMutableArray *_provinceArr;
}

@property (nonatomic, strong) NSDictionary *cityDic;
@end
@implementation CityPickerView


-(instancetype)init{
    self = [super init];
    if (self) {
       [self loading];
    }
    return self;
}
- (void)loading
{
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
        [self prepareData];
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            [self uiConfig];
        });
        
    });
}
- (void)prepareData
{
    //area.plist是字典
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
    _areaDic = [[NSDictionary alloc]initWithContentsOfFile:plistPath];
    
    //city.plist是数组
    NSString *plist = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    NSMutableArray *dataCity = [[NSMutableArray alloc] initWithContentsOfFile:plist];
    
    _provinceArr = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in dataCity) {
        ProvinceModel *model  = [[ProvinceModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        model.citiesArr = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in model.cities) {
            CityModel *cityModel = [[CityModel alloc]init];
            [cityModel setValuesForKeysWithDictionary:dic];
            [model.citiesArr addObject:cityModel];
        }
        [_provinceArr addObject:model];
    }
    
}
- (void)uiConfig
{
    
    UIView *finishView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
    finishView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    finishView.userInteractionEnabled  = YES;
    [self addSubview:finishView];
    
    UIButton *finishBt = [UIButton buttonWithType:UIButtonTypeCustom];
    finishBt.backgroundColor = [UIColor clearColor];
    [finishBt setTitle:@"确定" forState:UIControlStateNormal];
    [finishBt setTitleColor:[UIColor colorWithHexString:@"#33b1e0"] forState:UIControlStateNormal];
    [finishView addSubview:finishBt];
    [finishBt addTarget:self action:@selector(btClick) forControlEvents:UIControlEventTouchUpInside];
    [finishBt mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(finishView);
        make.right.equalTo(finishView.mas_right);
        make.width.equalTo(@(110/2));
        make.height.equalTo(@(60/2));
        
    }];
    
    
    
    //picker view 有默认高度216
    _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, finishView.frame.size.height +finishView.frame.origin.y, [UIScreen mainScreen].bounds.size.width, self.frame.size.height - finishView.frame.size.height)];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [_pickerView selectRow:0 inComponent:0 animated:YES];
    [self addSubview:_pickerView];
}

- (void)btClick{
    if (self.cityDic == nil) {
        self.cityDic = @{@"省":@"北京",@"市":@"北京市",@"区":@"市区"};
    }
    if ([self.delegate  respondsToSelector:@selector(chooseCityClick:)]) {        
        [self.delegate chooseCityClick:self.cityDic];
    }


}
#pragma mark -- picker Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (0 == component)
    {
        return _provinceArr.count;
    }
    else if(1==component)
    {
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        ProvinceModel *model =   _provinceArr[rowProvince];
        return model.citiesArr.count;
    }
    else
    {   NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        NSInteger rowCity = [pickerView selectedRowInComponent:1];
        ProvinceModel *model = _provinceArr[rowProvince];
        CityModel *cityModel = model.citiesArr[rowCity];
        NSString *str = [cityModel.code description];
        NSArray *arr =  _areaDic[str];
        return arr.count;
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (0 == component)
    {
        ProvinceModel *model = _provinceArr[row];
        return model.name;
    }
    else if(1==component)
    {
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        ProvinceModel *model = _provinceArr[rowProvince];
        CityModel *cityModel = model.citiesArr[row];
        return cityModel.name;
    }else
    {
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        NSInteger rowCity = [pickerView selectedRowInComponent:1];
        ProvinceModel *model = _provinceArr[rowProvince];
        CityModel *cityModel = model.citiesArr[rowCity];
        NSString *str = [cityModel.code description];
        NSArray *arr = _areaDic[str];
        AreaModel *areaModel = [[AreaModel alloc]init];
        [areaModel setValuesForKeysWithDictionary:arr[row]];
        return areaModel.name;
    }
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(0 == component)
    {
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        
    } if(1 == component)
    {
        [pickerView reloadComponent:2];
    }
    
    NSInteger selectOne = [pickerView selectedRowInComponent:0];
    NSInteger selectTwo = [pickerView selectedRowInComponent:1];
    NSInteger selectThree = [pickerView selectedRowInComponent:2];
    
    ProvinceModel *model = _provinceArr[selectOne];
    CityModel *cityModel = model.citiesArr[selectTwo];
    NSString *str = [cityModel.code description];
    NSArray *arr = _areaDic[str];
    AreaModel *areaModel = [[AreaModel alloc]init];
    [areaModel setValuesForKeysWithDictionary:arr[selectThree]];
   //self.navigationItem.title = [NSString stringWithFormat:@"省:%@  市:%@  区:%@",model.name,cityModel.name,areaModel.name];
    self.cityDic = @{@"省":model.name,@"市":cityModel.name,@"区":areaModel.name};
    NSLog(@"省:%@ 市:%@ 区:%@",model.name,cityModel.name,areaModel.name);
}


@end
