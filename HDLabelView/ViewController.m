//
//  ViewController.m
//  HDLabelView
//
//  Created by 洪东 on 16/1/19.
//  Copyright © 2016年 abnerh. All rights reserved.
//

#import "ViewController.h"
#import "HDLabelView.h"
#import "HDLabelViewConfig.h"

@interface ViewController ()
@property (strong,nonatomic) HDLabelView *hdLabelView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    HDLabelViewConfig *config = [HDLabelViewConfig sharedHDLabelViewConfig];
    config.backgroundColor = [UIColor lightGrayColor];
    config.textFont = [UIFont fontWithName:@"Times New Roman" size:15];
    NSArray *array = @[@"洪小东",@"洪小东洪小东",@"洪小东",@"洪小东洪小东",@"洪小东",@"洪小东",@"洪小东",@"洪小东洪小东",@"洪小东洪小东"];
    self.hdLabelView = [[HDLabelView alloc] initWithFrame:CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width-20, 0) titles:array selectedHandler:^(NSUInteger index, NSString *title) {
        NSLog(@"%lu %@",index,title);
    }];
    [self.view addSubview:self.hdLabelView];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)insertBtnClick:(id)sender {
    [self.hdLabelView insertLabelWithTitle:@"洪小东洪小东" atIndex:1 animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
