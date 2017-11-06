//
//  LeonTestAttributedStringViewController.m
//  LeonCommonFunctionsDemo
//
//  Created by Leon on 2016/12/18.
//  Copyright © 2016年 Leon. All rights reserved.
//

#import "LeonTestAttributedStringViewController.h"

@interface LeonTestAttributedStringViewController ()

@end

@implementation LeonTestAttributedStringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 300)];
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:label];
    
    NSString *string = @"今日头条是一款基于数据挖掘的推荐引擎产品，它为用户推荐有价值的、个性化的信息，提供连接人与信息的新型服务，是国内移动互联网领域成长最快的产品服务之一。";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor redColor];   // UIColor，文本前景颜色，默认是blackColor
    dict[NSBackgroundColorAttributeName] = [UIColor yellowColor];// UIColor，文本背景颜色（不是控件View的背景颜色），默认nil
    dict[NSFontAttributeName] = [UIFont systemFontOfSize: 20];// UIFont，文本字体大小，默认 Helvetica(Neue) 12
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    paragraphStyle.minimumLineHeight = 50;            // 文本最小行距
    
    /*
    paragraphStyle.lineSpacing = 10;                  // 段落行距
    paragraphStyle.headIndent = 5;                    // 非首行文本缩进
    paragraphStyle.tailIndent = -20;                  // 文本缩进(右端)
    paragraphStyle.firstLineHeadIndent = 20;          // 首行文本缩进
    paragraphStyle.alignment = NSTextAlignmentRight;  // 文本对齐方式
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping; // 折行方式
    paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight; // 文本写入方式
    paragraphStyle.lineHeightMultiple = 3.0;          // 文本行间距是默认行间距的多少倍
    paragraphStyle.maximumLineHeight = 50;            // 文本最大行距
    paragraphStyle.minimumLineHeight = 50;            // 文本最小行距
    paragraphStyle.allowsDefaultTighteningForTruncation = YES; // 目前还不知道有什么作用
    paragraphStyle.hyphenationFactor = 1.0;// 设置每行的最后单词是否截断，在0.0-1.0之间，默认为0.0，越接近1.0单词被截断的可能性越大，
    paragraphStyle.paragraphSpacing = 10;             // 段落后面的间距
    paragraphStyle.paragraphSpacingBefore = 20;       //设置段与段之间的距离
    */
    dict[NSParagraphStyleAttributeName] = paragraphStyle;
    
    //删除线和下划线
    /*
     枚举常量 NSUnderlineStyle中的值
     NSUnderlineStyleNone        //不设置删除线
     
     NSUnderlineStyleSingle      // 设置删除线为细单实线
     NSUnderlineStyleThick       //   设置删除线为粗单实线
     NSUnderlineStyleDouble    // 设置删除线为细双实线
     
     NSUnderlinePatternSolid
     NSUnderlinePatternDot     //点
     NSUnderlinePatternDash  //虚线
     NSUnderlinePatternDashDot  //虚线和点
     NSUnderlinePatternDashDotDot  //虚线和点点
     
     NSUnderlineByWord
     */
    
    
    // NSNumber，加删除线，默认不加删除线，其它的话是加不同风格的删除线
//    dict[NSStrikethroughStyleAttributeName] = @(NSUnderlinePatternSolid | NSUnderlineStyleDouble);
    // UIColor,删除线颜色，默认等于文本前景颜色,前提是需要加删除线，和NSStrikethroughStyleAttributeName有关
//    dict[NSStrikethroughColorAttributeName] = [UIColor cyanColor];
    // NSNumber，加下划线，默认NSUnderlineStyleNone不加下划线，其它的话是加不同的下划线
    dict[NSUnderlineStyleAttributeName] = @(NSUnderlineStyleSingle);
//    // UIColor,下划线颜色，默认等于文本前景颜色,前提是需要加下划线，和NSUnderlineStyleAttributeName有关
//    dict[NSUnderlineColorAttributeName] = [UIColor blackColor];
//    // NSNumber,使文本有一种中空的效果（有立体效果）数字越大，文本填充的越满，数字越小，文本颜色越淡，不需要和NSStrokeColorAttributeName一起使用
//    dict[NSStrokeWidthAttributeName] = @1;
//    // UIColor,默认等于文本前景颜色，需要和NSStrokeWidthAttributeName一起使用
//    dict[NSStrokeColorAttributeName] = [UIColor yellowColor];
    
    label.attributedText = [[NSAttributedString alloc] initWithString:string attributes:dict];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
