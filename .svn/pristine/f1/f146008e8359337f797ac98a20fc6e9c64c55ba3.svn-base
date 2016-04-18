//
//  LHCFourViewController.m
//  Group-Demo-01
//
//  Created by qianfeng on 16/4/5.
//  Copyright © 2016年 qianfeng. All rights reserved.
//
#import "LHCLoginViewController.h"

#import "LHCFourViewController.h"
#import "LHCSettingViewController.h"
#import "LHCTrendsViewController.h"
#import "LHCAttentionViewController.h"
#import "LHCMyHomeViewController.h"
#define CELL @"cell"
#define OtherCELL @"OtherCell"
@interface LHCFourViewController () <UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong) UITableView *tableVeiw;
@property (nonatomic,strong) NSArray *datasource;
@property (nonatomic,strong) NSArray *imageData;
@property (nonatomic,strong) CATransition *transiction;     //动画
@property (nonatomic,strong) UIImagePickerController *picker;
@property (nonatomic,strong) UIImagePickerController *camera;

@end

@implementation LHCFourViewController {
    NSString *NiName;
    UITableViewCell *cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorWhite(0.9);
    self.tableVeiw.bounces = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNiName:) name:@"selectUser" object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [self selectOneUser:[HaoYue sharedUser].username];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"selectUser" object:nil];
}

#pragma mark 懒加载
- (UITableView *)tableVeiw {
    if (_tableVeiw == nil) {
        _tableVeiw = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableVeiw.delegate = self;
        _tableVeiw.dataSource = self;
        
        [self.view addSubview:_tableVeiw];
    }
    return _tableVeiw;
}

- (CATransition *)transiction {
    if (_transiction == nil) {
        _transiction = [CATransition animation];
        _transiction.type = @"cube";
        _transiction.subtype = @"fromRight";
    }
    return _transiction;
}

- (NSArray *)datasource {
    return @[@"我的粉丝",@"我的关注",@"设置"];
}

- (NSArray *)imageData {
    return @[@"four_fensi.png",@"four_faxian.png",@"four_shezhi.png"];
}

- (UIImagePickerController *)picker {
    if (_picker == nil) {
        _picker = [[UIImagePickerController alloc] init];
        _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _picker.delegate = self;
        _picker.allowsEditing = YES;
    }
    return _picker;
}

- (UIImagePickerController *)camera {
    if (_camera == nil) {
        _camera = [[UIImagePickerController alloc] init];
        _camera.sourceType = UIImagePickerControllerSourceTypeCamera;
        _camera.delegate = self;
    }
    return _camera;
}

- (void)getNiName:(NSNotification *)noti {
    NSArray *arr = noti.userInfo[@"arr"];
    for (BmobObject *obj in arr) {
        NSString *path_sandox = NSHomeDirectory();
        NSString *imagepath = [path_sandox stringByAppendingString:@"/Documents/flower.png"];
        [HaoYue sharedUser].icon = [UIImage imageWithContentsOfFile:imagepath];
        
        if ([HaoYue sharedUser].icon == nil) {
            [HaoYue sharedUser].icon = [UIImage imageNamed:@"selfs"];
        }
        
        NiName = [NSString stringWithFormat:@"%@",[obj objectForKey:@"name"]];
        [HaoYue sharedUser].niName = NiName;
    }
    [self.tableVeiw reloadData];
}

- (void)tapAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"头像选取" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *photoLib = [UIAlertAction actionWithTitle:@"相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self presentViewController:self.picker animated:YES completion:nil];
    }];
    
    UIAlertAction *camLib = [UIAlertAction actionWithTitle:@"相机拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self presentViewController:self.camera animated:YES completion:nil];
        } else {
            [Auxiliary alertWithTitle:@"提示" message:@"未发现可用相机" button:1 done:nil];
        }
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:photoLib];
    [alert addAction:camLib];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark 协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
        default:
            return 1;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section == 0) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELL];
        cell.imageView.image = [HaoYue sharedUser].icon;
        cell.imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [cell.imageView addGestureRecognizer:tap];
        cell.imageView.layer.cornerRadius = 40;
        cell.imageView.clipsToBounds = YES;
        cell.textLabel.text = NiName;
        cell.detailTextLabel.text = [HaoYue sharedUser].username;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    } else if(indexPath.section == 1) {
        UITableViewCell *seccell = [tableView dequeueReusableCellWithIdentifier:OtherCELL];
        if (seccell == nil) {
            seccell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:OtherCELL];
        }
        seccell.textLabel.text = self.datasource[indexPath.row];
        seccell.imageView.image = [UIImage imageNamed:self.imageData[indexPath.row]];
        seccell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return seccell;
    } else {
        UITableViewCell *thcell = [tableView dequeueReusableCellWithIdentifier:OtherCELL];
        if (thcell == nil) {
            thcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:OtherCELL];
        }
        thcell.textLabel.text = self.datasource.lastObject;
        thcell.imageView.image = [UIImage imageNamed:self.imageData.lastObject];
        thcell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return thcell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        LHCMyHomeViewController *vc = [[LHCMyHomeViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if(indexPath.section == 2) {
        
        LHCSettingViewController *setting = [[LHCSettingViewController alloc] init];
        [self.navigationController.view.layer addAnimation:self.transiction forKey:nil];
        [self.navigationController pushViewController:setting animated:YES];
    } else {
        if(indexPath.row == 0) {
            LHCAttentionViewController *vc = [[LHCAttentionViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            LHCTrendsViewController *vc = [[LHCTrendsViewController alloc] init];
            vc.title = @"我的关注";
            [self.navigationController pushViewController:vc animated:YES];
            vc.tabBarController.tabBar.hidden = YES;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 80;
    } else {
        return 44;
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    [HaoYue sharedUser].icon = image;
    NSString *path_sandox = NSHomeDirectory();
    NSString *imagepath = [path_sandox stringByAppendingString:@"/Documents/flower.png"];
    [UIImagePNGRepresentation(image) writeToFile:imagepath atomically:YES];
    
    [self.tableVeiw reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
