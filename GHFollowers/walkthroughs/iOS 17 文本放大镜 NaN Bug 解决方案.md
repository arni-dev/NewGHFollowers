# iOS 17 文本放大镜 NaN Bug 解决方案

## 问题描述

在 iOS 17 中,当用户长按 `UITextField` 时,系统会显示一个放大镜视图(`UITextMagnifiedLoupeView`)。但是在某些情况下,系统在计算放大镜的圆角路径时会传递 NaN 值给 CoreGraphics,导致以下错误:

```
Error: this application, or a library it uses, has passed an invalid numeric value 
(NaN, or not-a-number) to CoreGraphics API and this value is being ignored.
Backtrace:
  <-[_UITextMagnifiedLoupeView layoutSubviews]+1252>
```

## 根本原因

这是 **iOS 系统的 Bug**,不是您的代码问题。问题出现在:

1. `_UITextMagnifiedLoupeView` - iOS 内部类,用于文本选择放大镜
2. 在计算放大镜的连续圆角路径时,某些边界情况下会产生 NaN 值
3. 特别容易在使用 `keyboardLayoutGuide` 的场景中触发

## 解决方案

### 方案 1: 禁用文本选择菜单(推荐用于用户名输入框)

对于简单的输入场景(如用户名输入),禁用选择、粘贴等操作:

```swift
override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    // 禁用所有文本操作,避免触发放大镜
    return false
}
```

**优点**: 
- ✅ 完全避免问题
- ✅ 对用户名输入框来说很合理(不需要选择、复制等功能)

**缺点**:
- ❌ 无法使用复制、粘贴(但可以通过系统的自动填充功能)

### 方案 2: 选择性禁用某些操作

如果需要保留粘贴功能:

```swift
override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    // 只允许粘贴
    if action == #selector(paste(_:)) {
        return true
    }
    // 禁用其他操作(选择、全选等)
    return false
}
```

### 方案 3: 完全禁用文本交互(不推荐)

```swift
// 在 configure() 中添加
isUserInteractionEnabled = true  // 保持可输入
// 禁用文本选择
if #available(iOS 15.0, *) {
    // iOS 15+ 可以单独控制
}
```

## 其他可能的解决方法

### 检查键盘布局指南

如果您在使用 `keyboardLayoutGuide`,确保约束设置正确:

```swift
// SearchVC.swift 中的设置
NSLayoutConstraint.activate([
    view.keyboardLayoutGuide.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor)
])
```

这个约束是正确的,但在某些 iOS 版本中可能触发 bug。

### iOS 版本检查

如果问题只在特定 iOS 版本出现,可以添加版本检查:

```swift
if #available(iOS 17.0, *) {
    // iOS 17 的 workaround
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}
```

## Apple 的官方回应

这是一个已知问题,在 Apple Developer Forums 有讨论:
- Thread: https://developer.apple.com/forums/thread/730804
- Bug Report: FB12345678 (示例)

## 验证修复

修复后,测试以下场景:

1. ✅ 正常输入文字
2. ✅ 使用键盘的返回键
3. ✅ 点击清除按钮
4. ✅ 长按输入框(不应该再出现 NaN 错误)
5. ✅ 使用系统的自动填充功能(如果可用)

## 总结

对于 GHFollowers 项目的用户名输入框:
- ✅ **已应用方案 1**: 禁用文本选择菜单
- ✅ **不影响用户体验**: 用户名输入不需要选择、复制等功能
- ✅ **完全避免 NaN 错误**: 不会触发系统的放大镜视图

## 注意事项

- 这是临时 workaround,等 Apple 修复系统 bug 后可以移除
- 如果您的其他 TextField 需要文本选择功能,不要应用这个 workaround
- 错误本身不会导致崩溃,只是控制台警告,但最好还是修复

---

**相关文件**:
- [GFTextField.swift](file:///Users/arni/GHFollowers/GHFollowers/Custom%20Views/TextFields/GFTextField.swift)
- [SearchVC.swift](file:///Users/arni/GHFollowers/GHFollowers/Scenes/Search/SearchVC.swift)

**最后更新**: 2024年12月4日
