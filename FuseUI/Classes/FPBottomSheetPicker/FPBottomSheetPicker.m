//
//  FPBottomSheetPicker.m
//  FUSEPRO
//
//  Created by tancheng on 2020/5/14.
//  Copyright © 2020 FUSENANO. All rights reserved.
//

#import "FPBottomSheetPicker.h"
#import "FPBottomSheetCell.h"
#import "UIColor+Hex.h"
@interface FPBottomSheetPicker ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *maskView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) UIView *headDivider;

@property (nonatomic, strong) UIButton *closeBtn;

@end

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

@implementation FPBottomSheetPicker

#pragma mark - public

+(instancetype)defaultSheet {
    FPBottomSheetPicker *picker = [[FPBottomSheetPicker alloc] init];
    [picker setupUI];
    return picker;
}

- (void)show {
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(sheetPickerTitle)]) {
        self.titleLab.text = [self.dataSource sheetPickerTitle];
    }
    [self.tableView reloadData];
    
    UIWindow *keywindow = [UIApplication sharedApplication].keyWindow;
    [keywindow addSubview:self];
    
    self.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    CGRect formFrame = self.contentView.frame;
    formFrame.origin.y = CGRectGetHeight(self.frame)-CGRectGetHeight(formFrame);
    CGRect toFrame = formFrame;
    [UIView animateWithDuration:0.25 animations:^{
        self.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        self.contentView.frame = toFrame;
    }];
    
}

#pragma mark - private

- (void)setupUI {
    
    [self addSubview:self.maskView];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.closeBtn];
    [self.contentView addSubview:self.headDivider];
    [self.contentView addSubview:self.tableView];
    
    self.frame = [UIScreen mainScreen].bounds;
    self.maskView.frame = self.bounds;
    
    self.titleLab.frame = CGRectMake(50, 0, kScreenWidth-100, 50);
    self.closeBtn.frame = CGRectMake(kScreenWidth-50, 0, 50, 50);
    self.headDivider.frame = CGRectMake(0, CGRectGetMaxY(self.titleLab.frame), CGRectGetWidth(self.frame), 1);
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.headDivider.frame), CGRectGetWidth(self.frame), 49*4);
    
    self.contentView.frame = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), CGRectGetMaxY(self.tableView.frame));
    
}

- (void)dismissPicker {
    CGRect formFrame = self.contentView.frame;
    formFrame.origin.y = CGRectGetHeight(self.frame);
    CGRect toFrame = formFrame;
    [UIView animateWithDuration:0.25 animations:^{
        self.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        self.contentView.frame = toFrame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - custom accessor

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 253) style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"FPBottomSheetCell" bundle:nil] forCellReuseIdentifier:@"FPBottomSheetCell"];
    }
    return _tableView;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [UIView new];
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPicker)];
        [_maskView addGestureRecognizer:tap];
    }
    return _maskView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (UILabel*)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.textColor = [UIColor colorWithHex:0x3F4450];
    }
    return _titleLab;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"pop_close_ic"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(dismissPicker) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (UIView *)headDivider {
    if (!_headDivider) {
        _headDivider = [UIView new];
        _headDivider.backgroundColor = [UIColor colorWithHex:0xE8E8E8];
    }
    return _headDivider;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(sheetPickerItemCount)]) {
        return [self.dataSource sheetPickerItemCount];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FPBottomSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FPBottomSheetCell" forIndexPath:indexPath];
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(sheetPickerItemTitleForIndex:)]) {
        cell.contentLab.text = [self.dataSource sheetPickerItemTitleForIndex:indexPath.row];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 49;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    if (self.delegate && [self.delegate respondsToSelector:@selector(sheetPickerDidSelectItemAtIndex:)]) {
        [self.delegate sheetPickerDidSelectItemAtIndex:indexPath.row];
    }
    [self dismissPicker];
}

@end
