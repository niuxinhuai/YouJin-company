//
//  WriteCommentsOnViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/4/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "WriteCommentsOnViewController.h"
#import "SmilingFaceView.h"
#import "WriteCommentsModel.h"
//图片多选
#import "TZImagePickerController.h"
#import "UIView+Layout.h"
#import "TZTestCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "LxGridViewFlowLayout.h"
#import "TZImageManager.h"
#import "TZVideoPlayerController.h"
#import "TZPhotoPreviewController.h"
#import "TZGifPhotoPreviewController.h"

#import <QiniuSDK.h>
#import "ImageConpressManager.h"
#import "NSMutableDictionary+Utilities.h"
#import "ImageUploadManager.h"
#import "NSString+Utilities.h"
#import "ImageConpressManager.h"
#import "UITextView+Utilities.h"
#import <IQKeyboardManager.h>


@interface WriteCommentsOnViewController ()<UITextViewDelegate,TZImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,ImageUploadManagerDelegate>
{
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
    
    CGFloat _itemWH;
    CGFloat _margin;
}

@property (nonatomic ,strong)UIScrollView *baseScrView;//承载滑动的scrView
@property (nonatomic ,strong)NSMutableArray *starArray;//存放星星的数组
@property (nonatomic ,strong)UIButton *starButton;//星星的button按钮
@property (nonatomic ,strong)SmilingFaceView *smiliView;//笑脸view
@property (nonatomic ,strong)UIView *lineView;//总体星星的view最下边的细线
@property (nonatomic ,strong)UIView *topBgView;//总体星星的view
@property (nonatomic ,strong)UIView *enterView;//输入文字的view
@property (nonatomic ,strong)UIView *addImageView;//图片上传view
@property (nonatomic ,strong)UITextView *textView;//输入文字框
@property (nonatomic ,strong)UILabel *placeLabel;//placehoder
@property (nonatomic ,strong)UILabel *fifteenLabel;//加油还差15个字
@property (nonatomic ,assign)int xingxing;//星星
@property (nonatomic ,strong)NSMutableArray *theLabelResultArr;//存放标签的arr
@property (nonatomic ,strong)NSMutableArray *zhenTheLabelArr;//存放标签的arr
@property (nonatomic ,strong)UIButton *chooseButton;//圆角button
@property (nonatomic ,strong)NSMutableArray *chooseArr;//存放圆角button
@property (nonatomic, strong) NSMutableArray *uploadImages;
@property (nonatomic, strong) ImageUploadManager *imageUploadManager;
@property (nonatomic, assign) BOOL isReupload;

@property (nonatomic ,strong)UIButton *rightButton;


@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, strong) UICollectionView *collectionView;
// 6个设置开关
@property (weak, nonatomic)  UISwitch *showTakePhotoBtnSwitch;  ///< 在内部显示拍照按钮
@property (weak, nonatomic)  UISwitch *sortAscendingSwitch;     ///< 照片排列按修改时间升序
@property (weak, nonatomic)  UISwitch *allowPickingVideoSwitch; ///< 允许选择视频
@property (weak, nonatomic)  UISwitch *allowPickingImageSwitch; ///< 允许选择图片
@property (weak, nonatomic)  UISwitch *allowPickingGifSwitch;
@property (weak, nonatomic)  UISwitch *allowPickingOriginalPhotoSwitch; ///< 允许选择原图
@property (weak, nonatomic)  UISwitch *showSheetSwitch; ///< 显示一个sheet,把拍照按钮放在外面
@property (weak, nonatomic)  UITextField *maxCountTF;  ///< 照片最大可选张数，设置为1即为单选模式
@property (weak, nonatomic)  UITextField *columnNumberTF;
@property (weak, nonatomic)  UISwitch *allowCropSwitch;
@property (weak, nonatomic)  UISwitch *needCircleCropSwitch;



@property (nonatomic, retain) AFHTTPSessionManager *manager;
@property (nonatomic, retain) QNUploadManager *QNManager;
@property (nonatomic, retain) UIImage *certificateImage;




@property (nonatomic ,assign)BOOL biaoqianone;
@property (nonatomic ,assign)BOOL biaoqiantwo;
@property (nonatomic ,assign)BOOL biaoqianthree;

@property (nonatomic ,copy)NSString *numberone;
@property (nonatomic ,copy)NSString *numbertwo;
@property (nonatomic ,copy)NSString *numberthree;
@property (nonatomic ,copy)NSString *numberfour;
@property (nonatomic ,copy)NSString *numberfive;
@property (nonatomic ,copy)NSString *numbersix;

@end

@implementation WriteCommentsOnViewController

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}

-(NSMutableArray *)theLabelResultArr
{
    if (_theLabelResultArr == nil)
    {
        _theLabelResultArr = [NSMutableArray array];
    }
    return _theLabelResultArr;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    //    // 设置导航条和状态栏的背景颜色
    //把颜色转成图片
    UIImage *images = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    //把图片设置为背景
    [self.navigationController.navigationBar setBackgroundImage:images forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:self.nameString];
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    //rightBarButtonItem
    _rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,130*BOScreenW/750,40*BOScreenH/1334)];
    //    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    _rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_rightButton setTitle:@"发布" forState:UIControlStateNormal];
    [_rightButton setTitleColor:[UIColor colorWithHexString:@"#ffffff" alpha:1] forState:UIControlStateNormal];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:_rightButton];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    [[IQKeyboardManager sharedManager]setEnable:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager]setEnable:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAutoDismissKeyboardGesture];
    
    _chooseArr = [NSMutableArray array];
    _starArray = [NSMutableArray array];
    
    
    
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    
    _zhenTheLabelArr = [NSMutableArray array];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    //底部滑动的scr
    _baseScrView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH)];
    _baseScrView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    _baseScrView.showsVerticalScrollIndicator = NO;
    _baseScrView.contentSize = CGSizeMake(BOScreenW, 720*BOScreenH/1334);
    [self.view addSubview:_baseScrView];
    
    //笑脸view
    _smiliView = [[SmilingFaceView alloc]initWithFrame:CGRectMake(0, 140*BOScreenH/1334, BOScreenW, 440*BOScreenH/1334)];
    if ([self.type intValue] == 9) [self.smiliView updateTitles:@[@"产品",@"功能",@"实力",@"服务"]];
    [_baseScrView addSubview:_smiliView];
    _smiliView.hidden = YES;//笑脸view隐藏
    [self fiveStar];//总体 星星
    [self enterTextView];//输入文字
    [self chooseimageView];//图片上传
    
    [self configCollectionView];
    
    self.imageUploadManager = [ImageUploadManager imageUploadManagerWithDelegate:self];
    
}
#pragma mark---总体的星星---
- (void)fiveStar
{
    _topBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 140*BOScreenH/1334)];
    _topBgView.backgroundColor = [UIColor whiteColor];
    [_baseScrView addSubview:_topBgView];
    
    UILabel *overallLabel = [[UILabel alloc]init];
    overallLabel.text = @"总体";
    [overallLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    overallLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    CGSize size=[overallLabel.text sizeWithAttributes:attrs];
    [overallLabel setFrame:CGRectMake(30*BOScreenW/750, 50*BOScreenH/1334, size.width, 40*BOScreenH/1334)];
    [_topBgView addSubview:overallLabel];
    
    for (int i = 0; i < 5; i ++)
    {
        _starButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _starButton.frame  =CGRectMake(30*BOScreenW/750 + size.width + 30*BOScreenW/750 + i*(50*BOScreenW/750+30*BOScreenW/750), 45*BOScreenH/1334, 50*BOScreenW/750, 50*BOScreenW/750);
        [_starButton setBackgroundImage:[UIImage imageNamed:@"common_score_d"] forState:UIControlStateNormal];
        _starButton.tag = i+1;
        [_starButton addTarget:self action:@selector(starButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_topBgView addSubview:_starButton];
        [_starArray addObject:_starButton];
    }
    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 139*BOScreenH/1334, BOScreenW, 1*BOScreenH/1334)];
    _lineView.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
    [_topBgView addSubview:_lineView];
}
#pragma mark ---输入文字---
- (void)enterTextView
{
    _enterView = [[UIView alloc]initWithFrame:CGRectMake(0, 156*BOScreenH/1334, BOScreenW, 328*BOScreenH/1334)];
    _enterView.backgroundColor = [UIColor whiteColor];
    [_baseScrView addSubview:_enterView];
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 30*BOScreenH/1334, BOScreenW-62*BOScreenW/750, 268*BOScreenH/1334)];
    _textView.delegate = self;
    //    _textView.keyboardType = UIKeyboardTypePhonePad;
    _textView.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    _textView.font = [UIFont systemFontOfSize:15];
    [_enterView addSubview:_textView];
    //    //键盘上的view
    //    UIView *inputview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 80*BOScreenH/1334)];
    //    inputview.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    //    UIButton *underButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    underButton.frame = CGRectMake(650*BOScreenW/750, 20*BOScreenH/1334, 80*BOScreenW/750, 40*BOScreenH/1334);
    //    [underButton setTitle:@"完成" forState:UIControlStateNormal];
    //    [underButton setTitleColor:[UIColor colorWithHexString:@"#2380f4" alpha:1] forState:UIControlStateNormal];
    //    [underButton addTarget:self action:@selector(underButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //    [inputview addSubview:underButton];
    //    _textView.inputAccessoryView = inputview;
    
    _placeLabel = [[UILabel alloc]initWithFrame:CGRectMake(5*BOScreenW/750, 20*BOScreenH/1334, BOScreenW-62*BOScreenW/750, 30*BOScreenH/1334)];
    _placeLabel.text = @"说说你对平台的看法或者投资过程的体验";
    _placeLabel.textColor = [UIColor colorWithHexString:@"#bfbfbf" alpha:1];
    _placeLabel.backgroundColor = [UIColor clearColor];
    _placeLabel.font = [UIFont systemFontOfSize:15];
    [_textView addSubview:_placeLabel];
    
    _fifteenLabel = [[UILabel alloc]initWithFrame:CGRectMake(330*BOScreenW/750, 280*BOScreenH/1334, 400*BOScreenW/750, 30*BOScreenH/1334)];
    _fifteenLabel.text = @"加油，还差15个字";
    _fifteenLabel.font = [UIFont systemFontOfSize:12];
    _fifteenLabel.textColor = [UIColor colorWithHexString:@"#bfbfbf" alpha:1];
    _fifteenLabel.textAlignment = NSTextAlignmentRight;
    [_enterView addSubview:_fifteenLabel];
}
#pragma mark ---图片上传---
- (void)chooseimageView
{
    _addImageView = [[UIView alloc]initWithFrame:CGRectMake(0, 500*BOScreenH/1334, BOScreenW, 250*BOScreenH/1334)];
    _addImageView.backgroundColor = [UIColor redColor];
    [_baseScrView addSubview:_addImageView];
    
    //    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    addButton.frame = CGRectMake(30*BOScreenW/750, 30*BOScreenH/1334, 160*BOScreenW/750, 160*BOScreenW/750);
    //    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //    [addButton setBackgroundImage:[UIImage imageNamed:@"img_picbox"] forState:UIControlStateNormal];
    //    [_addImageView addSubview:addButton];
}
#pragma mark ---星星的点击事件---
- (void)starButtonClick:(UIButton *)sender
{
    _xingxing = (int)sender.tag;
    [self setCount:_xingxing];
    [self commentOnTheLabelData];//标签的请求数组
    _lineView.hidden = YES;//隐藏topview最下边的细线
    _topBgView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    _topBgView.layer.shadowOffset = CGSizeMake(2,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    _topBgView.layer.shadowOpacity = 0.1;//阴影透明度，默认0
    _topBgView.layer.shadowRadius = 2;//阴影半径，默认3
    _smiliView.hidden = NO;//笑脸view显示
    
    _enterView.frame = CGRectMake(0, 596*BOScreenH/1334, BOScreenW, 328*BOScreenH/1334);
    _addImageView.frame = CGRectMake(0, 940*BOScreenH/1334, BOScreenW, 220*BOScreenH/1334);
    _baseScrView.contentSize = CGSizeMake(BOScreenW, 1160*BOScreenH/1334);
    
    [_textView resignFirstResponder];
}
#pragma mark---设置星星显示与隐藏---
- (void)setCount:(int)count
{
    int xingxCount = (int)_starArray.count;
    
    for (int i = 0; i < xingxCount; i++)
    {
        UIButton *round = _starArray[i];
        if (i < count)
        {
            [round setBackgroundImage:[UIImage imageNamed:@"common_score_h"] forState:UIControlStateNormal];
        } else
        {
            [round setBackgroundImage:[UIImage imageNamed:@"common_score_d"] forState:UIControlStateNormal];
        }
    }
}
#pragma mark ---pop返回前一页---
- (void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark---发布的点击事件---
- (void)rightButtonClick
{
    NSLog(@"发布的按钮");
    if (_xingxing > 0)
    {
        if (_smiliView.xiaolianone > 0)
        {
            if (_smiliView.xiaoliantwo > 0)
            {
                if (_smiliView.xiaolianthree > 0)
                {
                    if (_smiliView.xiaolianfour > 0)
                    {
                        if ( _textView.text.length >= 15)
                        {
                            self.rightButton.enabled = NO;
                            [self compressImages:_selectedPhotos];
                            if (self.uploadImages && self.uploadImages.count > 0) {
                                if (self.isReupload){
                                    [self.imageUploadManager reuploadFailImages];
                                }else {
                                    [self.imageUploadManager uploadImages:self.uploadImages keys:[self uploadKeysWithCount:self.uploadImages.count] isReupload:NO];
                                }
                                self.isReupload = YES;
                            }else {
                                [self writeCommentsDataWithKeys:nil];
                            }
                        } else
                        {
                            [self toast:@"输入的字数不够" complete:nil];
                        }
                    } else
                    {
                        [self toast:@"请做出透明评价" complete:nil];
                    }
                } else
                {
                    [self toast:@"请做出服务评价" complete:nil];
                }
            } else
            {
                [self toast:@"请做出风控评价" complete:nil];
            }
        }else
        {
            [self toast:@"请做出运营评价" complete:nil];
        }
    }else
    {
        [self toast:@"请做出总体评价" complete:nil];
    }
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger count = [textView caculateTextViewTextCount];
    _fifteenLabel.text = [NSString stringWithFormat:@"加油，还差%ld个字",(15-count)];

    if (textView.text.length > 0)
    {
        _placeLabel.hidden = YES;
    }
    if (textView.text.length == 0)
    {
        _placeLabel.hidden = NO;
    }
    if (count >= 15)
    {
        _fifteenLabel.hidden = YES;
    }
    if (count < 15)
    {
        _fifteenLabel.hidden = NO;
    }
}
//#pragma mark---键盘上面完成按钮的点击事件---
//- (void)underButtonClick
//{
//    //对键盘弹出来view的处理
//    if (_starOnAndOff == NO)
//    {
//        [_textView resignFirstResponder];
//    }else
//    {
//        [_textView resignFirstResponder];
//        self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
//    }
//}
#pragma mark---点评的接口----
- (void)writeCommentsDataWithKeys:(NSArray *)keys
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"sid"] = USERSid;
    parameters[@"uid"] = USERUID;
    parameters[@"zid"] = self.ptidStr;
    parameters[@"fid"] = @"0";
    parameters[@"fuid"] = @"0";
    //    parameters[@"out_type"] = self.type;
    parameters[@"out_type"] = self.type ? self.type : @"3";
    parameters[@"content"] = _textView.text;
    parameters[@"score"] = [NSString stringWithFormat:@"%d",_xingxing];
    parameters[@"v1"] = [NSString stringWithFormat:@"%d",_smiliView.xiaolianone];
    parameters[@"v2"] = [NSString stringWithFormat:@"%d",_smiliView.xiaoliantwo];
    parameters[@"v3"] = [NSString stringWithFormat:@"%d",_smiliView.xiaolianthree];
    parameters[@"v4"] = [NSString stringWithFormat:@"%d",_smiliView.xiaolianfour];

    
//    NSLog(@"_numberone%@%@%@%@%@%@_numberone",_numberone,_numbertwo,_numberthree,_numberfour,_numberfive ,_numbersix);
    //标签
    //    parameters[@"fast_tixian"] = _numberone;
    //    parameters[@"nice_service"] = _numbertwo;
    //    parameters[@"reliable"] = _numberthree;
    //    parameters[@"not_open"] = _numberfour;
    //    parameters[@"terrible"] = _numberfive;
    //    parameters[@"not_indroduce"] = _numbersix;
    parameters[@"not_open"] = _numberone;
    parameters[@"terrible"] = _numbertwo;
    parameters[@"not_indroduce"] = _numberthree;
    parameters[@"fast_tixian"] = _numberfour;
    parameters[@"nice_service"] = _numberfive;
    parameters[@"reliable"] = _numbersix;
    if (keys) [parameters setNewObject:[NSString jsonStringWithArray:keys] forKey:@"image_array"];

    [manager POST:[NSString stringWithFormat:@"%@App/reply",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"mmmmmmmmmmmm%@",responseObject);
        if ([responseObject[@"r"] integerValue] == 1)
        {
            NSLog(@"请求成功");
            _rightButton.userInteractionEnabled = NO;
            self.callBackBlock(@"点评成功");
            [self postNotifaction];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [self toast:responseObject[@"msg"] complete:nil];
            self.rightButton.enabled = YES;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.rightButton.enabled = YES;
        NSLog(@"请求失败%@",error);
    }];
}
#pragma mark---平台点评标签的数据接口---
- (void)commentOnTheLabelData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"out_type"] = @"3";
    NSLog(@"klklklklklklkl%d",_xingxing);
    parameters[@"score"] = [NSString stringWithFormat:@"%d",_xingxing];
    [manager POST:[NSString stringWithFormat:@"%@Common/wdReplyTag",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"gggggggggggg%@",responseObject[@"data"]);
        if ([responseObject[@"r"] integerValue] == 1)
        {
            self.theLabelResultArr = [WriteCommentsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            for (UIButton *btn in _chooseArr)
            {
                [btn removeFromSuperview];
            }
            [_zhenTheLabelArr removeAllObjects];
            [_chooseArr removeAllObjects];
            for (WriteCommentsModel *model in self.theLabelResultArr)
            {
                [_zhenTheLabelArr addObject:model.desc];
            }
            NSLog(@"_zhenTheLabelArr%@",_zhenTheLabelArr);
            [self theLabelButton];//button标签
        }
        else
        {
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
//#pragma mark---多选图片的按钮点击方法---
//- (void)addButtonClick
//{
//    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:3 delegate:self];
//    imagePickerVc.naviBgColor = [UIColor colorWithHexString:@"#2d84f2" alpha:1];
//    imagePickerVc.allowPickingOriginalPhoto = NO;//隐藏选择原图
//    [self presentViewController:imagePickerVc animated:YES completion:nil];
//}
//- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
//{
//    NSLog(@"0900000000%@",photos);
//        for (int i = 0; i < photos.count; i++)
//        {
//            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(30*BOScreenW/750+i*(160*BOScreenW/750 + 20*BOScreenW/750), 30*BOScreenH/1334, 160*BOScreenW/750, 160*BOScreenW/750)];
//            imageView.image = photos[i];
//            [_addImageView addSubview:imageView];
//
//            UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            deleteButton.frame = CGRectMake(160*BOScreenW/750 + i*(30*BOScreenW/750 + 150*BOScreenW/750), 10*BOScreenH/1334, 50*BOScreenW/750, 50*BOScreenW/750);
//            deleteButton.tag = i;
//            [deleteButton setBackgroundImage:[UIImage imageNamed:@"img_closed"] forState:UIControlStateNormal];
//            [deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//            [_addImageView addSubview:deleteButton];
//        }
//}

#pragma mark ---创建三个标签button---
- (void)theLabelButton
{
    for (int i = 0; i < _zhenTheLabelArr.count; i ++)
    {
        _chooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _chooseButton.frame = CGRectMake(30*BOScreenW/750+i*(120*BOScreenW/750+30*BOScreenW/750), 367*BOScreenH/1334, 120*BOScreenW/750, 46*BOScreenH/1334);
        _chooseButton.tag = i+100;
        [_chooseButton setTitle:_zhenTheLabelArr[i] forState:UIControlStateNormal];
        _chooseButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_chooseButton setTitleColor:[UIColor colorWithHexString:@"#999999" alpha:1] forState:UIControlStateNormal];
        _chooseButton.layer.borderWidth = 1*BOScreenW/750;
        _chooseButton.layer.borderColor = [UIColor colorWithHexString:@"#bfbfbf" alpha:1].CGColor;
        _chooseButton.layer.cornerRadius = 11;
        _chooseButton.layer.masksToBounds = YES;
        [_chooseButton addTarget:self action:@selector(chooseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_smiliView addSubview:_chooseButton];
        [_chooseArr addObject:_chooseButton];
    }
    NSLog(@"_chooseArr%@",_chooseArr);
}
- (void)chooseButtonClick:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 100:
        {
            if (_biaoqianone)
            {
                UIButton *button = (UIButton *)[self.view viewWithTag:100];
                [button setBackgroundColor:[UIColor colorWithHexString:@"#ffffff" alpha:1]];
                [button setTitleColor:[UIColor colorWithHexString:@"#999999" alpha:1] forState:UIControlStateNormal];
                button.layer.borderColor = [UIColor colorWithHexString:@"#bfbfbf" alpha:1].CGColor;
                if (_xingxing <=2)
                {
                    _numberone = @"0";
                }else
                {
                    _numberfour = @"0";
                }
                //                    _numberone = @"0";
                _biaoqianone = NO;
            }else
            {
                UIButton *button = (UIButton *)[self.view viewWithTag:100];
                [button setBackgroundColor:[UIColor colorWithHexString:@"#fcddaf" alpha:1]];
                [button setTitleColor:[UIColor colorWithHexString:@"#ff5a00" alpha:1] forState:UIControlStateNormal];
                button.layer.borderColor = [UIColor colorWithHexString:@"#f6b78a" alpha:1].CGColor;
                if (_xingxing <=2)
                {
                    _numberone = @"1";
                }else
                {
                    _numberfour = @"1";
                }
                //                    _numberone = @"1";
                _biaoqianone = YES;
            }
            
            break;
        }
        case 101:
        {
            if (_biaoqiantwo)
            {
                UIButton *button = (UIButton *)[self.view viewWithTag:101];
                [button setBackgroundColor:[UIColor colorWithHexString:@"#ffffff" alpha:1]];
                [button setTitleColor:[UIColor colorWithHexString:@"#999999" alpha:1] forState:UIControlStateNormal];
                button.layer.borderColor = [UIColor colorWithHexString:@"#bfbfbf" alpha:1].CGColor;
                if (_xingxing <=2)
                {
                    _numbertwo = @"0";
                }else
                {
                    _numberfive = @"0";
                }
                
                //                    _numbertwo = @"0";
                _biaoqiantwo = NO;
            }else
            {
                UIButton *button = (UIButton *)[self.view viewWithTag:101];
                [button setBackgroundColor:[UIColor colorWithHexString:@"#fcddaf" alpha:1]];
                [button setTitleColor:[UIColor colorWithHexString:@"#ff5a00" alpha:1] forState:UIControlStateNormal];
                button.layer.borderColor = [UIColor colorWithHexString:@"#f6b78a" alpha:1].CGColor;
                if (_xingxing <=2)
                {
                    _numbertwo = @"1";
                }else
                {
                    _numberfive = @"1";
                }
                //                    _numbertwo = @"1";
                _biaoqiantwo = YES;
            }
            
            break;
        }
        case 102:
        {
            if (_biaoqianthree)
            {
                UIButton *button = (UIButton *)[self.view viewWithTag:102];
                [button setBackgroundColor:[UIColor colorWithHexString:@"#ffffff" alpha:1]];
                [button setTitleColor:[UIColor colorWithHexString:@"#999999" alpha:1] forState:UIControlStateNormal];
                button.layer.borderColor = [UIColor colorWithHexString:@"#bfbfbf" alpha:1].CGColor;
                if (_xingxing <=2)
                {
                    _numberthree = @"0";
                }else
                {
                    _numbersix = @"0";
                }
                //                    _numberthree = @"0";
                _biaoqianthree = NO;
            }else
            {
                UIButton *button = (UIButton *)[self.view viewWithTag:102];
                [button setBackgroundColor:[UIColor colorWithHexString:@"#fcddaf" alpha:1]];
                [button setTitleColor:[UIColor colorWithHexString:@"#ff5a00" alpha:1] forState:UIControlStateNormal];
                button.layer.borderColor = [UIColor colorWithHexString:@"#f6b78a" alpha:1].CGColor;
                if (_xingxing <=2)
                {
                    _numberthree = @"1";
                }else
                {
                    _numbersix = @"1";
                }
                
                //                    _numberthree = @"1";
                _biaoqianthree = YES;
            }
            
            break;
        }
            
        default:
            break;
    }
    //    if (_biaoqian)
    //    {
    //        [sender setBackgroundColor:[UIColor colorWithHexString:@"#ffffff" alpha:1]];
    //        [sender setTitleColor:[UIColor colorWithHexString:@"#999999" alpha:1] forState:UIControlStateNormal];
    //        sender.layer.borderColor = [UIColor colorWithHexString:@"#bfbfbf" alpha:1].CGColor;
    //        _numberone = @"0";
    //        _biaoqian = NO;
    //    }else
    //    {
    //        [sender setBackgroundColor:[UIColor colorWithHexString:@"#fcddaf" alpha:1]];
    //        [sender setTitleColor:[UIColor colorWithHexString:@"#ff5a00" alpha:1] forState:UIControlStateNormal];
    //        sender.layer.borderColor = [UIColor colorWithHexString:@"#f6b78a" alpha:1].CGColor;
    //        _numberone = @"1";
    //        _biaoqian = YES;
    //    }
}




- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)configCollectionView {
    // 如不需要长按排序效果，将LxGridViewFlowLayout类改成UICollectionViewFlowLayout即可
    LxGridViewFlowLayout *layout = [[LxGridViewFlowLayout alloc] init];
    _margin = 2;
    _itemWH = (self.view.tz_width - 2 * _margin - 4) / 3 - _margin;
    layout.itemSize = CGSizeMake(_itemWH, _itemWH);
    layout.minimumInteritemSpacing = _margin;
    layout.minimumLineSpacing = _margin;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0*BOScreenH/1334, self.view.tz_width, 250*BOScreenH/1334) collectionViewLayout:layout];
    CGFloat rgb = 244 / 255.0;
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0];
    _collectionView.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.scrollEnabled = NO;
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [_addImageView addSubview:_collectionView];
    [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
}

#pragma mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    if (indexPath.row == _selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"img_picbox"];
        cell.deleteBtn.hidden = YES;
        cell.gifLable.hidden = YES;
    } else {
        cell.imageView.image = _selectedPhotos[indexPath.row];
        cell.asset = _selectedAssets[indexPath.row];
        cell.deleteBtn.hidden = NO;
    }
    if (!self.allowPickingGifSwitch.isOn) {
        cell.gifLable.hidden = YES;
    }
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _selectedPhotos.count)
    {
        BOOL showSheet = self.showSheetSwitch.isOn;
        if (showSheet)
        {
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"去相册选择", nil];
            [sheet showInView:self.view];
        } else
        {
            [self pushImagePickerController];
        }
    } else { // preview photos or video / 预览照片或者视频
        id asset = _selectedAssets[indexPath.row];
        BOOL isVideo = NO;
        if ([asset isKindOfClass:[PHAsset class]]) {
            PHAsset *phAsset = asset;
            isVideo = phAsset.mediaType == PHAssetMediaTypeVideo;
        } else if ([asset isKindOfClass:[ALAsset class]]) {
            ALAsset *alAsset = asset;
            isVideo = [[alAsset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo];
        }
        if ([[asset valueForKey:@"filename"] containsString:@"GIF"] && self.allowPickingGifSwitch.isOn) {
            TZGifPhotoPreviewController *vc = [[TZGifPhotoPreviewController alloc] init];
            TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypePhotoGif timeLength:@""];
            vc.model = model;
            [self presentViewController:vc animated:YES completion:nil];
        } else if (isVideo) { // perview video / 预览视频
            TZVideoPlayerController *vc = [[TZVideoPlayerController alloc] init];
            TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypeVideo timeLength:@""];
            vc.model = model;
            [self presentViewController:vc animated:YES completion:nil];
        } else { // preview photos / 预览照片
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_selectedAssets selectedPhotos:_selectedPhotos index:indexPath.row];
            imagePickerVc.maxImagesCount = 3;
            imagePickerVc.allowPickingOriginalPhoto = NO;
            imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                _selectedPhotos = [NSMutableArray arrayWithArray:photos];
                _selectedAssets = [NSMutableArray arrayWithArray:assets];
                _isSelectOriginalPhoto = isSelectOriginalPhoto;
                [_collectionView reloadData];
                _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
            }];
            [self presentViewController:imagePickerVc animated:YES completion:nil];
        }
    }
}

#pragma mark - LxGridViewDataSource

/// 以下三个方法为长按排序相关代码
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.item < _selectedPhotos.count;
}

- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath canMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    return (sourceIndexPath.item < _selectedPhotos.count && destinationIndexPath.item < _selectedPhotos.count);
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath didMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    UIImage *image = _selectedPhotos[sourceIndexPath.item];
    [_selectedPhotos removeObjectAtIndex:sourceIndexPath.item];
    [_selectedPhotos insertObject:image atIndex:destinationIndexPath.item];
    
    id asset = _selectedAssets[sourceIndexPath.item];
    [_selectedAssets removeObjectAtIndex:sourceIndexPath.item];
    [_selectedAssets insertObject:asset atIndex:destinationIndexPath.item];
    
    [_collectionView reloadData];
}

#pragma mark - TZImagePickerController

- (void)pushImagePickerController {
    //    if (self.maxCountTF.text.integerValue <= 0) {
    ////        return;
    //    }
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:3 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    
    
    //#pragma mark - 四类个性化设置，这些参数都可以不传，此时会走默认设置
    //    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    //
    //    if (self.maxCountTF.text.integerValue > 1)
    //    {
    //        // 1.设置目前已经选中的图片数组
    imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    //    }
    imagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮
    //    imagePickerVc.naviBgColor = [UIColor colorWithHexString:@"#2d84f2" alpha:1];
    //
    //    // 2. Set the appearance
    //    // 2. 在这里设置imagePickerVc的外观
    //    // imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
    //    // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    //    // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
    //    // imagePickerVc.navigationBar.translucent = NO;
    //
    //    // 3. Set allow picking video & photo & originalPhoto or not
    //    // 3. 设置是否可以选择视频/图片/原图
    ////    imagePickerVc.allowPickingVideo = self.allowPickingVideoSwitch.isOn;
    //    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    ////    imagePickerVc.allowPickingGif = self.allowPickingGifSwitch.isOn;
    //
    //    // 4. 照片排列按修改时间升序
    //    imagePickerVc.sortAscendingByModificationDate = YES;
    //
    //    // imagePickerVc.minImagesCount = 3;
    //    // imagePickerVc.alwaysEnableDoneBtn = YES;
    //
    //    // imagePickerVc.minPhotoWidthSelectable = 3000;
    //    // imagePickerVc.minPhotoHeightSelectable = 2000;
    //
    //    /// 5. Single selection mode, valid when maxImagesCount = 1
    ////    /// 5. 单选模式,maxImagesCount为1时才生效
    ////    imagePickerVc.showSelectBtn = NO;
    ////    imagePickerVc.allowCrop = self.allowCropSwitch.isOn;
    ////    imagePickerVc.needCircleCrop = self.needCircleCropSwitch.isOn;
    ////    imagePickerVc.circleCropRadius = 100;
    //    /*
    //     [imagePickerVc setCropViewSettingBlock:^(UIView *cropView) {
    //     cropView.layer.borderColor = [UIColor redColor].CGColor;
    //     cropView.layer.borderWidth = 2.0;
    //     }];*/
    //
    //    //imagePickerVc.allowPreview = NO;
    //#pragma mark - 到这里为止
    //
    //    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - UIImagePickerController

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无相机权限 做一个友好的提示
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
        // 拍照之前还需要检查相册权限
    } else if ([TZImageManager authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        alert.tag = 1;
        [alert show];
    } else if ([TZImageManager authorizationStatus] == 0) { // 正在弹框询问用户是否允许访问相册，监听权限状态
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            return [self takePhoto];
        });
    } else { // 调用相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerVc.sourceType = sourceType;
            if(iOS8Later) {
                _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            [self presentViewController:_imagePickerVc animated:YES completion:nil];
        } else {
            NSLog(@"模拟器中无法打开照相机,请在真机中使用");
        }
    }
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:3 delegate:self];
        tzImagePickerVc.sortAscendingByModificationDate = self.sortAscendingSwitch.isOn;
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image completion:^(NSError *error){
            if (error) {
                [tzImagePickerVc hideProgressHUD];
                NSLog(@"图片保存失败 %@",error);
            } else {
                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                        [tzImagePickerVc hideProgressHUD];
                        TZAssetModel *assetModel = [models firstObject];
                        if (tzImagePickerVc.sortAscendingByModificationDate) {
                            assetModel = [models lastObject];
                        }
                        if (self.allowCropSwitch.isOn) { // 允许裁剪,去裁剪
                            TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initCropTypeWithAsset:assetModel.asset photo:image completion:^(UIImage *cropImage, id asset) {
                                [self refreshCollectionViewWithAddedAsset:asset image:cropImage];
                            }];
                            imagePicker.needCircleCrop = self.needCircleCropSwitch.isOn;
                            imagePicker.circleCropRadius = 100;
                            [self presentViewController:imagePicker animated:YES completion:nil];
                        } else {
                            [self refreshCollectionViewWithAddedAsset:assetModel.asset image:image];
                        }
                    }];
                }];
            }
        }];
    }
}

- (void)refreshCollectionViewWithAddedAsset:(id)asset image:(UIImage *)image {
    [_selectedAssets addObject:asset];
    [_selectedPhotos addObject:image];
    [_collectionView reloadData];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) { // take photo / 去拍照
        [self takePhoto];
    } else if (buttonIndex == 1) {
        [self pushImagePickerController];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
        if (iOS8Later) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        } else {
            NSURL *privacyUrl;
            if (alertView.tag == 1) {
                privacyUrl = [NSURL URLWithString:@"prefs:root=Privacy&path=PHOTOS"];
            } else {
                privacyUrl = [NSURL URLWithString:@"prefs:root=Privacy&path=CAMERA"];
            }
            if ([[UIApplication sharedApplication] canOpenURL:privacyUrl]) {
                [[UIApplication sharedApplication] openURL:privacyUrl];
            } else {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"抱歉" message:@"无法跳转到隐私设置页面，请手动前往设置页面，谢谢" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
        }
    }
}

#pragma mark - TZImagePickerControllerDelegate

/// User click cancel button
/// 用户点击了取消
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    // NSLog(@"cancel");
}

// The picker should dismiss itself; when it dismissed these handle will be called.
// If isOriginalPhoto is YES, user picked the original photo.
// You can get original photo with asset, by the method [[TZImageManager manager] getOriginalPhotoWithAsset:completion:].
// The UIImage Object in photos default width is 828px, you can set it by photoWidth property.
// 这个照片选择器会自己dismiss，当选择器dismiss的时候，会执行下面的代理方法
// 如果isSelectOriginalPhoto为YES，表明用户选择了原图
// 你可以通过一个asset获得原图，通过这个方法：[[TZImageManager manager] getOriginalPhotoWithAsset:completion:]
// photos数组里的UIImage对象，默认是828像素宽，你可以通过设置photoWidth属性的值来改变它
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    self.isReupload = NO;
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    [_collectionView reloadData];
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
    
    // 1.打印图片名字
    [self printAssetsName:assets];
}

// If user picking a video, this callback will be called.
// If system version > iOS8,asset is kind of PHAsset class, else is ALAsset class.
// 如果用户选择了一个视频，下面的handle会被执行
// 如果系统版本大于iOS8，asset是PHAsset类的对象，否则是ALAsset类的对象
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[coverImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    // open this code to send video / 打开这段代码发送视频
    // [[TZImageManager manager] getVideoOutputPathWithAsset:asset completion:^(NSString *outputPath) {
    // NSLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
    // Export completed, send video here, send by outputPath or NSData
    // 导出完成，在这里写上传代码，通过路径或者通过NSData上传
    
    // }];
    [_collectionView reloadData];
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
}

// If user picking a gif image, this callback will be called.
// 如果用户选择了一个gif图片，下面的handle会被执行
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingGifImage:(UIImage *)animatedImage sourceAssets:(id)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[animatedImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    [_collectionView reloadData];
}

#pragma mark - <ImageUploadManagerDelegate>

- (void)imageUploadManagerUploadImagesSuccess:(ImageUploadManager *)manager {
    NSArray *keys = [manager.imagesDic objectForKey:uploadKeysKey];
    NSMutableArray *changeKeys = [NSMutableArray array];
    for (NSString *key in keys) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:key forKey:@"image_url"];
        [changeKeys addObject:dic];
    }
    [self writeCommentsDataWithKeys:changeKeys];
}
- (void)imageUploadManagerUploadImagesFail:(ImageUploadManager *)manager{
    self.rightButton.enabled = YES;
    [self toast:@"图片上传失败" complete:nil];
}

#pragma mark - Click Event

- (void)deleteBtnClik:(UIButton *)sender {
    self.isReupload = NO;
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_selectedAssets removeObjectAtIndex:sender.tag];
    
    
    
    
    [_collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [_collectionView reloadData];
    }];
}

- (IBAction)showTakePhotoBtnSwitchClick:(UISwitch *)sender {
    if (sender.isOn) {
        [_showSheetSwitch setOn:NO animated:YES];
        [_allowPickingImageSwitch setOn:YES animated:YES];
    }
}

- (IBAction)showSheetSwitchClick:(UISwitch *)sender {
    if (sender.isOn) {
        [_showTakePhotoBtnSwitch setOn:NO animated:YES];
        [_allowPickingImageSwitch setOn:YES animated:YES];
    }
}

- (IBAction)allowPickingOriginPhotoSwitchClick:(UISwitch *)sender {
    if (sender.isOn) {
        [_allowPickingImageSwitch setOn:YES animated:YES];
        [self.needCircleCropSwitch setOn:NO animated:YES];
        [self.allowCropSwitch setOn:NO animated:YES];
    }
}

- (IBAction)allowPickingImageSwitchClick:(UISwitch *)sender {
    if (!sender.isOn) {
        [_allowPickingOriginalPhotoSwitch setOn:NO animated:YES];
        [_showTakePhotoBtnSwitch setOn:NO animated:YES];
        [_allowPickingVideoSwitch setOn:YES animated:YES];
        [_allowPickingGifSwitch setOn:NO animated:YES];
    }
}

- (IBAction)allowPickingGifSwitchClick:(UISwitch *)sender {
    if (sender.isOn) {
        [_allowPickingImageSwitch setOn:YES animated:YES];
    }
}

- (IBAction)allowPickingVideoSwitchClick:(UISwitch *)sender {
    if (!sender.isOn) {
        [_allowPickingImageSwitch setOn:YES animated:YES];
    }
}

- (IBAction)allowCropSwitchClick:(UISwitch *)sender {
    if (sender.isOn) {
        self.maxCountTF.text = @"1";
        [self.allowPickingOriginalPhotoSwitch setOn:NO animated:YES];
    } else {
        [self.needCircleCropSwitch setOn:NO animated:YES];
    }
}

- (IBAction)needCircleCropSwitchClick:(UISwitch *)sender {
    if (sender.isOn) {
        [self.allowCropSwitch setOn:YES animated:YES];
        self.maxCountTF.text = @"1";
        [self.allowPickingOriginalPhotoSwitch setOn:NO animated:YES];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - Private

/// 打印图片名字
- (void)printAssetsName:(NSArray *)assets {
    NSString *fileName;
    for (id asset in assets) {
        if ([asset isKindOfClass:[PHAsset class]]) {
            PHAsset *phAsset = (PHAsset *)asset;
            fileName = [phAsset valueForKey:@"filename"];
        } else if ([asset isKindOfClass:[ALAsset class]]) {
            ALAsset *alAsset = (ALAsset *)asset;
            fileName = alAsset.defaultRepresentation.filename;;
        }
        //NSLog(@"图片名字:%@",fileName);
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (NSArray *)uploadKeysWithCount:(NSInteger)count {
    NSMutableArray *keys = [NSMutableArray array];
    for (NSInteger i = 0; i < count; i ++) {
         NSString *key = [NSString stringWithFormat:@"dianping_%@_%ld",USERUID, (long)([[NSDate date] timeIntervalSince1970] * 1000) + i];
        [keys addObject:key];
    }
    return keys;
}

- (void)compressImages:(NSArray *)images {
    [self.uploadImages removeAllObjects];
    for (UIImage *image in images) {
        UIImage *newImgae = [UIImage imageWithData:[ImageConpressManager generateMidImageDataWithImage:image]];
        [self.uploadImages addObject:newImgae];
    }
}

#pragma mark - reget

- (NSMutableArray *)uploadImages {
    if (!_uploadImages) {
        _uploadImages = [NSMutableArray array];
    }
    return _uploadImages;
}

#pragma mark - helpMethod

- (void)postNotifaction {
    [[NSNotificationCenter defaultCenter] postNotificationName:WriteCommentComplish object:nil userInfo:nil];
}

@end
