//
//  XJSearchBar.m
//  AiyoyouDemo
//
//  Created by aiyoyou on 16/9/23.
//  Copyright © 2016年 aiyoyou. All rights reserved.
//

#import "XJSearchBar.h"

#define kTitleContentViewH 40
#define ksudokuPadding     (14*self.scale)
#define ksudokuCellH       (30*self.scale)
#define ksudokuViewRowH    (ksudokuCellH+ksudokuPadding/2.0)


@interface XJSearchBar()<UITextFieldDelegate,ZCSudokuViewDelegate>
{
    ZCSudokuCell           *_seletedCell;//被选中的cell
    NSInteger               _oldLength;
}
@property (nonatomic,strong) UIView             *shadeBgView;//遮罩层
@property (nonatomic,strong) UIView             *textFieldContentView;
@property (nonatomic,strong) UITextField        *textField;//搜索框

@property (nonatomic,strong) UIView             *titleContentView;
@property (nonatomic,strong) UILabel            *themeTitle;//主题（“健康百科”）

@property (nonatomic,strong) UIView             *sudokuContentView;
@property (nonatomic,strong) ZCSudokuView       *sudokuView;//九宫格按钮
@property (nonatomic,strong) UIViewController   *viewControlller;

@property (nonatomic,strong) UIView             *tapBGView;

@property (nonatomic,assign) CGFloat            scale;//屏幕比例

@end

@implementation XJSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width,45);
        self.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        [self addSubview:self.textFieldContentView];
    }
    return self;
}

- (void)setDelegate:(id<XJSearchBarDelegate>)delegate {
    _delegate = delegate;
    _viewControlller = (UIViewController *)delegate;
}

- (UIView *)textFieldContentView {
    if (!_textFieldContentView) {
        _textFieldContentView = [[UIView alloc]init];
        _textFieldContentView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        _textFieldContentView.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width,45);
        [_textFieldContentView addSubview:self.filterBtn];
        [_textFieldContentView addSubview:self.textField];
    }
    return _textFieldContentView;
}

- (UIButton *)filterBtn {
    if (!_filterBtn) {
        _filterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _filterBtn.backgroundColor = [UIColor clearColor];
        [_filterBtn setTitle:@"筛选" forState:UIControlStateNormal];
        [_filterBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_filterBtn setImage:[UIImage imageNamed:@"ZCSudokuView_filte"] forState:UIControlStateNormal];
        _filterBtn.adjustsImageWhenHighlighted = NO;
        _filterBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _filterBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [_filterBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        _filterBtn.frame = CGRectMake(0,
                                      0,
                                      82,
                                      45);
    }
    return _filterBtn;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.placeholder = @"搜索";
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.layer.borderColor = [UIColor colorWithRed:207/255.0 green:210/255.0 blue:213/255.0 alpha:1].CGColor;
        _textField.returnKeyType = UIReturnKeySearch;
        _textField.layer.borderWidth = 0.5;
        _textField.layer.cornerRadius = 3;
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.frame = CGRectMake(82,15/2.0,[UIScreen mainScreen].bounds.size.width-82-15,30);
        _textField.delegate = self;
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _oldLength = _textField.text.length;
        
        CGRect frame = _textField.frame;
        frame.size.width = 20;
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 18, 12)];
        leftView.backgroundColor = [UIColor clearColor];
        [leftView addSubview:self.placeholderImageView];
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.leftView = leftView;
    }
    return _textField;
}

- (UIView *)shadeBgView {
    if (!_shadeBgView) {
        _shadeBgView = [[UIView alloc]init];
        _shadeBgView.frame = [UIScreen mainScreen].bounds;
        _shadeBgView.backgroundColor = [UIColor colorWithRed:106/255.0 green:106/255.0 blue:106/255.0 alpha:0.3];
    }
    return _shadeBgView;
}

- (UIView *)titleContentView {
    if (!_titleContentView) {
        _titleContentView = [[UIView alloc]init];
        _titleContentView.backgroundColor = [UIColor whiteColor];
        [_titleContentView addSubview:self.themeTitle];
    }
    return _titleContentView;
}

- (UILabel *)themeTitle {
    if (!_themeTitle) {
        _themeTitle = [[UILabel alloc]initWithFrame:CGRectMake(15,0,[UIScreen mainScreen].bounds.size.width-15,kTitleContentViewH)];
        _themeTitle.backgroundColor = [UIColor clearColor];
        _themeTitle.font = [UIFont systemFontOfSize:15*self.scale];
    }
    return _themeTitle;
}

- (UIView *)sudokuContentView {
    if (!_sudokuContentView) {
        _sudokuContentView = [[UIView alloc]init];
        _sudokuContentView.backgroundColor = [UIColor whiteColor];
        [_sudokuContentView addSubview:self.sudokuView];
    }
    return _sudokuContentView;
}

- (ZCSudokuView *)sudokuView {
    if (!_sudokuView) {
        _sudokuView = [[ZCSudokuView alloc]init];
        _sudokuView.columnAmount = 4.0;
        _sudokuView.delegate = self;
        _sudokuView.backgroundColor = [UIColor whiteColor];
    }
    return _sudokuView;
}

- (void)setTitle:(NSString *)title {
    _title = [NSString stringWithFormat:@"%@",title];
    NSString *title1 = @"全部";
    NSString *title2 = [NSString stringWithFormat:@"%@%@",[XJSearchBar isBlankString:_title]?@"":_title,title1];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:title2];
    [att addAttribute:NSForegroundColorAttributeName  value:[UIColor colorWithRed:28/255.0 green:164/255.0 blue:252/255.0 alpha:1] range:NSMakeRange(_title.length,title1.length)];
    self.themeTitle.attributedText = att;
}

- (NSString *)searchBarText {
    return self.textField.text;
}

- (UIView *)tapBGView {
    if (!_tapBGView) {
        _tapBGView = [[UIView alloc]init];
        _tapBGView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTapBGView)];
        [_tapBGView addGestureRecognizer:tap];
    }
    return _tapBGView;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (self.filterBtn.isSelected) {
        self.filterBtn.selected = !self.filterBtn.selected;
        [self hiddenWithDuration:0.2 animations:NO];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(XJSearchBarGoSearch:textField:)]) {
        [self.delegate XJSearchBarGoSearch:self textField:textField];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (ZCSudokuCell *)sudokuView:(ZCSudokuView *)sudokuView cellForRowAtIndex:(NSInteger)index {
    ZCSudokuCell *cell = [[ZCSudokuCell alloc]init];
    cell.titleBtnSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width-self.sudokuView.columnAmount*ksudokuPadding)/self.sudokuView.columnAmount,ksudokuCellH);
    cell.titleBtn.layer.cornerRadius = 5;
    cell.titleBtn.clipsToBounds = YES;
    [cell.titleBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    cell.backgroundColor = [UIColor whiteColor];
    cell.tag = index;
    if (!_seletedCell || _seletedCell.tag == index) {
        _seletedCell = cell;
        cell.titleBtn.backgroundColor = [UIColor colorWithRed:28/255.0 green:164/255.0 blue:252/255.0 alpha:1];
        [cell.titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else {
        cell.titleBtn.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
        [cell.titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    if ([self.delegate respondsToSelector:@selector(XJSearchBar:cellForRowAtIndext:)]) {
        [self.delegate XJSearchBar:cell cellForRowAtIndext:index];
    }
    return cell;
}

- (void)sudokuCell:(ZCSudokuCell *)cell didSelectAtIndex:(NSInteger)index {
    [self clickBtn:self.filterBtn];
    if (_seletedCell.tag != index) {
        cell.titleBtn.backgroundColor = [UIColor colorWithRed:28/255.0 green:164/255.0 blue:252/255.0 alpha:1];
        [cell.titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _seletedCell.titleBtn.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
        [cell.titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _seletedCell = cell;
        NSString *title = [NSString stringWithFormat:@"%@%@",[XJSearchBar isBlankString:self.title]?@"":self.title,[cell.titleBtn currentTitle]];
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:title];
        [att addAttribute:NSForegroundColorAttributeName  value:[UIColor colorWithRed:28/255.0 green:164/255.0 blue:252/255.0 alpha:1] range:NSMakeRange(self.title.length,[cell.titleBtn currentTitle].length)];
        self.themeTitle.attributedText = att;
    }
    if ([self.delegate respondsToSelector:@selector(XJSearchBar:didSelectedCellWithIndex:)]) {
        [self.delegate XJSearchBar:cell didSelectedCellWithIndex:index];
    }
}

- (void)showWithDuration:(NSTimeInterval)duration animations:(BOOL)animations {
    [self.viewControlller.view addSubview:self.shadeBgView];
    [self.shadeBgView addSubview:self.textFieldContentView];
    [self.shadeBgView addSubview:self.titleContentView];
    [self.shadeBgView addSubview:self.sudokuContentView];
    [self.sudokuView showWithView:_sudokuContentView];
    [self.shadeBgView addSubview:self.tapBGView];
    
    self.sudokuView.number = self.number;
    NSInteger rowAmount = ceilf(self.number/(CGFloat)self.sudokuView.columnAmount);
    
    float y = -(45+kTitleContentViewH+rowAmount*ksudokuViewRowH);
    self.titleContentView.frame = CGRectMake(0,
                                             y,
                                             [UIScreen mainScreen].bounds.size.width,
                                             kTitleContentViewH);
    self.sudokuContentView.frame = CGRectMake(0,
                                              y,
                                              [UIScreen mainScreen].bounds.size.width,
                                              rowAmount*ksudokuViewRowH+20);
    self.sudokuView.frame = CGRectMake((15-ksudokuPadding),
                                       0,
                                       [UIScreen mainScreen].bounds.size.width-(15-ksudokuPadding)*2,
                                       rowAmount*ksudokuViewRowH);
    [self.sudokuView reloadData];
    if (animations) {
        __weak typeof(self)weakSelf = self;
        [UIView animateWithDuration:duration animations:^{
            __strong typeof(self)strongSelf = weakSelf;
            strongSelf.titleContentView.frame = CGRectMake(0,45,[UIScreen mainScreen].bounds.size.width,kTitleContentViewH);
            strongSelf.sudokuContentView.frame = CGRectMake(0,
                                                            45+kTitleContentViewH,
                                                            [UIScreen mainScreen].bounds.size.width,
                                                            rowAmount*ksudokuViewRowH+20);
            self.tapBGView.frame = CGRectMake(0,
                                              CGRectGetMaxY(_sudokuContentView.frame),
                                              [UIScreen mainScreen].bounds.size.width,
                                              [UIScreen mainScreen].bounds.size.height-CGRectGetMaxY(_sudokuContentView.frame)-64);
        }completion:^(BOOL finished) {
            
        }];
    }else {
        self.titleContentView.frame = CGRectMake(0,45,[UIScreen mainScreen].bounds.size.width,kTitleContentViewH);
        self.sudokuContentView.frame = CGRectMake(0,
                                                  45+kTitleContentViewH,
                                                  [UIScreen mainScreen].bounds.size.width,
                                                  rowAmount*ksudokuViewRowH+20);
        self.tapBGView.frame = CGRectMake(0,
                                          CGRectGetMaxY(_sudokuContentView.frame),
                                          [UIScreen mainScreen].bounds.size.width,
                                          [UIScreen mainScreen].bounds.size.height-CGRectGetMaxY(_sudokuContentView.frame)-64);
    }
}

- (void)hiddenWithDuration:(NSTimeInterval)duration animations:(BOOL)animations {
    [self addSubview:self.textFieldContentView];
    NSInteger rowAmount = ceilf(self.number/(CGFloat)self.sudokuView.columnAmount);
    float y = -(45+kTitleContentViewH+rowAmount*ksudokuViewRowH);
    if (animations) {
        __weak typeof(self)weakSelf = self;
        [UIView animateWithDuration:duration animations:^{
            __strong typeof(self)strongSelf = weakSelf;
            strongSelf.titleContentView.frame = CGRectMake(0,y,[UIScreen mainScreen].bounds.size.width,0);
            strongSelf.sudokuView.frame = CGRectMake(0,y,[UIScreen mainScreen].bounds.size.width,0);
        } completion:^(BOOL finished) {
            __strong typeof(self)strongSelf = weakSelf;
            [strongSelf.shadeBgView removeFromSuperview];
        }];
    }else {
        self.titleContentView.frame = CGRectMake(0,y,[UIScreen mainScreen].bounds.size.width,0);
        self.sudokuView.frame = CGRectMake(0,y,[UIScreen mainScreen].bounds.size.width,0);
        [self.shadeBgView removeFromSuperview];
    }
}

- (void)clickBtn:(UIButton *)send {
    if (self.number==0) {
        return;
    }
    send.selected = !send.selected;
    if (send.isSelected) {
        [_textField resignFirstResponder];
        [self showWithDuration:0.2 animations:NO];
    }else {
        [self hiddenWithDuration:0.2 animations:NO];
    }
}

- (void)clickTapBGView {
    [self clickBtn:self.filterBtn];
}

//过滤emoji表情
- (void)textFieldDidChange:(UITextField *)textField {
    if ([XJSearchBar stringContainsEmoji:textField.text]) {
        textField.text = [textField.text substringToIndex:_oldLength];
        return;
    }
    if (textField == self.textField && textField.text.length && !textField.markedTextRange) {
        _oldLength = textField.text.length;
    }else if(textField.text.length == 0) {
        _oldLength = 0;
    }
    if ([self.delegate respondsToSelector:@selector(XJSearchBarDidChange:textField:)]) {
        [self.delegate XJSearchBarDidChange:self textField:textField];
    }
}

#pragma mark - Properties

- (CGFloat)scale {
    if (_scale == 0) {
        _scale = ([UIScreen mainScreen].bounds.size.height>480?[UIScreen mainScreen].bounds.size.height/667.0:0.851574);
    }
    return _scale;
}

- (UIImageView *)placeholderImageView {
    if (!_placeholderImageView) {
        _placeholderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 13, 12)];
        _placeholderImageView.image = [UIImage imageNamed:@"ZCSudokuView_SearchIcon"];
    }
    return _placeholderImageView;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    self.textFieldContentView.backgroundColor = backgroundColor;
    super.backgroundColor = backgroundColor;
}

#pragma mark - 判断是否为空
+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

//是否包含emoji表情
+ (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f9dc) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3 || ls == 0xfe0f) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

@end
