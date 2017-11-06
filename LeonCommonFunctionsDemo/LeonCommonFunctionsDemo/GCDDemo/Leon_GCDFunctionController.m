//
//  Leon_GCDFunctionController.m
//  LeonCommonFunctionsDemo
//
//  Created by Leon on 2017/7/19.
//  Copyright © 2017年 Leon_. All rights reserved.
//

#import "Leon_GCDFunctionController.h"

@interface Leon_GCDFunctionController ()

@property (nonatomic, copy, readwrite) NSArray *gcdFunctionNameArray;

@end

@implementation Leon_GCDFunctionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *gcdFunctionNameArray = @[@"1.异步执行 + 并行队列",
                                      @"2.异步执行 + 串行队列",
                                      @"3.同步执行 + 并行队列",
                                      @"4.同步执行 + 串行队列",
                                      @"5.异步执行 + 主队列",
                                      @"6.同步执行 + 主队列"];
    self.gcdFunctionNameArray = gcdFunctionNameArray;
}

#pragma mark - 1.异步执行 + 并行队列
/*
 * *异步执行意味着:1.可以开启新的线程, 2.任务可以先绕过不执行，回头再来执行
 * *并行队列意味着:1.任务之间不需要排队，且具有同时被执行的“权利”
 * *两者组合后的结果:1.开了三个新线程,2.函数在执行时，先打印了start和end，再回头执行这三个任务3.这三个任务是同时执行的，没有先后，所以打印结果是“任务3-->任务2-->任务1”
 *
 */
- (void)asyncConcurrent{
    //创建一个并行队列
    dispatch_queue_t queue = dispatch_queue_create("标识符", DISPATCH_QUEUE_CONCURRENT);
    
    NSLog(@"---start---");
    
    //使用异步函数封装三个任务
    dispatch_async(queue, ^{
        NSLog(@"任务1---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务2---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务3---%@", [NSThread currentThread]);
    });
    
    NSLog(@"---end---");
}

#pragma mark - 2.异步执行 + 串行队列
/*
 * *异步执行意味着:1.可以开启新的线程, 2.任务可以先绕过不执行，回头再来执行
 * *串行队列意味着:1.任务必须按添加进队列的顺序挨个执行
 * *两者组合后的结果:1.开了一个新的子线程, 2.函数在执行时,先打印了start 和 end,再回头执行这三个任务, 3.这三个任务是按照顺序执行的,所以打印结果是"任务1 -->任务2-->任务三"
 *
 */
- (void)asyncSerial{
    //创建一个串行队列
    dispatch_queue_t queue = dispatch_queue_create("标识符", DISPATCH_QUEUE_SERIAL);
    
    NSLog(@"---start---");
    //使用异步函数封装三个任务
    dispatch_async(queue, ^{
        NSLog(@"任务1---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务2---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务3---%@", [NSThread currentThread]);
    });
    NSLog(@"---end---");
}

#pragma mark - 3.同步执行 + 并行队列
/*
 * *同步执行意味着:1.不能开启新的线程, 2.任务创建后必须执行完才能往下走
 * *并行队列意味着:1.任务必须按添加进队列的顺序挨个执行
 * *两者组合后的结果:1.所有任务都只能在主线程中执行,2.函数在执行时,必须按照代码的书写顺序一行一行的执行完才能继续
 *
 * 注意 :在这里即便是并行队列,任务可以同时执行,但是由于只存在一个主线程,所以没办法把任务分发到不同的线程去同步处理,其结果就是只能在主线程里按照顺序挨个执行了
 */
- (void)syncConcurrent{
    //创建一个并行队列
    dispatch_queue_t queue = dispatch_queue_create("标识符", DISPATCH_QUEUE_CONCURRENT);
    
    NSLog(@"---start---");
    
    //使用同步函数封装三个任务
    dispatch_sync(queue, ^{
        NSLog(@"任务1---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务2---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务3---%@", [NSThread currentThread]);
    });
    
    NSLog(@"---end---");
}

#pragma mark - 4.同步执行 + 并行队列
/*
 * *这里的执行原理和步骤图跟“同步执行+并发队列”是一样的，只要是同步执行就没法开启新的线程，所以多个任务之间也一样只能按顺序来执行
 *
 */
- (void)syncSerial{
    //创建一个串行队列
    dispatch_queue_t queue = dispatch_queue_create("标识符", DISPATCH_QUEUE_SERIAL);
    
    NSLog(@"---start---");
    //使用异步函数封装三个任务
    dispatch_sync(queue, ^{
        NSLog(@"任务1---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务2---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务3---%@", [NSThread currentThread]);
    });
    
    NSLog(@"---end---");
}

#pragma mark - 异步执行 + 主队列
/*
 * *异步执行意味着: 1.可以开启新的线程, 2.任务可以先绕过不执行，回头再来执行
 * *主队列跟串行队列的区别: 1.队列中的任务一样要按顺序执行, 2.主队列中的任务必须在主线程中执行，不允许在子线程中执行
 * *以上条件组合得出的结果: 1.所有任务都可以先跳过,之后再来按顺序执行
 */
- (void)asyncMain{
    //获取主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    NSLog(@"---start---");
    //使用异步函数封装三个任务
    dispatch_async(queue, ^{
        NSLog(@"任务1---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务2---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务3---%@", [NSThread currentThread]);
    });
    NSLog(@"---end---");
}

#pragma mark - 同步执行 + 主队列
/*
 * * 1. 主队列中的任务必须按顺序挨个执行
     2. 任务1要等主线程有空的时候（即主队列中的所有任务执行完）才能执行
     3. 主线程要执行完“打印end”的任务后才有空
     4. “任务1”和“打印end”两个任务互相等待，造成死锁
 */
- (void)syncMain {
    //获取主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    NSLog(@"---start---");
    //使用同步函数封装三个任务
    dispatch_sync(queue, ^{
        NSLog(@"任务1---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务2---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务3---%@", [NSThread currentThread]);
    });
    NSLog(@"---end---");  
}

#pragma mark - UITableViewDataSource Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.gcdFunctionNameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *idencifierCell = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idencifierCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idencifierCell];
    }
    cell.textLabel.text = self.gcdFunctionNameArray[indexPath.row];
    cell.backgroundColor = KRANDOM_COLOR;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) [self asyncConcurrent];
    if (indexPath.row == 1) [self asyncSerial];
    if (indexPath.row == 2) [self syncConcurrent];
    if (indexPath.row == 3) [self syncSerial];
    if (indexPath.row == 4) [self asyncMain];
    if (indexPath.row == 5) [self syncMain];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
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
