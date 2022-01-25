//
//  FUDatePickerView.m
//  FUSEPRO
//
//  Created by tancheng on 2019/4/1.
//  Copyright © 2019 FUSENANO. All rights reserved.
//

#import "FUDatePickerView.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width

@interface FUDatePickerView ()<UIPickerViewDataSource, UIPickerViewDelegate> {
    
}

@property (nonatomic, assign) FUDatePickerViewType type;

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) UIView *toolbar;

@property (nonatomic, strong) NSMutableArray *yearData, *monthData, *dayData;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@property (nonatomic, strong) UIButton *closeBtn, *confirmBtn;

@property (nonatomic, strong) UILabel *titleLab;

@end

@implementation FUDatePickerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

+ (instancetype)instanceWithType:(FUDatePickerViewType)type {
    FUDatePickerView *picker = [[FUDatePickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 285)];
    picker.type = type;
    if (type != FUDatePickerViewTypeYearMonth) {
        NSAssert(false, @"FUDatePickerView暂时只支持选择年月");
    }
    return picker;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark -

- (void)setupUI {
    [self addSubview:self.toolbar];
    [self addSubview:self.pickerView];
    [self.toolbar addSubview:self.closeBtn];
    [self.toolbar addSubview:self.titleLab];
    [self.toolbar addSubview:self.confirmBtn];
    
    [self configureDefaultSelected];
}

- (void)configureDefaultSelected {
    
    if (!self.selDefaultDate) {
        self.selDefaultDate = [NSDate date];
    }
    
    NSCalendar *calendar =[NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self.selDefaultDate];
    
    NSString *year = [NSString stringWithFormat:@"%ld",components.year];
    NSInteger yearIdx = [self.yearData indexOfObject:year];
    [self.pickerView selectRow:yearIdx inComponent:0 animated:false];
    
    NSString *month = [NSString stringWithFormat:@"%ld",components.month];
    NSInteger monthIdx = [self.monthData indexOfObject:month];
    [self.pickerView selectRow:monthIdx inComponent:1 animated:false];

}

#pragma mark - UIPickerViewDataSource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    switch (self.type) {
        case FUDatePickerViewTypeYearMonth:
            return 2;
        default:
            return 0;
    }
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return self.yearData.count;
        case 1:
            return self.monthData.count;
        default:
            return 0;
    }
}

#pragma mark - UIPickerViewDelegate


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40;
}

- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
   
    UIColor *color =  [self colorWithHex:0xf40454f alpha:1];
    UIFont  *font = [UIFont fontWithName:@"Muli-Regular" size:15];
    
    switch (component) {
        case 0: {
            NSString *year = self.yearData[row];
            NSAttributedString *attr = [[NSAttributedString alloc] initWithString:year attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: color}];
            return attr;
        }
        
        case 1: {
            NSString *year = self.monthData[row];
            NSAttributedString *attr = [[NSAttributedString alloc] initWithString:year attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: color}];
            return attr;
        }
        default:
            return nil;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}

#pragma mark -

- (void)cancelAction {
    if ([self.delegate respondsToSelector:@selector(cancelSelectedDatePickerView:)]) {
        [self.delegate cancelSelectedDatePickerView:self];
    }
}

- (void)confirmAction {
    
    NSString *year = self.yearData[[self.pickerView selectedRowInComponent:0]];
    NSString *month = self.monthData[[self.pickerView selectedRowInComponent:1]];

    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.timeZone = [NSTimeZone localTimeZone];
    components.year = [year integerValue];
    components.month = [month integerValue];
    components.day = 1;
    components.hour = 1;
    components.minute = 1;
    components.second = 1;
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:components];
    
    //NSLog(@"%@",[self.dateFormatter stringFromDate:date]);
    
    if ([self.delegate respondsToSelector:@selector(selectedDatePickerView:selectedDate:)]) {
        [self.delegate selectedDatePickerView:self selectedDate:date];
    }
}

#pragma mark -

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.frame = CGRectMake(10, 0, 45, 45);
        [_closeBtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.frame = CGRectMake(CGRectGetWidth(self.bounds)-45-10, 0, 45, 45);
        [_confirmBtn setImage:[UIImage imageNamed:@"icon_confirm"] forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.frame = CGRectMake((CGRectGetWidth(self.bounds)-100)/2.0, 0, 100, 45);
        _titleLab.font = [UIFont fontWithName:@"Muli-Bold" size:16];
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.text = @"Date";
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 45, CGRectGetWidth(self.bounds), 240)];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
    }
    return _pickerView;
}

- (UIView *)toolbar {
    if (!_toolbar) {
        _toolbar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 45)];
        _toolbar.backgroundColor = [UIColor redColor];
    }
    return _toolbar;
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"yyyyMM";
    }
    return _dateFormatter;
}

- (NSMutableArray *)yearData {
    if (!_yearData) {
        _yearData = [NSMutableArray array];
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:[NSDate date]];
        NSInteger currentYear = components.year;
        NSString *year = [NSString stringWithFormat:@"%ld",(long)currentYear];
        [_yearData addObject:year];
        
    }
    return _yearData;
}

- (NSMutableArray *)monthData {
    if (!_monthData) {
        _monthData = [NSMutableArray array];
        
       NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:[NSDate date]];
        NSInteger currentMonth = components.month;
        for (NSInteger i = currentMonth-1; i < 12; i ++) {
            NSString *month = [NSString stringWithFormat:@"%ld",(i+1)];
            [_monthData addObject:month];
        }
    }
    return _monthData;
}

- (NSMutableArray *)dayData {
    if (!_dayData) {
        _dayData = [NSMutableArray array];
    }
    return _dayData;
}
- (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity
{
    float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}
//
#pragma mark -

- (void)setSelDefaultDate:(NSDate *)selDefaultDate {
    _selDefaultDate = selDefaultDate;
    [self configureDefaultSelected];
}

@end
