# MethodSwizzle-SafeObject-Keyboard-CFAutoreleasePoolPop-Crash
解决使用了method swizzle将NSArray和NSMutableArray的objectAtIndex:等其他类进行数据安全导致的CFAutoreleasePoolPop的崩溃问题


## 测试用例：

    1.问题 ：  
    [UIKeyboardLayoutStar release]: message sent to deallocated instance 0x101055800
 
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
        Safe文件设置为挂钩NSMutableArray方法编译器标志的位置 -fno-objc-arc
 

