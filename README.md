# ZCSudokuView
a sudoku view on ios

使用前请先导入
#import "ZCSudokuView.h"
#import "ZCSudokuCell.h"
/**
 *  调用示例
 *

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分页九宫格";
    [self sudokuView];
}


#pragma mark - Properrtys
#pragma mark -- 控件初始化
- (ZCSudokuView *)sudokuView {
    if (!_sudokuView) {
        _sudokuView = [[ZCSudokuView alloc] init];
        _sudokuView.backgroundColor = [UIColor whiteColor];
        _sudokuView.columnAmount = 4;【可选配置】九宫格的列数，不设置默认4列
        _sudokuView.rowAmount = 2;//【可选配置】设置限制控件的行数
        _sudokuView.number = 12;//数据源总个数，按照实际情况赋值，如果数据源一页无法显示所有数据，九宫格会自动分页
        _sudokuView.delegate = self;
        //        _sudokuView.isDrawLine = YES;//是否显示九宫格的分割线，默认NO
        _sudokuView.frame = CGRectMake(0,
                                       32,
                                       ([UIScreen mainScreen].bounds.size.width),
                                       150);
        [_sudokuView showWithView:self.view];//将控件添加到控制器的view上
    }
    return _sudokuView;
}


#pragma mark - ShareViewDelegate
#pragma mark -- 九宫格cell赋值
- (ZCSudokuCell *)sudokuView:(ZCSudokuView *)sudokuView cellForRowAtIndex:(NSInteger)index {
    ZCSudokuCell *cell = [[ZCSudokuCell alloc]init];
    cell.imageView.image = [UIImage imageNamed:@"key"];
    cell.titleLabel.text = @"微博";
    //    cell.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0,0);
    //    cell.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    //    cell.imageViewSize = CGSizeMake(20,20);
    //    __weak typeof (ZCSudokuCell *)weakCell = cell;
    //    [cell imageViewcornerRadius:^(CGSize imageViewSize) {
    //        weakCell.imageView.layer.cornerRadius = imageViewSize.width/2.0;
    //    }];
    return cell;
}
 
 #pragma mark -- 九宫格cell点击代理，index为数据源索引
 - (void)sudokuView:(ZCSudokuView *)sudokuView didSelectAtIndex:(NSInteger)index {
    NSLog(@"%ld",(long)index);
}
 */
