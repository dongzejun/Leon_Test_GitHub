//
//  LeonMainViewController.m
//  LeonCommonFunctionsDemo
//
//  Created by Leon on 2016/12/1.
//  Copyright © 2016年 Leon. All rights reserved.
//

#import "LeonMainViewController.h"
#import "LeonTestLeonTagsViewController.h"
#import "LeonTestAttributedStringViewController.h"
#import "Leon_GCDFunctionController.h"

@interface LeonMainViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *titleArray;

@end

@implementation LeonMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"LeonFunctionList";
    NSArray *titleArray = @[@"ShowLeonTagsView",
                            @"1.NSAttributedString 2.NSMutableAttributedString 3.NSMutableParagraphStyle",
                            @"GCDFunction",
                            @"标签Swift版本"];
    self.titleArray = titleArray;
}

#pragma mark - UITableViewDataSource Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.backgroundColor = KRANDOM_COLOR;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        LeonTestLeonTagsViewController *tagsVC = [[LeonTestLeonTagsViewController alloc] init];
        [self.navigationController pushViewController:tagsVC animated:YES];
    } else if (indexPath.row == 1) {
        LeonTestAttributedStringViewController *testAttributedStringVC = [[LeonTestAttributedStringViewController alloc] init];
        [self.navigationController pushViewController:testAttributedStringVC animated:YES];
    } else if (indexPath.row == 2) {
        //
        Leon_GCDFunctionController *gcdFunctionVC = [[Leon_GCDFunctionController alloc] init];
        [self.navigationController pushViewController:gcdFunctionVC animated:YES];
    } else if (indexPath.row == 3) {
        
        Leon_TagsViewController *tags_swift_vc = [[Leon_TagsViewController alloc] init];
        [self.navigationController pushViewController:tags_swift_vc animated:YES];
    }
    
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
