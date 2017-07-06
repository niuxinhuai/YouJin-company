//
//  BOSelfDataVC.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/3/21.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BOSelfDataVC.h"
#import "UIImage+UIColor.h"
#import "BOChangeNicknameVC.h"
#import "BOSelfDataCell.h"
#import "SelfDataItem.h"
#import "SVProgressHUD.h"
#import "IntegralShareViewController.h"
#import "RiskAssessmentsViewController.h"
#import <QiniuSDK.h>
#import "ImageConpressManager.h"
static NSString *const ID = @"cell";
@interface BOSelfDataVC ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate>
@property (nonatomic, weak) UITableView *topTableView;
@property (nonatomic, copy) NSString *sexString;
@property (nonatomic, weak) AFHTTPSessionManager *mgr;

@property (nonatomic, strong) SelfDataItem *item;

@property (nonatomic, weak) UITextView *textView;

@property (nonatomic, weak) UIImageView *iconImageView;

@property (nonatomic, retain) UILabel *placeholdLabel;

/**保存获得的图片*/
@property (nonatomic, strong) UIImage *image;

/**上传七牛云的对象*/
@property (nonatomic, strong) QNUploadManager *upManager;

/**引用导航条的右边item*/
@property (nonatomic, weak) UIBarButtonItem *rightItem;

/**显示当前个性签名的数量的label*/
@property (nonatomic, weak) UILabel *numLabel;
@end

@implementation BOSelfDataVC
- (void)dealloc {
    NSLog(@"BOSelfDataVC");
}
#pragma mark - 网络请求对象
- (AFHTTPSessionManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager bo_manager];
    }
    return _mgr;
}
#pragma mark - 懒加载rightItem
- (QNUploadManager *)upManager {
    if (_upManager == nil) {
        _upManager = [[QNUploadManager alloc] init];
    }
    return _upManager;
}
- (void)setSexString:(NSString *)sexString {
     _sexString = sexString;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BOColor(244, 245, 247);
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 请求网络数据
    [self requstNetData];
    [self.navigationController setNavigationBarHidden:NO animated:YES];    // 设置导航条和状态栏的背景颜色
    //把颜色转成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    //把图片设置为背景
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // 隐藏底部的tabbar
//        self.tabBarController.tabBar.hidden = YES;
    
    // 设置navigationItem的左边按钮
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    //    self.navigationItem.leftBarButtonItem = btnItem;
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    
    BOSetupTitleView *titleView = [BOSetupTitleView setupTitleViewTitle:@"个人资料"];
    self.navigationItem.titleView = titleView;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.view endEditing:YES];
}

#pragma mark - 点击navogation左边按钮的事件
- (void)leftBarButtonItemClick {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 点击导航条右边按钮的事件
- (void)rightBarButtonItemClick {
    if (self.textView.text.length > 80) {
        [self pushRemind:@"字数超出限制"];
    }else {
        [self requstChangeFlagNetDataString:self.textView.text];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textView resignFirstResponder];
}
#pragma mark - 添加头部的tableView
- (void)setupToptableView {
    // 创建topTableView
    CGFloat topX = 0;
    CGFloat topY = 8 * BOHeightRate;
    CGFloat topW = BOScreenW;
    CGFloat topH = 225 * BOHeightRate - 1;
    UITableView *topTableView = [[UITableView alloc] initWithFrame:CGRectMake(topX, topY, topW, topH)];
    topTableView.dataSource = self;
    topTableView.delegate = self;
    self.topTableView = topTableView;
    self.topTableView.scrollEnabled = NO;
    //self.topTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:topTableView];
    // 添加头像imageView
    
}
#pragma mark - 添加底部的View
- (void)setupBottomView {
    CGFloat bottomX = 0;
    CGFloat bottomY = CGRectGetMaxY(self.topTableView.frame) + 8 * BOHeightRate;
    CGFloat bottomW = BOScreenW;
    CGFloat bottomH = 145 * BOHeightRate;
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(bottomX, bottomY, bottomW, bottomH)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    // 添加label
    CGFloat labelX = 15 * BOWidthRate;
    CGFloat labelY = 15 * BOHeightRate;
    CGFloat labelW = 80 * BOWidthRate;
    CGFloat labelH = 15 * BOHeightRate;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
    label.text = @"个性签名";
    [label setFont:[UIFont systemFontOfSize:15]];
    [bottomView addSubview:label];
    // 添加分割线
    CGFloat divisionX = labelX;
    CGFloat divisionY = 45 * BOHeightRate;
    CGFloat divisionW = BOScreenW - 15 * BOWidthRate;
    CGFloat divisionH = 1 * BOHeightRate;
    UIView *divisionView = [[UIView alloc] initWithFrame:CGRectMake(divisionX, divisionY, divisionW, divisionH)];
    divisionView.backgroundColor = BOColor(244, 245, 250);
    [bottomView addSubview:divisionView];
    // 添加底部的textView
    CGFloat textX = 15 * BOWidthRate;
    CGFloat textY = CGRectGetMaxY(divisionView.frame) + 1 * BOHeightRate;
    CGFloat textW = 350 * BOWidthRate;
    CGFloat textH = 60 * BOHeightRate;
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(textX, textY, textW, textH)];
    textView.delegate = self;
    self.textView = textView;
    //    textview 改变字体的行间距
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 5;// 字体的行间距
    
        NSDictionary *attributes = @{
                                     NSFontAttributeName:[UIFont systemFontOfSize:13],
                                     NSParagraphStyleAttributeName:paragraphStyle
                                     };
    if (self.item.flag.length > 0) {
        textView.attributedText = [[NSAttributedString alloc] initWithString:self.item.flag attributes:attributes];
    }
    //    [textView setFont:[UIFont systemFontOfSize:13]];
    [bottomView addSubview:textView];
    
    CGFloat placeholdX = 20 * BOWidthRate;
    CGFloat placeholdY = CGRectGetMaxY(divisionView.frame) + 7;
    CGFloat placeholdWidth = 70;
    CGFloat placeholdHeight = 20;
    
    self.placeholdLabel = [[UILabel alloc]initWithFrame:CGRectMake(placeholdX, placeholdY, placeholdWidth, placeholdHeight)];
    self.placeholdLabel.text = @"暂无签名";
    self.placeholdLabel.font = [UIFont systemFontOfSize:14];
    self.placeholdLabel.textColor = [UIColor colorWithHexString:@"#737373" alpha:1];
    [bottomView addSubview:self.placeholdLabel];
    self.placeholdLabel.hidden = self.item.flag.length > 0;
    
    // 添加底部的计数的label
    CGFloat numX = 320 * BOWidthRate;
    CGFloat numY = 120 * BOHeightRate;
    CGFloat numW = 40 * BOWidthRate;
    CGFloat numH = 15 * BOHeightRate;
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(numX, numY, numW, numH)];
    self.numLabel = numLabel;
    numLabel.text = [NSString stringWithFormat:@"%zd/80", textView.text.length];
    [numLabel setFont:[UIFont systemFontOfSize:13]];
    numLabel.textColor = BOColor(152, 153, 154);
    [bottomView addSubview:numLabel];
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
//    self.navigationItem.rightBarButtonItem = self.rightItem;
    UIBarButtonItem *rightItem = [UIBarButtonItem btnWithImage:nil title:@"保存" titleColor:[UIColor whiteColor] target:self action:@selector(rightBarButtonItemClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.placeholdLabel.hidden = textView.text.length > 0;
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
     self.placeholdLabel.hidden = textView.text.length > 0;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    self.navigationItem.rightBarButtonItem = nil;
    self.placeholdLabel.hidden = textView.text.length > 0;
    if (textView.text.length == 0) {
        
    }else {
        textView.text = self.item.flag;
        self.numLabel.text = [NSString stringWithFormat:@"%zd/80", textView.text.length];
    }
    
}
- (void)textViewDidChange:(UITextView *)textView {
    self.numLabel.text = [NSString stringWithFormat:@"%zd/80", textView.text.length];
    self.placeholdLabel.hidden = textView.text.length > 0;
}
#pragma mark - uitableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BOSelfDataCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    [cell imageViewHidden:YES];
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"头像";
        cell.imgView.image = [UIImage imageWithData:USERImage];
        [cell imageViewHidden:NO];
    }else if (indexPath.row == 1) {
        cell.titleLabel.text = @"昵称";
        cell.subTitleLabel.text = self.item.uname;
    }else if (indexPath.row == 2) {
        cell.titleLabel.text = @"性别";
        if ([USERSex intValue] == 0) {
            self.sexString = @"男";
        }else {
            self.sexString = @"女";
        }
        cell.subTitleLabel.text = self.sexString;
    }else if (indexPath.row == 3) {
        cell.titleLabel.text = @"投资类型";
        if (self.item.type) {
         cell.subTitleLabel.text = self.item.type;
        }else {
            cell.subTitleLabel.text = @"去评估";
        }
    }else if (indexPath.row == 4) {
        cell.titleLabel.text = @"收货地址";
        cell.subTitleLabel.text = self.item.address;
    }
       return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45 * BOHeightRate;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.textView resignFirstResponder];
    if (indexPath.row == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        // 设置popover指向的item
        alert.popoverPresentationController.barButtonItem = self.navigationItem.leftBarButtonItem;
        
        // 添加按钮
        [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self openCamera];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"从手机相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self openAlbum];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];

        
    }
    else if (indexPath.row == 1) {
        BOChangeNicknameVC *changeNicknameVC = [[BOChangeNicknameVC alloc] init];
        changeNicknameVC.hidesBottomBarWhenPushed = YES;
        changeNicknameVC.nameString = self.item.uname;
        [self.navigationController pushViewController:changeNicknameVC animated:YES];
    }
     else if (indexPath.row == 2) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        // 设置popover指向的item
        alert.popoverPresentationController.barButtonItem = self.navigationItem.leftBarButtonItem;
        
        // 添加按钮
        [alert addAction:[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self requstChangeSexNetDataString:@"0"];
            self.sexString = @"男";
            [self.topTableView reloadData];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self requstChangeSexNetDataString:@"1"];
           
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];

    }
     else if (indexPath.row == 3) {
         RiskAssessmentsViewController *risVc = [[RiskAssessmentsViewController alloc] init];
         risVc.hidesBottomBarWhenPushed = YES;
         [self.navigationController pushViewController:risVc animated:YES];
     }
     else if (indexPath.row == 4) {
         IntegralShareViewController *integralVC = [[IntegralShareViewController alloc] init];
         integralVC.hidesBottomBarWhenPushed = YES;
         integralVC.urlString = [NSString stringWithFormat:@"%@mobile/page/addAddress.html?uid=%@", BASEWEBURl,USERUID];
         integralVC.titleString = @"收货地址";
         [self.navigationController pushViewController:integralVC animated:YES];
     }
}

#pragma mark - 请求网络数据
- (void)requstNetData {
    NSString *url = [NSString stringWithFormat:@"%@Ucenter/getUserBaseInfo",BASEURL];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"at"] = tokenString;
    dictionary[@"sid"] = USERSid;
    dictionary[@"uid"] = USERUID;
    __weak typeof(self) weakSelf = self;
    [self.mgr POST:url parameters:dictionary progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         if ([responseObject[@"r"] intValue] == 1) {
            weakSelf.item = [SelfDataItem mj_objectWithKeyValues:responseObject[@"data"]];
             if (USERSex == nil) {
                 [[NSUserDefaults standardUserDefaults] setObject:self.item.sex forKey:@"sex"];
                 [[NSUserDefaults standardUserDefaults] synchronize];
                 
             }
             // 设置上部的tableView
             [weakSelf setupToptableView];
             // 设置底部的View
             [weakSelf setupBottomView];
             // 注册cell
             [weakSelf.topTableView registerClass:[BOSelfDataCell class] forCellReuseIdentifier:ID];
         }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark - 修改签名的网络请求
- (void)requstChangeFlagNetDataString:(NSString *)flagString {
    NSLog(@"%@", self.textView.text);
    NSLog(@"%@", flagString);
    NSString *url = [NSString stringWithFormat:@"%@Ucenter/updateBaseInfo",BASEURL];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"at"] = tokenString;
    dictionary[@"sid"] = USERSid;
    dictionary[@"uid"] = USERUID;
    dictionary[@"flag"] = flagString;
    __weak typeof(self) weakSelf = self;
    [self.mgr POST:url parameters:dictionary progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] intValue] == 1) {
            [weakSelf pushRemind:@"修改成功"];
            [weakSelf requstNetData];
            [weakSelf.textView resignFirstResponder];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - 发送修改性别信息的数据
#pragma mark - 请求网络数据
- (void)requstChangeSexNetDataString:(NSString *)sexString {
    NSString *url = [NSString stringWithFormat:@"%@Ucenter/updateBaseInfo",BASEURL];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"at"] = tokenString;
    dictionary[@"sid"] = USERSid;
    dictionary[@"uid"] = USERUID;
    dictionary[@"sex"] = sexString;
    [self.mgr POST:url parameters:dictionary progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] intValue] == 1) {
            [self pushRemind:@"修改成功"];
            //        [self requstNetData];
            if ([sexString intValue] == 1) {
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"sex"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self.topTableView reloadData];
            }else {
                [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"sex"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self.topTableView reloadData];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark - 打开相机
- (void)openCamera
{
    [self openImagePickerControllerWithType:UIImagePickerControllerSourceTypeCamera];
}
#pragma mark - 打开相册
- (void)openAlbum
{
    [self openImagePickerControllerWithType:UIImagePickerControllerSourceTypePhotoLibrary];
}
#pragma mark - 根据类型打开对应相机或者相册
- (void)openImagePickerControllerWithType:(UIImagePickerControllerSourceType)type
{
    // 设备不可用  直接返回
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.sourceType = type;
    imgPicker.delegate = self;
    imgPicker.allowsEditing = YES;
    [self presentViewController:imgPicker animated:YES completion:nil];
}

#pragma mark -- <UIImagePickerControllerDelegate>--
// 获取图片后的操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 销毁控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 设置图片
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];

    UIImage *newImage = [UIImage imageWithData: [ImageConpressManager compressImage:image PixelCompress:YES MaxPixel:60 JPEGCompress:YES MaxSize_KB:20]];
    NSString *url = @"https://www.youjin360.com/qiniu/examples/upload_token.php";
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    __weak typeof(self) weakSelf = self;
    // 获取上传七牛云所需的token
    [self.mgr POST:url parameters:dictionary progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 上传头像到七牛云
        NSString *token = responseObject[@"token"];
        NSData *data = UIImagePNGRepresentation(newImage);
        // 获取毫秒的时间戳
          NSDate *datenow = [NSDate date];
        NSString *key = [NSString stringWithFormat:@"head_%@_%ld",USERUID, (long)([datenow timeIntervalSince1970] * 1000)];
        [weakSelf.upManager putData:data key:key token:token
                       complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
          // 头像上传完成之后,把url传给后台
                           NSString *urlString = [NSString stringWithFormat:@"%@Ucenter/uploadHeadImage",BASEURL];
                           NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
                           parameters[@"at"] = tokenString;
                           parameters[@"sid"] = USERSid;
                           parameters[@"uid"] = USERUID;
                           parameters[@"head_image"] = key;
                           [weakSelf.mgr POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                               
                           } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                               if ([responseObject[@"r"] intValue] == 1) {
                                   // 创建子线程存储数据
                                   dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                                   dispatch_async(queue, ^{
                                       
                                       NSData *imageData = UIImagePNGRepresentation(newImage);
                                       [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"head_image"];
                                       [[NSUserDefaults standardUserDefaults] synchronize];
                                   });

                                   UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"上传头像成功" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
                                   [alertV show];
                                   dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1/*延迟执行时间*/ * NSEC_PER_SEC));
                                   
                                   dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                                       [alertV dismissWithClickedButtonIndex:0 animated:YES];
                                   });
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       //回调或者说是通知主线程刷新，
                                       weakSelf.iconImageView.image = newImage;
                                       [weakSelf.topTableView reloadData];
                                   });
                               }
                               
                           } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                               
                           }];
                       } option:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

#pragma mark - 图像的裁剪
- (UIImage *)tailorPicture:(UIImage *)image {
    //1.开启一个位图上下文(大小跟图片一样大)
    
    UIGraphicsBeginImageContext(image.size);
    
    
    
    //2.做裁剪.(对之前已经画上去的东西,不会有做用.)
    
    //2.1 bezierPathWithOvalInRect方法后面传的Rect,可以看作(x,y,width,height),前两个参数是裁剪的中心点,后面两个决定裁剪的区域是圆形还是椭圆.
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    //把路径设置为裁剪区域(超出裁剪区域以外的内容会自动裁剪掉.)
    
    [path addClip];
    
    
    
    //3.把图片绘制到上下文当中
    
    [image drawAtPoint:CGPointZero];
    
    //4.从上下文当中生成一张图片
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //5.关闭上下文
    
    UIGraphicsEndImageContext();
    
    //6.把图片显示出来
    
    return newImage;
}

#pragma mark - 对图片尺寸进行压缩--
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}
#pragma mark - 弹出弹框提醒
- (void)pushRemind:(NSString *)remindString {
    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:remindString message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [alertV show];
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1/*延迟执行时间*/ * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [alertV dismissWithClickedButtonIndex:0 animated:YES];
    });
    
}



@end
