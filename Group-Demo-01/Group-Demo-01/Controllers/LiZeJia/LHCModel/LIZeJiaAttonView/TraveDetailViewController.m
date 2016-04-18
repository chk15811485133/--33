//
//  TraveDetailViewController.m
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/10.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "TraveDetailViewController.h"
#import "TraveDetailModel.h"
#import "TraveDetailTripDaysModel.h"
#import "TrNotesModel.h"
#import "TrNotesTwoModel.h"
#import "TrPhotoModel.h"
#import "TraveDiaryTwoModel.h"
#import "TraveDetailCell.h"
#import "HeaderView.h"
#import "LHCDBManager.h"
#import "LHCNavigationBar.h"
//游记详情
#define kYoujiDetail @"https://chanyouji.com/api/trips/%@.json"


@interface TraveDetailViewController ()

@end

@implementation TraveDetailViewController

{
    NSMutableArray * _title;
}


- (void)viewDidLoad {
    
    [self initTitle];
    
    [super viewDidLoad];
}

- (void)initTitle{
    if (_title == nil) {
        _title = [[NSMutableArray alloc]init];
    }
}

- (void)mjRrfresh{}

- (void)customNavigationBar{
    
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackBorderBarButton@2x"] landscapeImagePhone:[UIImage imageNamed:@"BackBarButtonHighlight@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(backButton:)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [button setImage:[UIImage imageNamed:@"FavoriteBarButton@2x"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"FavoriteBarButtonHighlight@2x"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonTT:) forControlEvents:UIControlEventTouchUpInside];
    
    //    UIBarButtonItem * favoriteItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"FavoriteBarButton@2x"] landscapeImagePhone:[UIImage imageNamed:@"FavoriteBarButtonHighlight@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(buttonTT:)];
    UIBarButtonItem * favoriteItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = favoriteItem;
}


- (void)backButton:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)buttonTT:(UIButton *)button{
    if (button.selected == YES) {
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已经收藏过了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"已收藏" preferredStyle:];
        
        [alert show];
        
    }else if (button.selected == NO){
        LHCDBManager * manager = [LHCDBManager defaultDBManager];
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:self.model];
        [manager saveHotModel:data];
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"收藏成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        button.selected = YES;
    }
}

//- (void)backButton:(UIButton *)button{
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (void)addScrollView{}
- (void)addTableView{
    [super addTableView];
    self.tableView.frame = CGRectMake(0, -128, XBScreenWidth,XBScreenHeight+64);
    HeaderView * header = [[HeaderView alloc]initWithFrame:CGRectMake(0, 0, XBScreenWidth, 200)];
    header.model = self.model;
    self.tableView.tableHeaderView = header;
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleSingleLine;
    
    [self setNavbarBackgroundHidden:YES];
}

- (void)setNavbarBackgroundHidden:(BOOL)hidden
{
    LHCNavigationBar *navBar =(LHCNavigationBar*)self.navigationController.navigationBar;
//    if (hidden) {
//        [navBar show];
//    }else{
//        [navBar hidden];
//    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y==-64) {
        return;
    }
    
    
    if (scrollView.contentOffset.y>50) {
        
        [self setNavbarBackgroundHidden:NO];
    }else{
        [self setNavbarBackgroundHidden:YES];
        
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.tableView.dataSource = nil;
    self.tableView.delegate = nil;
    
    [self setNavbarBackgroundHidden:NO];
}

- (void)loadData{
    [super loadData];
    [self loadDataWithPath:[NSString stringWithFormat:kYoujiDetail,self.ID]];
    
}

- (void)paseData:(id)data{
    
    TraveDetailModel * detailModel = [[TraveDetailModel alloc]initWithDictionary:data error:nil];
    detailModel.ID = data[@"id"];
    
    TraveDiaryTwoModel * diaryModel = detailModel.user;
    diaryModel.ID = data[@"user"][@"id"];
    
    
    NSArray * days = data[@"trip_days"];
    if (self.dataSource != nil) {
        [self.dataSource removeAllObjects];
    }
    
    //
    NSMutableArray * arrr = [[NSMutableArray alloc]init];
    for (int q= 0; q < days.count; q++) {
        NSMutableArray * muar = [[NSMutableArray alloc]init];
        [arrr addObject:muar];
    }
    
    for (int i = 0; i < days.count; i++) {
        TraveDetailTripDaysModel * daysModel = detailModel.trip_days[i];
        NSDictionary * dict = days[i];
        daysModel.ID = dict[@"id"];
        
        [_title addObject:dict[@"day"]];
        
        NSArray * nodes = dict[@"nodes"];
        for (int j = 0; j < nodes.count; j++) {
            TrNotesModel * notesModel = daysModel.nodes[j];
            NSDictionary * dicc = nodes[j];
            notesModel.ID = dicc[@"id"];
            
            NSArray * notes = dicc[@"notes"];
            for (int x = 0; x < notes.count; x++) {
                TrNotesTwoModel * twoModel = notesModel.notes[x];
                NSDictionary * dicx = notes[x];
                
                if ([dicx[@"description"] isKindOfClass:[NSNull class]]) {
                    twoModel.Description = @"";
                }else{
                    twoModel.Description = dicx[@"description"];
                }
                
                twoModel.ID = dicx[@"id"];
                
                [arrr[i] addObject:twoModel];
                
                if (dicx[@"photo"]!=nil) {
                    
                    TrPhotoModel * Tphoto = twoModel.photo;
                    
                    Tphoto.ID = dicx[@"photo"][@"id"];
                }
                
            }
        }
    }
    [self.dataSource addObjectsFromArray:arrr];
    [self.tableView reloadData];
    [self.huProgress stopProgressAnimating];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * array = self.dataSource[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TraveDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[TraveDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithRed:235/255.0 green:240/255.0 blue:244/255.0 alpha:1];
    }
    cell.model = self.dataSource[indexPath.section][indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TrNotesTwoModel * model = self.dataSource[indexPath.section][indexPath.row];
 
    return [model.heightCell floatValue];
    
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSString * title = [NSString stringWithFormat:@"DAY%@",_title[section]];
    
    UILabel * label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:18];
    label.text = title;
    
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}




@end
