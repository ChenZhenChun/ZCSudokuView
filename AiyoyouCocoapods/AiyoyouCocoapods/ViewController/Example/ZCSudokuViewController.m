//
//  ZCSudokuViewController.m
//  AiyoyouDemo
//
//  Created by aiyoyou on 16/7/1.
//  Copyright © 2016年 aiyoyou. All rights reserved.
//

#import "ZCSudokuViewController.h"
#import "ZCSudokuView.h"
#import "ZCSudokuCell.h"

@interface ZCSudokuViewController ()<ZCSudokuViewDelegate>
@property (nonatomic,strong)ZCSudokuView *sudokuView;
@property (nonatomic,strong)UITextField *rowTextField;
@property (nonatomic,strong)UITextField *columnTextField;
@property (nonatomic,strong)UITextField *numberTextField;
@end

@implementation ZCSudokuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"九宫格";
    self.view.backgroundColor = [UIColor grayColor];
    [self sudokuView];
    
    [self.view addSubview:self.rowTextField];
    [self.view addSubview:self.columnTextField];
    [self.view addSubview:self.numberTextField];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];
}


#pragma mark - init

- (ZCSudokuView *)sudokuView {
    if (!_sudokuView) {
        _sudokuView = [[ZCSudokuView alloc] init];
        _sudokuView.backgroundColor = [UIColor whiteColor];
        _sudokuView.columnAmount = 4;
        _sudokuView.rowAmount = 2;
        _sudokuView.number = 12;
        _sudokuView.delegate = self;
//        _sudokuView.isDrawLine = YES;
        _sudokuView.frame = CGRectMake(0,
                                       32,
                                       ([UIScreen mainScreen].bounds.size.width),
                                       150);
        [_sudokuView showWithView:self.view];
    }
    return _sudokuView;
}


#pragma mark - ShareViewDelegate

- (ZCSudokuCell *)sudokuView:(ZCSudokuView *)sudokuView cellForRowAtIndex:(NSInteger)index {
    NSLog(@"%ld",(long)index);
    ZCSudokuCell *cell = [[ZCSudokuCell alloc]init];
    cell.imageView.image = [UIImage imageNamed:@"key"];
    cell.titleLabel.text = @"微博";
    cell.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0,0);
    cell.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    cell.imageViewSize = CGSizeMake(20,20);
    __weak typeof (ZCSudokuCell *)weakCell = cell;
    [cell imageViewcornerRadius:^(CGSize imageViewSize) {
        weakCell.imageView.layer.cornerRadius = imageViewSize.width/2.0;
    }];
    return cell;
}

- (void)sudokuView:(ZCSudokuView *)sudokuView didSelectAtIndex:(NSInteger)index {
}

/**---------------------------------------------------------------------------------*/

- (UITextField *)rowTextField {
    if (!_rowTextField) {
        _rowTextField = [[UITextField alloc]init];
        _rowTextField.placeholder = @"多少行";
        _rowTextField.backgroundColor = [UIColor whiteColor];
        _rowTextField.keyboardType = UIKeyboardTypeNumberPad;
        _rowTextField.font = [UIFont systemFontOfSize:15];
        _rowTextField.textAlignment = NSTextAlignmentLeft;
        _rowTextField.frame = CGRectMake(0,
                                            0,
                                            ([UIScreen mainScreen].bounds.size.width)/3.0,
                                            30);
    }
    return _rowTextField;
}

- (UITextField *)columnTextField {
    if (!_columnTextField) {
        _columnTextField = [[UITextField alloc]init];
        _columnTextField.placeholder = @"多少列";
        _columnTextField.backgroundColor = [UIColor whiteColor];
        _columnTextField.keyboardType = UIKeyboardTypeNumberPad;
        _columnTextField.font = [UIFont systemFontOfSize:15];
        _columnTextField.textAlignment = NSTextAlignmentLeft;
        _columnTextField.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width)/3.0,
                                         0,
                                         ([UIScreen mainScreen].bounds.size.width)/3.0,
                                         30);
    }
    return _columnTextField;
}

- (UITextField *)numberTextField {
    if (!_numberTextField) {
        _numberTextField = [[UITextField alloc]init];
        _numberTextField.backgroundColor = [UIColor whiteColor];
        _numberTextField.placeholder = @"总个数";
        _numberTextField.keyboardType = UIKeyboardTypeNumberPad;
        _numberTextField.font = [UIFont systemFontOfSize:15];
        _numberTextField.textAlignment = NSTextAlignmentLeft;
        _numberTextField.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width)*2/3.0,
                                            0,
                                            ([UIScreen mainScreen].bounds.size.width)/3.0,
                                            30);
    }
    return _numberTextField;
}

- (void)saveAction {
    _sudokuView.columnAmount = [self.columnTextField.text integerValue];
    _sudokuView.rowAmount = [self.rowTextField.text integerValue];
    _sudokuView.number = [self.numberTextField.text integerValue];
    [_sudokuView reloadData];
}

@end
