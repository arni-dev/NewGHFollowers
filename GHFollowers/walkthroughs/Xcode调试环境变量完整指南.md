# Xcode 调试环境变量完整指南

## 目录
1. [内存和性能相关](#内存和性能相关)
2. [Auto Layout 相关](#auto-layout-相关)
3. [图形和动画相关](#图形和动画相关)
4. [网络相关](#网络相关)
5. [本地化和国际化相关](#本地化和国际化相关)
6. [日志和控制台相关](#日志和控制台相关)
7. [SwiftUI 相关](#swiftui-相关)
8. [如何设置](#如何设置环境变量)
9. [推荐调试组合](#推荐调试组合)

---

## 内存和性能相关

### NSZombieEnabled
- **值**: `YES`
- **作用**: 将已释放的对象转换为"僵尸"对象,访问时报告详细错误信息
- **用途**: 调试 `EXC_BAD_ACCESS` 崩溃和野指针问题
- **历史**: ~2003年左右,Mac OS X 时代就存在
- **⚠️ 警告**: 会导致内存不释放,仅用于调试!

```
NSZombieEnabled = YES
```

### MallocStackLogging
- **值**: `1`
- **作用**: 记录所有内存分配的堆栈轨迹
- **用途**: 配合 Instruments 的 Leaks 工具查找内存泄漏
- **历史**: ~2005年左右引入

```
MallocStackLogging = 1
```

### MallocScribble
- **值**: `1`
- **作用**: 
  - 分配内存时填充 `0xAA`
  - 释放内存时填充 `0x55`
- **用途**: 帮助发现使用未初始化内存或已释放内存的问题
- **历史**: ~2003年,经典的内存调试技术

```
MallocScribble = 1
```

### MallocGuardEdges
- **值**: `1`
- **作用**: 在每个分配的内存块前后添加保护区
- **用途**: 检测缓冲区溢出(buffer overflow)
- **历史**: ~2005年左右

```
MallocGuardEdges = 1
```

### MallocPreScribble
- **值**: `1`
- **作用**: 在分配内存前填充 `0xAA`
- **用途**: 确保代码正确初始化内存

```
MallocPreScribble = 1
```

### MallocCheckHeapStart
- **值**: `1000` (检查前1000次分配)
- **作用**: 在指定次数的分配后开始进行堆完整性检查
- **用途**: 检测堆损坏

```
MallocCheckHeapStart = 1000
```

---

## Auto Layout 相关

### UIViewLayoutFeedbackLoopDebuggingThreshold
- **值**: `100` (循环次数阈值)
- **作用**: 当布局循环超过阈值时发出警告
- **用途**: 检测 Auto Layout 的无限循环
- **历史**: iOS 12+ (2018年)

```
UIViewLayoutFeedbackLoopDebuggingThreshold = 100
```

### UIConstraintBasedLayoutLogUnsatisfiable
- **值**: `YES`
- **作用**: 详细记录无法满足的约束
- **用途**: 调试约束冲突
- **历史**: iOS 6+ (2012年,引入 Auto Layout 时)

```
UIConstraintBasedLayoutLogUnsatisfiable = YES
```

### NSDoubleLocalizedStrings
- **值**: `YES`
- **作用**: 将所有本地化字符串显示为两倍长度
- **用途**: 测试 UI 布局是否能适应不同长度的文本
- **历史**: ~2009年,国际化测试工具

```
NSDoubleLocalizedStrings = YES
```

---

## 图形和动画相关

### CG_NUMERICS_SHOW_BACKTRACE
- **值**: `1`
- **作用**: 显示传递 NaN 或无效数值给 CoreGraphics 时的堆栈跟踪
- **用途**: 调试 NaN 错误
- **历史**: iOS 10+ (2016年)

```
CG_NUMERICS_SHOW_BACKTRACE = 1
```

### CG_CONTEXT_SHOW_BACKTRACE
- **值**: `1`
- **作用**: 显示 CoreGraphics 上下文错误的堆栈
- **用途**: 调试绘图问题
- **历史**: iOS 10+ (2016年)

```
CG_CONTEXT_SHOW_BACKTRACE = 1
```

### CA_DEBUG_TRANSACTIONS
- **值**: `1`
- **作用**: 显示 Core Animation 事务的详细信息
- **用途**: 调试动画问题
- **历史**: iOS 7+ (2013年)

```
CA_DEBUG_TRANSACTIONS = 1
```

### CA_COLOR_OPAQUE
- **值**: `1`
- **作用**: 不透明层显示为绿色,半透明层显示为红色
- **用途**: 性能优化,识别过度绘制
- **历史**: iOS 7+ (2013年)

```
CA_COLOR_OPAQUE = 1
```

### CA_COLOR_LAYER_BORDER
- **值**: `1`
- **作用**: 给所有层添加边框
- **用途**: 可视化视图层级
- **历史**: iOS 7+ (2013年)

```
CA_COLOR_LAYER_BORDER = 1
```

---

## 网络相关

### CFNETWORK_DIAGNOSTICS
- **值**: `1` (基本) 或 `3` (详细)
- **作用**: 显示网络请求的详细日志
- **用途**: 调试网络问题,查看 HTTP 请求和响应
- **历史**: iOS 4+ (2010年)

```
CFNETWORK_DIAGNOSTICS = 3
```

### NSURLConnectionLogging
- **值**: `1`
- **作用**: 记录 NSURLConnection 的详细信息
- **用途**: 调试网络连接问题
- **历史**: iOS 2+ (2008年,已过时,推荐用 URLSession)

```
NSURLConnectionLogging = 1
```

---

## 本地化和国际化相关

### AppleLanguages
- **值**: `(zh-Hans)`, `(en)`, `(ja)` 等
- **作用**: 强制应用使用指定语言
- **用途**: 测试本地化,无需修改系统设置
- **历史**: iOS 2+ (2008年)
- **🎯 非常适合您的国际化项目!**

```
AppleLanguages = (zh-Hans)
```

支持的语言代码:
- 简体中文: `zh-Hans`
- 繁体中文: `zh-Hant`
- 英文: `en`
- 日文: `ja`
- 韩文: `ko`
- 法文: `fr`
- 德文: `de`
- 西班牙文: `es`

### NSShowNonLocalizedStrings
- **值**: `YES`
- **作用**: 将未本地化的字符串转换为大写
- **用途**: 快速找出遗漏的本地化字符串
- **历史**: Mac OS X 10.2+ (2002年)
- **🎯 推荐用于检查您的国际化工作!**

```
NSShowNonLocalizedStrings = YES
```

### NSDoubleLocalizedStrings
- **值**: `YES`
- **作用**: 将本地化字符串加倍显示
- **用途**: 测试 UI 是否能适应更长的文本(德语通常比英语长30%)
- **历史**: Mac OS X 10.2+ (2002年)

```
NSDoubleLocalizedStrings = YES
```

---

## 日志和控制台相关

### OS_ACTIVITY_MODE
- **值**: `disable`
- **作用**: 禁用系统日志,让控制台更清爽
- **用途**: 只看您自己的 `print` 和 `NSLog` 输出
- **历史**: iOS 10+ (2016年,统一日志系统)
- **⭐ 强烈推荐!**

```
OS_ACTIVITY_MODE = disable
```

### NSDebugEnabled
- **值**: `YES`
- **作用**: 启用 Foundation 框架的调试输出
- **用途**: 查看 Foundation 内部行为
- **历史**: ~2001年,NeXTSTEP 时代

```
NSDebugEnabled = YES
```

### NSZombieEnabled
- **值**: `YES`
- **作用**: 启用僵尸对象
- **用途**: 内存调试
- **历史**: ~2003年

---

## SwiftUI 相关

### XCODE_RUNNING_FOR_PREVIEWS
- **值**: `1`
- **作用**: 模拟 SwiftUI Preview 环境
- **用途**: 测试只在 Preview 中运行的代码
- **历史**: iOS 13+ / Xcode 11+ (2019年)

```
XCODE_RUNNING_FOR_PREVIEWS = 1
```

### IDEPreferLogStreaming
- **值**: `YES`
- **作用**: 改善 SwiftUI Preview 的日志输出
- **用途**: 调试 Preview 问题
- **历史**: Xcode 11+ (2019年)

```
IDEPreferLogStreaming = YES
```

---

## 如何设置环境变量

### 方法1: 在 Xcode Scheme 中设置(推荐)

1. 在 Xcode 中点击顶部的 Scheme 下拉菜单
2. 选择 **Edit Scheme...**
3. 在左侧选择 **Run**
4. 选择 **Arguments** 标签页
5. 在 **Environment Variables** 区域点击 **+** 添加变量
6. 输入 **Name** 和 **Value**
7. 勾选左侧的复选框启用
8. 点击 **Close**

### 方法2: 在命令行设置(临时)

```bash
# 运行前设置
export NSZombieEnabled=YES
export MallocStackLogging=1

# 然后运行应用
```

### 方法3: 在 launch arguments 中设置

某些变量也可以通过启动参数设置:

```
-NSZombieEnabled YES
-AppleLanguages (zh-Hans)
```

---

## 推荐调试组合

### 🔧 基础日常调试组合

```
OS_ACTIVITY_MODE = disable           # 清爽的控制台
NSZombieEnabled = YES                # 检测野指针
MallocScribble = 1                   # 检测内存问题
```

**适用场景**: 日常开发,快速定位崩溃

---

### 🎨 Auto Layout 和 UI 调试组合

```
UIViewLayoutFeedbackLoopDebuggingThreshold = 100
UIConstraintBasedLayoutLogUnsatisfiable = YES
CG_NUMERICS_SHOW_BACKTRACE = 1
CG_CONTEXT_SHOW_BACKTRACE = 1
```

**适用场景**: 解决布局问题、约束冲突、NaN 错误

---

### 🌏 国际化测试组合(适合您的项目!)

```
AppleLanguages = (zh-Hans)           # 强制使用中文
NSShowNonLocalizedStrings = YES      # 找出未翻译字符串
NSDoubleLocalizedStrings = YES       # 测试长文本适应性
OS_ACTIVITY_MODE = disable           # 保持控制台清爽
```

**适用场景**: 测试本地化、验证翻译完整性

**使用步骤**:
1. 先用 `AppleLanguages = (en)` 测试英文
2. 切换到 `AppleLanguages = (zh-Hans)` 测试中文
3. 启用 `NSShowNonLocalizedStrings` 找遗漏
4. 启用 `NSDoubleLocalizedStrings` 测试布局

---

### 🚀 性能优化组合

```
CA_COLOR_OPAQUE = 1                  # 可视化不透明层
CA_COLOR_LAYER_BORDER = 1            # 显示层边界
MallocStackLogging = 1               # 记录内存分配
```

**适用场景**: 优化渲染性能、减少过度绘制

---

### 🌐 网络调试组合

```
CFNETWORK_DIAGNOSTICS = 3            # 详细的网络日志
OS_ACTIVITY_MODE = disable           # 清爽的控制台
```

**适用场景**: 调试 API 请求、网络连接问题

---

### 💥 深度内存调试组合

```
NSZombieEnabled = YES
MallocStackLogging = 1
MallocScribble = 1
MallocGuardEdges = 1
MallocPreScribble = 1
MallocCheckHeapStart = 100
```

**适用场景**: 严重的内存问题、随机崩溃
**⚠️ 警告**: 会显著降低性能,仅用于深度调试

---

## 使用技巧和注意事项

### ✅ 最佳实践

1. **不要一次性启用所有变量** - 会严重影响性能
2. **根据问题类型选择组合** - 对症下药
3. **调试完记得禁用** - 特别是 `NSZombieEnabled`
4. **使用不同的 Scheme** - 为不同的调试场景创建专用 Scheme
5. **记录有用的组合** - 保存常用的配置

### ⚠️ 注意事项

- `NSZombieEnabled` 会阻止对象释放,导致内存持续增长
- 性能分析时要禁用所有调试变量
- 发布版本务必移除所有调试变量
- 某些变量只在模拟器上有效
- 某些变量在不同 iOS 版本上行为可能不同

### 📝 创建专用调试 Scheme

**推荐做法**: 为不同调试场景创建专用 Scheme

1. **Duplicate Scheme** 创建副本
2. 命名如: "GHFollowers - Memory Debug"
3. 在该 Scheme 中设置对应的环境变量
4. 需要时切换 Scheme

常见 Scheme 配置:
- **Debug** - 基础调试变量
- **Memory Debug** - 内存相关变量
- **Layout Debug** - UI 和布局变量
- **Network Debug** - 网络相关变量
- **i18n Test** - 国际化测试变量

---

## 历史时间线

### 早期 (2001-2005)
- **Mac OS X 时代**: `NSZombieEnabled`, `MallocScribble` 等基础调试工具

### iPhone SDK 时代 (2008-2012)
- **iOS 2 (2008)**: 引入 `AppleLanguages`
- **iOS 6 (2012)**: Auto Layout 和相关调试变量

### 现代 iOS (2013-2019)
- **iOS 7 (2013)**: Core Animation 调试工具
- **iOS 10 (2016)**: 统一日志系统,CoreGraphics 调试增强
- **iOS 13 (2019)**: SwiftUI 和相关调试工具

### 当前 (2020+)
- 持续改进和新增调试功能
- Xcode Instruments 集成更深入

---

## 延伸阅读

### 官方文档
- [Technical Note TN2124: Mac OS X Debugging Magic](https://developer.apple.com/library/archive/technotes/tn2124/)
- [Debugging with Xcode](https://developer.apple.com/library/archive/documentation/DeveloperTools/Conceptual/debugging_with_xcode/)

### 推荐资源
- WWDC 视频中关于调试的 session
- Instruments 使用指南
- Memory Graph Debugger 使用

---

## 快速参考表

| 问题类型 | 推荐变量 | 优先级 |
|---------|---------|-------|
| 崩溃 | `NSZombieEnabled` | ⭐⭐⭐ |
| 约束冲突 | `UIConstraintBasedLayoutLogUnsatisfiable` | ⭐⭐⭐ |
| NaN 错误 | `CG_NUMERICS_SHOW_BACKTRACE` | ⭐⭐⭐ |
| 内存泄漏 | `MallocStackLogging` | ⭐⭐ |
| 网络问题 | `CFNETWORK_DIAGNOSTICS` | ⭐⭐ |
| 国际化 | `AppleLanguages` + `NSShowNonLocalizedStrings` | ⭐⭐⭐ |
| 控制台噪音 | `OS_ACTIVITY_MODE = disable` | ⭐⭐⭐ |

---

**最后更新**: 2024年12月
**适用版本**: Xcode 15+, iOS 17+
