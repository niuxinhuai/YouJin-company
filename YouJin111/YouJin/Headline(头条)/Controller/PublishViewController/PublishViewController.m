//
//  PublishViewController.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/16.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PublishViewController.h"
#import "PublishViewController+Configuration.h"
#import "PublishViewController+Delegate.h"
#import "PublishViewController+LogicalFlow.h"

@interface PublishViewController ()

@end

@implementation PublishViewController

+(instancetype)create {
    PublishViewController *vc = [[PublishViewController alloc]initWithNibName:@"PublishViewController" bundle:nil];
    return vc;
}

- (void)dealloc {
    [self removeKeyBoardNotification];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAutoDismissKeyboardGesture];
    [self registerForKeyboardNotifications];
    [self configureViews];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}


#pragma mark - actionMethod


- (IBAction)returnAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)complishAction:(UIButton *)sender {
    if (self.headerView.plateTextField.text.length == 0) {
        [self toast:@"请选择模块" complete:nil];
        return;
    }else if (self.headerView.titleTextField.text.length == 0 || [self.headerView.titleTextField.text caculateStringLength] > 25 ) {
        [self toast:@"请检查标题字数" complete:nil];
        return;
    }else if (![self judgeImageAllLoad]) {
        [self toast:@"请检查是否全部图片上传成功" complete:nil];
        return;
    }
    [self createPublishContentModel];
    if (!self.contentModel.content || self.contentModel.content.count == 0) {
        [self toast:@"请编辑发表内容" complete:nil];
        return;
    }
    sender.enabled = NO;
    [self createNewContentWithContentPublishModel:self.contentModel];
}

- (IBAction)imagePickAction:(UIButton *)sender {
    [self openImagePickerControllerWithType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (IBAction)originalAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    sender.backgroundColor = sender.selected ? [UIColor colorWithIntRed:143 green:195 blue:31 alpha:31] : [UIColor clearColor];
}

#pragma mark - keyBoardNotification

- (void)keyboardWillShown:(NSNotification *)sender {
    [self bottomBarAnimationWithNotification:sender show:YES];
}

- (void)keyboardWillHidden:(NSNotification *)sender {
    [self bottomBarAnimationWithNotification:sender show:NO];
}


#pragma mark - reget

- (NSArray *)plates {
    return @[@"关注",@"网贷",@"原创",@"观点",@"八卦金融",@"银行",@"股市",@"基金",@"保险"];
}

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager bo_manager];
    }
    return _manager;
}

- (ImageUploadManager *)imageUploadManager {
    if (!_imageUploadManager) {
        _imageUploadManager = [ImageUploadManager imageUploadManagerWithDelegate:nil];
    }
    return _imageUploadManager;
}

#pragma mark - helpMethod


- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeKeyBoardNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)bottomBarAnimationWithNotification:(NSNotification *)sender show:(BOOL)show {
    NSDictionary* info = [sender userInfo];
    CGSize keyBoardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    NSTimeInterval duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions option = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16;
    CGFloat boottonConstant = show ? keyBoardSize.height : 0;
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        self.keyBoardBottomToSuperBottom.constant = boottonConstant;
        self.tableView.tableHeaderView.frame = CGRectMake(0, 0, [UIScreen screenWidth], 100);
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.tableView.tableHeaderView.frame = CGRectMake(0, 0, [UIScreen screenWidth], 100);
    }];
}


- (void)openImagePickerControllerWithType:(UIImagePickerControllerSourceType)type
{
    if (![UIImagePickerController isSourceTypeAvailable:type]) {
        [self toast:@"请设置访问权限" complete:nil];
        return;
    }
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.sourceType = type;
    imgPicker.delegate = self;
    imgPicker.allowsEditing = NO;
    [self presentViewController:imgPicker animated:YES completion:nil];
}

- (void)createPublishContentModel {
    self.contentModel = [[ContentPublishModel alloc]init];
    self.contentModel.uid = USERUID;
    self.contentModel.mid = @([self judgePlateIdWithPlateString:self.headerView.plateTextField.text]);
    self.contentModel.title = self.headerView.titleTextField.text;
    self.contentModel.content = [self handlePublisContents];
    self.contentModel.image_array = [self handleIamgeUrls];
    self.contentModel.is_myself = @(self.originalButton.selected);
    
}


- (NSInteger)judgePlateIdWithPlateString:(NSString *)plate {
    for (NSInteger i = 0; i < self.plates.count; i ++) {
        NSString *string = self.plates[i];
        if ([string isEqualToString:plate]) {
            return i;
        }
    }
    return 0;
}

- (BOOL)judgeImageAllLoad {
    for (ContentPartModel *model in self.datasource.contents) {
        if ([model.type integerValue] == 2 && model.status != ImageUploadSuccess) {
            return NO;
        }
    }
    return YES;
}

- (NSArray<ContentPartModel *> *)handlePublisContents {
    NSMutableArray *deletContents = [NSMutableArray array];
    NSMutableArray *array = [self.datasource.contents mutableCopy];
    for (NSInteger i = 0; i < array.count; i ++) {
        if ([array[i] isKindOfClass:[ContentPartModel class]]) {
            ContentPartModel *tool = array[i];
            if (!tool.cardImage && (!tool.word || [[tool.word trimmingCharacterWhenWhiteSpace] isEqualToString:@""])) {
                [deletContents addObject:array[i]];
            }
        }else {
            [deletContents addObject:array[i]];
        }
    }
    [array removeObjectsInArray:deletContents];
    return (NSArray<ContentPartModel *> *)array;
}

- (NSArray *)handleIamgeUrls {
    NSMutableArray *array = [NSMutableArray array];
    for (ContentPartModel *model in self.datasource.contents) {
        if ([model.type integerValue] == 2 && model.word.length > 0) {
            [array addObject:model.word];
        }
    }
    if (array.count > 0 && array.count < 3) {
        NSString *urlstring = array[0];
        [array removeAllObjects];
        [array addObject:urlstring];
    }
    return array;
}



@end
