//
//  CommentInsideViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/5/17.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "CommentInsideViewController.h"
#import "PLZTableViewCell.h"
#import "DPHeadView.h"
#import "DPdetailModel.h"
#import "HuifuModel.h"
#import "StarListModel.h"
#import "MessageInputView.h"
#import "TopCommentCell.h"
#import "MineHomePageViewController.h"

@interface CommentInsideViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,MessageInputViewDelegate,TopCommentCellDelegate,BONoteVerifyLogiinDelegate>
@property (nonatomic ,strong)DPHeadView *dpView;//第一个区的区头view
@property (nonatomic ,strong)UIView *moreZanView;//几个人赞的view
@property (nonatomic ,strong)DPdetailModel *model;//数据model
@property (nonatomic ,strong)UITableView *onlyTableview;
@property (nonatomic ,strong)UILabel *jigeZanLabel;//几个人点赞
@property (nonatomic ,strong)NSMutableArray *huifuresultArr;//接受回复的数组
@property (nonatomic ,strong)NSMutableArray *starlistresultArr;//点赞列表的数组
@property (nonatomic ,strong)NSMutableArray *touxiangArr;//存放头像地址的数组
@property (nonatomic ,strong)UIButton *zanbutton;//赞
@property (nonatomic ,strong)UITextView *textview;//输入评论内容
@property (nonatomic ,strong)UIView *XPLView;//写评论的view
@property (nonatomic ,assign)float yiscetion;//对一区头高度的赋值
@property (nonatomic ,assign)float lingscetion;//对零区头高度的赋值
@property (nonatomic ,assign)float imageHeight;//判读是否有图片传高度
@property (nonatomic ,strong)NSMutableArray *huifunameArr;//存放回复的名称
@property (nonatomic ,strong)UILabel *placeLabel;//默认字
@property (nonatomic ,copy)NSString *placeString;//默认字
@property (nonatomic ,strong)NSMutableArray *sanquuidArr;//接受三区的uid
@property (nonatomic ,copy)NSString *fuidstring;
@property (nonatomic ,copy)NSString *uidedString;
@property (nonatomic ,strong)MessageInputView *messgeView;//评论view
@property (nonatomic ,copy)NSString *huifuneirongString;

@property (nonatomic ,copy)NSString *pidstring;
@property (nonatomic ,strong)NSMutableArray *firstUidArr;//存放一区的uid
@end

@implementation CommentInsideViewController
- (NSMutableArray *)huifuresultArr
{
    if (_huifuresultArr == nil)
    {
        _huifuresultArr = [NSMutableArray array];
    }
    return _huifuresultArr;
}
-(NSMutableArray *)starlistresultArr
{
    if (_starlistresultArr == nil)
    {
        _starlistresultArr = [NSMutableArray array];
    }
    return _starlistresultArr;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    // 设置导航条和状态栏的背景颜色
    //把颜色转成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    //把图片设置为背景
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
//    self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:[NSString stringWithFormat:@"点评%@",self.nameString]];
    // 设置leftButtonItem
    UIBarButtonItem *btnItem = [UIBarButtonItem btnWithImage:[UIImage imageNamed:@"common_icon_back"] highImage:[UIImage imageNamed:@"common_icon_back"] target:self action:@selector(leftBarButtonItemClick)];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, btnItem];
    
    if ([_playKeyboard isEqualToString:@"playKeyboard"])
    {
        [_messgeView show];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _sanquuidArr = [NSMutableArray array];
    _huifunameArr = [NSMutableArray array];
    _touxiangArr = [NSMutableArray array];
    _firstUidArr = [NSMutableArray array];
    [self getData];//页面的接口数据
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    
    _onlyTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH-98*BOScreenH/1334-64) style:UITableViewStyleGrouped];
    [_onlyTableview registerNib:[UINib nibWithNibName:@"TopCommentCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([TopCommentCell class])];
    _onlyTableview.delegate = self;
    _onlyTableview.dataSource = self;
    _onlyTableview.showsVerticalScrollIndicator = NO;
    _onlyTableview.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _onlyTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_onlyTableview];
//    //点击tableview时隐藏键盘
//    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentTableViewTouchInSide)];
//    tableViewGesture.numberOfTapsRequired = 1;
//    tableViewGesture.cancelsTouchesInView = NO;
//    [_onlyTableview addGestureRecognizer:tableViewGesture];
    
    _dpView = [[DPHeadView alloc]init];
    [_dpView.coverButton addTarget:self action:@selector(coverButtonClick) forControlEvents:UIControlEventTouchUpInside];//零区头像的点击事件
    [_dpView.nicknameButton addTarget:self action:@selector(nicknameButtonClick) forControlEvents:UIControlEventTouchUpInside];//零区昵称的点击事件
    
    [self howManyPeoplePraiseView];//多少人赞的view
    [self zanAndCommentsView];//赞和评论的view
    
    _messgeView = [MessageInputView create];
    _messgeView.delegate = self;
    _messgeView.hidden = YES;
    _messgeView.initialBottomViewBottomConstant = -100;
    [self.view addSubview:_messgeView];
    [_messgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.right.equalTo(@0);
        make.left.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}
- (void)messageInputView:(MessageInputView *)inputView sendText:(NSString *)text
{
    _huifuneirongString = text;
    [self dianpingDetailData];
}

//- (void)commentTableViewTouchInSide
//{
//    [_textview resignFirstResponder];
//    _XPLView.frame = CGRectMake(0, BOScreenH, BOScreenW, 190*BOScreenH/1334);
//}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _XPLView.frame = CGRectMake(0, BOScreenH, BOScreenW, 190*BOScreenH/1334);
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0;
    }else if (section == 1)
    {
        return 0;
    }else
    {
        return self.huifuresultArr.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 440*BOScreenH/1334 + _lingscetion + _imageHeight;
    }else if (section == 1)
    {
        return _yiscetion;
    }else
    {
        return 16*BOScreenH/1334;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HuifuModel *model = self.huifuresultArr[indexPath.row];
    return [model topCommentCellHeight];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TopCommentCell class]) forIndexPath:indexPath];
    cell.delegate = self;
    //    cell.item = self.resultArr[indexPath.row];
    [cell updateCommentModel:self.huifuresultArr[indexPath.row]];
    //点击后的阴影效果
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return _dpView;
    }else if (section == 1)
    {
        return _moreZanView;
    }
    return nil;
}
- (void)topCommentCellAlertToLogin:(TopCommentCell *)cell
{
    if (USERUID)
    {
        _pidstring = [NSString stringWithFormat:@"%@",cell.commentModel.pid];
        [self zanOfTheData];//赞的接口
    } else
    {
        //登陆界面
        [self pushToLoginViewController];
    }
}
- (void)topCommentCellDidClickStarButton:(TopCommentCell *)cell
{
    if (USERUID)
    {
        _pidstring = [NSString stringWithFormat:@"%@",cell.commentModel.pid];
        [self zanOfTheData];//赞的接口
    } else
    {
        //登陆界面
        [self pushToLoginViewController];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (USERUID)
    {
        TopCommentCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        _messgeView.hidden = NO;
        [_messgeView show];
        [_messgeView updatePlaceholder:[NSString stringWithFormat:@"回复%@",cell.commentModel.uname]];
        
        _fuidstring = [NSString stringWithFormat:@"%@",cell.commentModel.uid];
        _uidedString = [NSString stringWithFormat:@"%@",cell.commentModel.uid];
    } else
    {
        //登陆界面
        [self pushToLoginViewController];
    }

//    if (indexPath.section == 2)
//    {
//        [_textview becomeFirstResponder];
//        [UIView animateWithDuration:0.25 animations:^{
//            _XPLView.frame = CGRectMake(0, BOScreenH-700*BOScreenH/1334-64, BOScreenW, 190*BOScreenH/1334);
//        }];
//        _placeLabel.text = [NSString stringWithFormat:@"回复%@",_huifunameArr[indexPath.row]];
//        
//        _fuidstring = [NSString stringWithFormat:@"%@",_sanquuidArr[indexPath.row]];
//        _uidedString = [NSString stringWithFormat:@"%@",_sanquuidArr[indexPath.row]];
//    }
}
//多少人赞的view
- (void)howManyPeoplePraiseView
{
    _moreZanView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 90*BOScreenH/1334)];
    _moreZanView.backgroundColor = [UIColor whiteColor];
    
    //细线
    UIView *linesView = [[UIView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 0, 720*BOScreenW/750, 1*BOScreenH/1334)];
    linesView.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
    [_moreZanView addSubview:linesView];
//    //头像
//    for (int i = 0; i < self.touxiangArr.count; i ++)
//    {
//        UIImageView *moreZanImage = [[UIImageView alloc]initWithFrame:CGRectMake(20*BOScreenW/750+i*(50*BOScreenW/750+16*BOScreenW/750), 20*BOScreenH/1334, 50*BOScreenW/750, 50*BOScreenW/750)];
//        [moreZanImage sd_setImageWithURL:[NSURL URLWithString:_touxiangArr[i]] placeholderImage:[UIImage imageNamed:@"img_zhanwei_b"]];
////        moreZanImage.image = [UIImage imageNamed:@"LOGO"];
//        moreZanImage.layer.cornerRadius = 12;
//        moreZanImage.layer.masksToBounds = YES;
//        [_moreZanView addSubview:moreZanImage];
//    }
    //几个人赞
    _jigeZanLabel = [[UILabel alloc]initWithFrame:CGRectMake(BOScreenW-215*BOScreenW/750, 30*BOScreenH/1334, 170*BOScreenW/750, 30*BOScreenH/1334)];
//    _jigeZanLabel.text = [NSString stringWithFormat:@"%@人赞",_model.star];
    _jigeZanLabel.textAlignment = NSTextAlignmentRight;
    _jigeZanLabel.textColor = [UIColor colorWithHexString:@"#b3b3b3" alpha:1];
    _jigeZanLabel.font = [UIFont systemFontOfSize:13];
    [_moreZanView addSubview:_jigeZanLabel];
    
    //箭头
    UIImageView *arrowsImage = [[UIImageView alloc]initWithFrame:CGRectMake(BOScreenW - 35*BOScreenW/750, 30*BOScreenH/1334, 15*BOScreenW/750, 30*BOScreenH/1334)];
    arrowsImage.image = [UIImage imageNamed:@"common_goto"];
    [_moreZanView addSubview:arrowsImage];
}
//赞和评论的view
- (void)zanAndCommentsView
{
    UIView *zanCoView = [[UIView alloc]initWithFrame:CGRectMake(0, BOScreenH-98*BOScreenH/1334-64, BOScreenW, 98*BOScreenH/1334)];
    zanCoView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    [self.view addSubview:zanCoView];
    
    //赞
    _zanbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    _zanbutton.frame = CGRectMake(144.5*BOScreenW/750, 29*BOScreenH/1334, 86*BOScreenW/750, 40*BOScreenH/1334);
//    [_zanbutton setImage:[UIImage imageNamed:@"nav_icon_zan_nor"] forState:UIControlStateNormal];
    [_zanbutton setTitle:@" 赞" forState:UIControlStateNormal];
    [_zanbutton setTitleColor:[UIColor colorWithHexString:@"#8f8f8f" alpha:1] forState:UIControlStateNormal];
    _zanbutton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_zanbutton addTarget:self action:@selector(zanbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    _zanbutton.adjustsImageWhenHighlighted = NO;
    [zanCoView addSubview:_zanbutton];
    
    //细线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(374*BOScreenW/750, 22*BOScreenH/1334, 1*BOScreenW/750, 54*BOScreenH/1334)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#c6c7c7" alpha:1];
    [zanCoView addSubview:lineView];
    
    //评论
    UIButton *commentbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentbutton.frame = CGRectMake(504.5*BOScreenW/750, 29*BOScreenH/1334, 116*BOScreenW/750, 40*BOScreenH/1334);
    [commentbutton setImage:[UIImage imageNamed:@"nav_icon_pinglun"] forState:UIControlStateNormal];
    [commentbutton setTitle:@" 评论" forState:UIControlStateNormal];
    [commentbutton setTitleColor:[UIColor colorWithHexString:@"#8f8f8f" alpha:1] forState:UIControlStateNormal];
    commentbutton.titleLabel.font = [UIFont systemFontOfSize:13];
    commentbutton.adjustsImageWhenHighlighted = NO;
    [commentbutton addTarget:self action:@selector(commentbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [zanCoView addSubview:commentbutton];
    
    _XPLView = [[UIView alloc]initWithFrame:CGRectMake(0, BOScreenH, BOScreenW, 190*BOScreenH/1334)];
    _XPLView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    [self.view addSubview:_XPLView];
    //textview
    _textview = [[UITextView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 20*BOScreenH/1334, 690*BOScreenW/750, 150*BOScreenH/1334)];
    _textview.delegate = self;
    _textview.layer.borderWidth = 1;
    _textview.layer.borderColor = [UIColor colorWithHexString:@"dfe3e6" alpha:1].CGColor;
    _textview.layer.cornerRadius = 6;
    _textview.layer.masksToBounds = YES;
    _textview.returnKeyType = UIReturnKeySend;
    _textview.enablesReturnKeyAutomatically = YES;
    [_XPLView addSubview:_textview];
    
    _placeLabel = [[UILabel alloc]initWithFrame:CGRectMake(7*BOScreenW/750, 15*BOScreenH/1334, BOScreenW-62*BOScreenW/750, 30*BOScreenH/1334)];
//    _placeLabel.text = @"写点评论吧";
    _placeLabel.textColor = [UIColor colorWithHexString:@"#bfbfbf" alpha:1];
    _placeLabel.backgroundColor = [UIColor clearColor];
    _placeLabel.font = [UIFont systemFontOfSize:12];
    [_textview addSubview:_placeLabel];
}
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 0)
    {
        _placeLabel.hidden = YES;
    }
    if (textView.text.length == 0)
    {
        _placeLabel.hidden = NO;
    }
}
//页面的接口数据
- (void)getData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"sid"] = USERSid;
    parameters[@"pid"] = self.pidString;
    parameters[@"out_type"] = self.outtypeString;
    parameters[@"out_id"] = self.outidString;
    [manager POST:[NSString stringWithFormat:@"%@Common/dianpingInfo",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            //第0区的数据
            _model = [DPdetailModel mj_objectWithKeyValues:responseObject[@"data"]];
            self.navigationItem.titleView = [BOSetupTitleView setupTitleViewTitle:[NSString stringWithFormat:@"点评%@",_model.pname]];
            //得到字体的高度
            _lingscetion = [self boundingRectWithString:_model.content];
            _dpView.textheight = _lingscetion;
            //判断是否有是否有图片
            if (_model.img_url.count == 0)
            {
                _imageHeight = -190*BOScreenW/750;
                _dpView.imageheight = _imageHeight;
            }else
            {
                _imageHeight = 0;
                _dpView.imageheight = _imageHeight;
            }

            _dpView.item = _model;
            
            _jigeZanLabel.text = [NSString stringWithFormat:@"%@人赞",_model.star];
            //判断是否已经点过赞
            if ([_model.is_star integerValue] == 1)
            {
                [_zanbutton setImage:[UIImage imageNamed:@"nav_icon_zan_pre"] forState:UIControlStateNormal];
                _zanbutton.userInteractionEnabled = NO;
            }else
            {
                [_zanbutton setImage:[UIImage imageNamed:@"nav_icon_zan_nor"] forState:UIControlStateNormal];
            }
            //第二区的数据
            self.huifuresultArr = [HuifuModel mj_objectArrayWithKeyValuesArray:responseObject[@"huifu"]];
            for (HuifuModel *huifumodel in self.huifuresultArr)
            {
                [_huifunameArr addObject:huifumodel.uname];
                [_sanquuidArr addObject:huifumodel.uid];
            }
            
//            NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:2];
//            [_onlyTableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            //第一区的数据
            self.starlistresultArr = [StarListModel mj_objectArrayWithKeyValuesArray:responseObject[@"star_list"]];
            for (StarListModel *modeldic in self.starlistresultArr)
            {
                [_touxiangArr addObject:modeldic.head_image];//头像图片地址
                [_firstUidArr addObject:modeldic.uid];
            }
            if (_touxiangArr.count == 0)
            {
                _yiscetion = 0.001;
                _moreZanView.hidden = YES;
//                [_onlyTableview reloadData];
//                NSIndexSet *indexSets = [[NSIndexSet alloc]initWithIndex:1];
//                [_onlyTableview reloadSections:indexSets withRowAnimation:UITableViewRowAnimationAutomatic];
            }else
            {
                _yiscetion = 90*BOScreenH/1334;
                _moreZanView.hidden = NO;
//                [_onlyTableview reloadData];
//                NSIndexSet *indexSets = [[NSIndexSet alloc]initWithIndex:1];
//                [_onlyTableview reloadSections:indexSets withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            //头像
            for (int i = 0; i < self.starlistresultArr.count; i ++)
            {
                UIImageView *moreZanImage = [[UIImageView alloc]initWithFrame:CGRectMake(20*BOScreenW/750+i*(50*BOScreenW/750+16*BOScreenW/750), 20*BOScreenH/1334, 50*BOScreenW/750, 50*BOScreenW/750)];
                [moreZanImage sd_setImageWithURL:[NSURL URLWithString:_touxiangArr[i]] placeholderImage:[UIImage imageNamed:@"pic_touxiang"]];
                moreZanImage.layer.cornerRadius = 12;
                moreZanImage.layer.masksToBounds = YES;
                [_moreZanView addSubview:moreZanImage];
                
                UIButton *headButton = [UIButton buttonWithType:UIButtonTypeCustom];
                headButton.frame = CGRectMake(20*BOScreenW/750+i*(50*BOScreenW/750+16*BOScreenW/750), 20*BOScreenH/1334, 50*BOScreenW/750, 50*BOScreenW/750);
                headButton.tag = i;
                [headButton addTarget:self action:@selector(headButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                [_moreZanView addSubview:headButton];
            }
            [_onlyTableview reloadData];
        }
        else
        {
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
//赞的点击事件
- (void)zanbuttonClick
{
    if (USERUID)
    {
        _pidstring = self.outidString;
        [self zanOfTheData];//赞的接口
    } else
    {
        //登陆界面
        [self pushToLoginViewController];
    }
}
//赞的接口
- (void)zanOfTheData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"sid"] = USERSid;
    if ([self.outtypeString isEqualToString:@"9"])
    {
        parameters[@"type_id"] = @"11";
    }else
    {
        parameters[@"type_id"] = @"5";
    }
    parameters[@"out_id"] = _pidstring;
    [manager POST:[NSString stringWithFormat:@"%@App/star",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            [_zanbutton setImage:[UIImage imageNamed:@"nav_icon_zan_pre"] forState:UIControlStateNormal];
            [self getData];//页面的接口数据
        }
        else
        {
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
//评论的点击事件
- (void)commentbuttonClick
{
    if (USERUID)
    {
        _fuidstring = @"0";
        _uidedString = _model.uid;
        
        _messgeView.hidden = NO;
        [_messgeView updatePlaceholder:@"写评论..."];
        [_messgeView show];
    } else
    {
        //登陆界面
        [self pushToLoginViewController];
    }

    
//    _fuidstring = @"0";
//    _uidedString = _model.uid;
//    _placeLabel.text = @"写点评论吧";
//    [_textview becomeFirstResponder];
//    [UIView animateWithDuration:0.25 animations:^{
//        _XPLView.frame = CGRectMake(0, BOScreenH-700*BOScreenH/1334-64, BOScreenW, 190*BOScreenH/1334);
//    }];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"])
    {
        [self dianpingDetailData];
        [_textview resignFirstResponder];
        _XPLView.frame = CGRectMake(0, BOScreenH, BOScreenW, 190*BOScreenH/1334);
        return NO;
    }
    return YES;
}
//点评的接口
- (void)dianpingDetailData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"sid"] = USERSid;
    parameters[@"uid"] = USERUID;
    parameters[@"zid"] = _model.zid;
    parameters[@"fid"] = _model.pid;
//    parameters[@"fuid"] = @"0";  @"uid";
    parameters[@"fuid"] = _fuidstring;
    parameters[@"out_type"] = self.outtypeString;
    parameters[@"content"] = _huifuneirongString;
//    parameters[@"uided"] = _model.uid; @"uid"
    parameters[@"uided"] = _uidedString;
    parameters[@"score"] = @"0";
    parameters[@"v1"] = @"0";
    parameters[@"v2"] = @"0";
    parameters[@"v3"] = @"0";
    parameters[@"v4"] = @"0";
//    parameters[@"image_array"] = @"";
    parameters[@"image_url"] = @"";
    [manager POST:[NSString stringWithFormat:@"%@App/reply",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            _messgeView.inputTextView.text = nil;
            NSLog(@"请求成功");
            [self toast:@"评论成功" complete:nil];
            [self getData];//页面的接口数据
        }
        else
        {
            [self toast:responseObject[@"msg"] complete:nil];
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
//计算label高度
- (CGFloat)boundingRectWithString:(NSString *)string
{
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 0;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15], NSFontAttributeName, paragraph, NSParagraphStyleAttributeName, nil];
    CGRect rect = [string boundingRectWithSize:CGSizeMake(BOScreenW - 70*BOScreenW/750, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dict context:nil];
    return  rect.size.height;
}
#pragma mark ---pop返回前一页---
- (void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)pushToLoginViewController {
    BONoteVerifyLogiin *noteVerifyLoginVC = [[BONoteVerifyLogiin alloc] init];
    noteVerifyLoginVC.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:noteVerifyLoginVC];
    nav.navigationBarHidden = YES;
    [self presentViewController:nav animated:YES completion:nil];
}
- (void)BONoteVerifyLoginViewControllerDidLoginSucess:(BONoteVerifyLogiin *)loginVc
{
    [self getData];
}
//cell里面的头像和名字的点击代理
- (void)topCommentCellDidClickName:(TopCommentCell *)cell
{
    [self pushUserHomePageViewControllerWithUid:cell.commentModel.uid];
}
- (void)topCommentCellDidClickHeadImageView:(TopCommentCell *)cell
{
    [self pushUserHomePageViewControllerWithUid:cell.commentModel.uid];
}
- (void)pushUserHomePageViewControllerWithUid:(NSNumber *)uid
{
    MineHomePageViewController *vc = [MineHomePageViewController create];
    vc.uid = [uid intValue];
    vc.hidesBottomBarWhenPushed = YES;
    vc.navigationController.navigationBar.hidden = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
//零区头像的点击
- (void)coverButtonClick
{
    NSNumber *nums = @([_model.uid integerValue]);
    [self pushUserHomePageViewControllerWithUid:nums];
}
- (void)nicknameButtonClick
{
    NSNumber *nums = @([_model.uid integerValue]);
    [self pushUserHomePageViewControllerWithUid:nums];
}
//一区的点击事件
- (void)headButtonClick:(UIButton *)sender
{
    NSNumber *nums = @([_firstUidArr[sender.tag] integerValue]);
    [self pushUserHomePageViewControllerWithUid:nums];
}
@end
