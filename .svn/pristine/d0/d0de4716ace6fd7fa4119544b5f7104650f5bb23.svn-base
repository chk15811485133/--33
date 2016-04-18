//
//  SpecialViewController.m
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "SpecialViewController.h"
#import "SpecialModel.h"
#import "SpecialDetailModel.h"
#import "SpecialAttModel.h"
#import "SpecialNoteModel.h"
#import "SpecialCell.h"
#import "SpecialHeaderView.h"
#import "LHCNavigationBar.h"

@interface SpecialViewController ()


@end

@implementation SpecialViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)mjRrfresh{}

- (void)customNavigationBar{
    
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackBorderBarButton@2x"] landscapeImagePhone:[UIImage imageNamed:@"BackBarButtonHighlight@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(backButton:)];
    self.navigationItem.leftBarButtonItem = backItem;
   }

- (void)backButton:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addScrollView{}
- (void)addTableView{
    [super addTableView];
    self.tableView.frame = CGRectMake(0, -64, XBScreenWidth, XBScreenHeight+64);
    SpecialHeaderView * header  = [[SpecialHeaderView alloc]initWithFrame:CGRectMake(0, 0, XBScreenWidth, 200)];
    header.model = self.model;
    self.tableView.tableHeaderView = header;
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleSingleLine;
    
    [self setNavbarBackgroundHidden:YES];
}

- (void)setNavbarBackgroundHidden:(BOOL)hidden
{
//    LHCNavigationBar *navBar =(LHCNavigationBar*)self.navigationController.navigationBar;
//    if (!hidden) {
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
    [self loadDataWithPath:[NSString stringWithFormat:kSpecial_url,self.ID]];
}

- (void)paseData:(id)data{
    
    SpecialModel * model = [[SpecialModel alloc]initWithDictionary:data error:nil];
    
    model.ID = data[@"id"];
    
    NSArray * array = data[@"article_sections"];
    for (int i = 0; i < array.count; i++) {
        SpecialDetailModel * deModel = model.article_sections[i];
        NSDictionary * dict = array[i];
        deModel.Description = dict[@"description"];
        
        [self.dataSource addObject:deModel];
        
        NSDictionary * dic = dict[@"attraction"];
        if (deModel.attraction != nil) {
            SpecialAttModel * aModel = deModel.attraction;
            aModel.ID = dic[@"id"];
        }
        NSDictionary * dicc = dict[@"note"];
        if (deModel.note != nil) {
            SpecialNoteModel * nModel = deModel.note;
            nModel.ID = dicc[@"id"];
        }
    }
    [self.tableView reloadData];
    [self.huProgress stopProgressAnimating];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SpecialCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[SpecialCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        
    }
    
    cell.Model = self.dataSource[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SpecialDetailModel * model = self.dataSource[indexPath.row];
    return [model.heightCell floatValue];
}










@end
