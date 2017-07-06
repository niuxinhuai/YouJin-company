//
//  CompanyApplyViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/6.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "CompanyApplyViewController.h"
#import "ImageConpressManager.h"
#import <QiniuSDK.h>
#import "NSMutableDictionary+Utilities.h"
#import "KnowTheViewController.h"
#import "NSString+Utilities.h"

@interface CompanyApplyViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, retain) AFHTTPSessionManager *manager;
@property (nonatomic, retain) QNUploadManager *QNManager;
@property (nonatomic, retain) UIImage *certificateImage;

@end

@implementation CompanyApplyViewController


+ (instancetype)create {
    CompanyApplyViewController *vc = [[CompanyApplyViewController alloc]initWithNibName:@"CompanyApplyViewController" bundle:nil];
    return vc;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAutoDismissKeyboardGesture];
    [self configureViews];
    [self configureConstraint];
    [self addGesture];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - configureViews 

- (void)configureViews {
    [self configureBar];
    [self.submitButton makeCornerWithCornerRadius:self.submitButton.height / 2.0];
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:@"请上传盖有公司公章的营业执照复印件"];
    NSRange range1=[[hintString string]rangeOfString:@"复印件"];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#f64949" alpha:1] range:range1];
    self.certificateDemandLabel.attributedText=hintString;

}



- (void)configureBar {
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(returnAction:)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:@"企业认证"];
}


- (void)configureConstraint {
    self.submitButtonLeftToSuper.constant = 40 * BOWidthRate;
}


- (void)addGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.certificateImageView addGestureRecognizer:tap];
    self.certificateImageView.userInteractionEnabled = YES;
}

#pragma mark - request

- (void)companyApplyRequestWithImageWithImageUrl:(NSString *)url {
    NSString *urlString = [BASEURL stringByAppendingString:@"App/companyAuthApply"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:tokenString forKey:@"at"];
    [param setObject:USERUID forKey:@"uid"];
    [param setObject:USERSid forKey:@"sid"];
    [param setNewObject:self.companyNameTextField.text forKey:@"company"];
    [param setNewObject:self.companyWebsiteTextField.text forKey:@"www_url"];
    [param setNewObject:self.operatorTextField.text forKey:@"link_person"];
    [param setNewObject:url forKey:@"image_url"];
    
    [self.manager POST:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] intValue] == 1) {
            [self pushToApplySucceeViewController];
        }else {
            [self toast:responseObject[@"msg"] complete:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)requireQiNiuToken {
    [self.manager POST:QNTokenUrl parameters:[NSDictionary dictionary] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"token"]) {
            [self uploadImageToQiNiuWithImage:self.certificateImage token:responseObject[@"token"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)uploadImageToQiNiuWithImage:(UIImage *)image token:(NSString *)token {
    if (self.certificateImage) {
        UIImage *newImage = [UIImage imageWithData: [ImageConpressManager compressImage:image PixelCompress:YES MaxPixel:60 JPEGCompress:YES MaxSize_KB:20]];
        NSData *data = UIImagePNGRepresentation(newImage);
        NSDate *datenow = [NSDate date];
        NSString *key = [NSString stringWithFormat:@"auth_%@_%ld",USERUID, (long)([datenow timeIntervalSince1970] * 1000)];
        [self.QNManager putData:data key:key token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
            [self companyApplyRequestWithImageWithImageUrl:key];
        } option:nil];
    }

}


#pragma mark - reget

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager bo_manager];
    }
    return _manager;
}

- (QNUploadManager *)QNManager {
    if (!_QNManager) {
        _QNManager = [[QNUploadManager alloc] init];
    }
    return _QNManager;
}


#pragma mark - buttonAction

- (IBAction)submitAction:(UIButton *)sender {
    if (self.companyNameTextField.text.length == 0) {
        [self toast:@"请输入公司名称" complete:nil];
        return;
    }else if (self.operatorTextField.text.length == 0) {
        [self toast:@"请输入运营者名字" complete:nil];
        return;
    }
//    }else if (![self.companyWebsiteTextField.text isUrl]) {
//        [self toast:@"请输入正确的官方网址" complete:nil];
//        return;
//    }
   // [self pushToApplySucceeViewController];
    self.certificateImage ? [self requireQiNiuToken] : [self companyApplyRequestWithImageWithImageUrl:nil];
}


- (void)returnAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tapAction:(UIGestureRecognizer *)gesture {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [self toast:@"请设置相册访问全选" complete:nil];
        return;
    }
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imgPicker.delegate = self;
    imgPicker.allowsEditing = YES;
    [self presentViewController:imgPicker animated:YES completion:nil];
}

#pragma mark - helpMethod


- (void)pushToApplySucceeViewController {
    KnowTheViewController *knowVc = [[KnowTheViewController alloc]init];
    knowVc.hidesBottomBarWhenPushed = YES;
    knowVc.str = @"企业申请";
    [self.navigationController pushViewController:knowVc animated:YES];
}

#pragma mark - <UIImagePickerControllerDelegate>
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    self.certificateImage = [info objectForKey:UIImagePickerControllerEditedImage];
    self.certificateImageView.image = self.certificateImage;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
