//
//  ViewController.m
//  MethodSwizzle导致的Keyboard崩溃
//
//  Created by Qson on 2018/8/7.
//  Copyright © 2018年 Qson. All rights reserved.
//

#import "ViewController.h"


/**
 测试用例：
    1.问题 ：  [UIKeyboardLayoutStar release]: message sent to deallocated instance 0x101055800
 
        崩溃部分日志:
         objc_object::release() + 8
         0x18f96ba68 _Block_release + 160
         0x19761d9f4 -[UIKeyboardTaskEntry dealloc] + 68
         0x18f4de134 (anonymous namespace)::AutoreleasePoolPage::pop(void*) + 836
    2.测试环境：
        * iOS 10.3.3 (iOS11以下都测出问题，包括iOS8,iOS9)
        * 项目中拖入Safe文件夹内的文件（文件使用MethodSwizzle 实现对数组、字典 等系统方法的安全校验）
        * 开启Xcode的Zombie Objects
 
    3.如何复现：
        找到能弹出键盘的界面中，键盘显示的情况下  home app 进入后台，再单击app  图标 切换回前台时 发生crash
 
    4. 处理
        Safe文件设置为挂钩NSMutableArray方法编译器标志的位置-fno-objc-arc
 */

@interface ViewController ()
@property (nonatomic, weak) UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    UITextField *textField = [[UITextField alloc] init];
    textField.backgroundColor = [UIColor whiteColor];
    textField.frame = CGRectMake(100, 200, 100, 50);
    [self.view addSubview:textField];
    _textField = textField;
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
