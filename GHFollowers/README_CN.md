# GHFollowers - GitHub 关注者查看器

<div align="center">

![Platform](https://img.shields.io/badge/platform-iOS-lightgrey.svg)
![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)
![iOS](https://img.shields.io/badge/iOS-16.0+-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

一个使用 Swift 和 UIKit 开发的 iOS 应用，用于查看和管理 GitHub 用户的关注者列表。

[功能特性](#功能特性) • [技术栈](#技术栈) • [项目架构](#项目架构) • [安装运行](#安装运行) • [使用说明](#使用说明)

</div>

---

## 📱 功能特性

### 核心功能
- ✅ **搜索用户** - 输入 GitHub 用户名搜索用户
- ✅ **查看关注者** - 浏览用户的所有关注者列表
- ✅ **用户详情** - 查看用户的详细信息（头像、简介、统计数据等）
- ✅ **收藏管理** - 收藏喜欢的用户，方便快速访问
- ✅ **离线缓存** - 头像图片自动缓存，提升加载速度

### 界面特点
- 🎨 现代化的 UI 设计
- 🌓 支持深色模式
- 📱 响应式布局，适配各种屏幕尺寸
- ⚡ 流畅的动画和交互体验

---

## 🛠 技术栈

### 开发语言与框架
- **Swift 5.9** - 主要开发语言
- **UIKit** - UI 框架
- **SwiftUI** - 部分视图组件
- **Combine** - 响应式编程框架

### 架构模式
- **MVVM-C** (Model-View-ViewModel-Coordinator)
  - **Model**: 数据模型层
  - **View**: 视图层（UIViewController）
  - **ViewModel**: 视图模型层，处理业务逻辑
  - **Coordinator**: 协调器，管理导航流程

### 核心技术
- **async/await** - 现代异步编程
- **URLSession** - 网络请求
- **NSCache** - 图片缓存
- **UserDefaults** - 本地数据持久化
- **Auto Layout** - 界面布局
- **Programmatic UI** - 纯代码布局，无 Storyboard

---

## 📂 项目结构

\`\`\`
GHFollowers/
├── App/                          # 应用核心
│   ├── AppDelegate.swift         # 应用委托
│   ├── SceneDelegate.swift       # 场景委托
│   ├── Coordinator.swift         # 协调器协议
│   └── AppCoordinator.swift      # 应用协调器
│
├── Scenes/                       # 场景模块（MVVM-C）
│   ├── Search/                   # 搜索场景
│   │   ├── SearchVC.swift
│   │   ├── SearchViewModel.swift
│   │   └── SearchCoordinator.swift
│   ├── FollowerList/             # 关注者列表场景
│   │   ├── FollowerListVC.swift
│   │   ├── FollowerListViewModel.swift
│   │   └── FollowerListCoordinator.swift
│   ├── UserInfo/                 # 用户信息场景
│   │   ├── UserInfoVC.swift
│   │   ├── UserInfoViewModel.swift
│   │   └── UserInfoCoordinator.swift
│   └── FavoriteList/             # 收藏列表场景
│       ├── FavoritesListVC.swift
│       ├── FavoriteListViewModel.swift
│       └── FavoriteListCoordinator.swift
│
├── Model/                        # 数据模型
│   ├── Follower.swift            # 关注者模型
│   └── User.swift                # 用户模型
│
├── Managers/                     # 管理器
│   ├── NetworkManager.swift      # 网络管理器
│   ├── NetworkingManager/
│   │   └── Endpoint.swift        # API 端点定义
│   └── PersistenceManager.swift  # 持久化管理器
│
├── Custom Views/                 # 自定义视图组件
│   ├── Cells/                    # 单元格
│   │   ├── FollowerCell/
│   │   │   ├── FollowerCell.swift
│   │   │   └── FollowerView.swift
│   │   └── FavoriteCell.swift
│   ├── ViewControllers/          # 自定义视图控制器
│   │   ├── GFAlertVC.swift
│   │   ├── GFDataLoadingVC.swift
│   │   ├── GFUserInfoHeaderVC.swift
│   │   └── ItemInfoVC/
│   │       ├── GFItemInfoVC.swift
│   │       ├── GFFollowerItemVC.swift
│   │       └── GFReportItemVC.swift
│   ├── Views/                    # 自定义视图
│   │   ├── GFAlertContainerView.swift
│   │   ├── GFEmptyStateView.swift
│   │   └── GFItemInfoView.swift
│   ├── Buttons/                  # 自定义按钮
│   │   └── GFButton.swift
│   ├── TextFields/               # 自定义文本框
│   │   └── GFTextField.swift
│   ├── Labels/                   # 自定义标签
│   │   ├── GFTitleLabel.swift
│   │   ├── GFBodyLabel.swift
│   │   └── GFSecondaryTitleLabel.swift
│   └── ImageViews/               # 自定义图片视图
│       └── GFAvatarImageView.swift
│
├── Extensions/                   # 扩展
│   ├── Date+Ext.swift
│   ├── String+Ext.swift
│   ├── UIView+Ext.swift
│   ├── UIViewController+Ext.swift
│   ├── UITableView+Ext.swift
│   └── Publishers+Ext.swift
│
├── Utilities/                    # 工具类
│   ├── Constants.swift           # 常量定义
│   ├── GFError.swift             # 错误类型
│   └── UIHelper.swift            # UI 辅助工具
│
├── Main/                         # 主协调器
│   └── MainCoordinator.swift
│
└── Support/                      # 支持文件
    └── Assets.xcassets           # 资源文件
\`\`\`

---

## 🏗 项目架构

### MVVM-C 架构图

\`\`\`
┌─────────────────────────────────────────────────────────┐
│                     AppCoordinator                      │
│                  (应用根协调器)                          │
└────────────────────┬────────────────────────────────────┘
                     │
        ┌────────────┴────────────┐
        │                         │
┌───────▼────────┐      ┌────────▼────────┐
│ SearchCoord    │      │ FavoriteCoord   │
│ (搜索协调器)    │      │ (收藏协调器)     │
└───────┬────────┘      └────────┬────────┘
        │                        │
        │                        │
┌───────▼────────┐      ┌────────▼────────┐
│   SearchVC     │      │ FavoritesListVC │
│ (搜索视图)      │      │ (收藏列表视图)   │
└───────┬────────┘      └────────┬────────┘
        │                        │
┌───────▼────────┐      ┌────────▼────────┐
│ SearchViewModel│      │FavoriteViewModel│
│ (搜索视图模型)  │      │ (收藏视图模型)   │
└────────────────┘      └─────────────────┘
\`\`\`

### 数据流向

\`\`\`
用户操作 → ViewController → ViewModel → NetworkManager → GitHub API
                ↓              ↓              ↓
            更新UI ←─── 数据绑定 ←─── 数据处理 ←─── JSON 解析
\`\`\`

---

## 🚀 安装运行

### 环境要求
- macOS 13.0+
- Xcode 15.0+
- iOS 16.0+ 设备或模拟器

### 安装步骤

1. **克隆项目**
   \`\`\`bash
   git clone https://github.com/yourusername/GHFollowers.git
   cd GHFollowers
   \`\`\`

2. **打开项目**
   \`\`\`bash
   open GHFollowers.xcodeproj
   \`\`\`

3. **选择目标设备**
   - 在 Xcode 中选择目标设备（模拟器或真机）

4. **运行项目**
   - 点击 Xcode 的运行按钮（⌘ + R）
   - 或使用命令行：
     \`\`\`bash
     xcodebuild -scheme GHFollowers -destination 'platform=iOS Simulator,name=iPhone 15' build
     \`\`\`

---

## 📖 使用说明

### 1. 搜索用户
1. 在搜索页面输入 GitHub 用户名
2. 点击"Get Followers"按钮
3. 查看该用户的关注者列表

### 2. 查看用户详情
1. 在关注者列表中点击任意用户
2. 查看用户的详细信息：
   - 头像和用户名
   - 个人简介
   - 所在地
   - 公开仓库数
   - Gist 数量
   - 关注者/正在关注数
   - 账号创建时间

### 3. 收藏用户
1. 在用户详情页点击"Add to Favorites"
2. 用户将被添加到收藏列表
3. 在收藏标签页可以快速访问收藏的用户

### 4. 浏览关注者的关注者
1. 在用户详情页点击"Get Followers"
2. 查看该用户的关注者列表
3. 支持无限层级浏览

---

## 🔑 核心功能实现

### 网络请求
使用 `async/await` 进行异步网络请求：

\`\`\`swift
func request<T: Codable>(
    session: URLSession,
    _ endpoint: Endpoint,
    type: T.Type
) async throws -> T {
    guard let url = endpoint.url else {
        throw GFError.invalidURL
    }
    
    let request = buildRequest(from: url, methodType: endpoint.methodType)
    let (data, response) = try await session.data(for: request)
    
    guard let response = response as? HTTPURLResponse,
          (200...300) ~= response.statusCode else {
        throw GFError.invalidResponse
    }
    
    return try decoder.decode(T.self, from: data)
}
\`\`\`

### 图片缓存
使用 `NSCache` 实现图片缓存：

\`\`\`swift
func downloadImage(from urlString: String) async -> UIImage? {
    let cacheKey = NSString(string: urlString)
    
    if let image = cache.object(forKey: cacheKey) {
        return image
    }
    
    // 下载图片并缓存
    let (data, _) = try await URLSession.shared.data(from: url)
    guard let image = UIImage(data: data) else { return nil }
    
    cache.setObject(image, forKey: cacheKey)
    return image
}
\`\`\`

### 数据绑定
使用 Combine 实现响应式数据绑定：

\`\`\`swift
private func setupBindings() {
    cancellables = [
        usernameTextField.textPublisher.sink { [weak self] text in
            self?.viewModel.username = text
        },
        viewModel.$username.sink { [weak self] username in 
            self?.usernameTextField.text = username 
        }
    ]
}
\`\`\`

---

## 📝 代码规范

### 命名规范
- **类名**: 大驼峰命名法（PascalCase）
- **变量/函数**: 小驼峰命名法（camelCase）
- **常量**: 大驼峰命名法
- **协议**: 使用名词或形容词，如 `Coordinator`

### 注释规范
- 所有公开 API 使用三斜线注释（`///`）
- 复杂逻辑添加行内注释
- 使用中文注释，便于理解

### 文件组织
- 使用 `// MARK: -` 分隔代码段
- 相关功能放在同一个 extension 中
- 私有方法放在 `private extension` 中

---

## 🤝 贡献指南

欢迎贡献代码！请遵循以下步骤：

1. Fork 本项目
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

---

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情

---

## 👨‍💻 作者

**CHI YU CHAN**

---

## �� 致谢

- [GitHub API](https://docs.github.com/en/rest) - 提供数据接口
- [SF Symbols](https://developer.apple.com/sf-symbols/) - 系统图标库

---

## 📮 联系方式

如有问题或建议，欢迎通过以下方式联系：

- 提交 [Issue](https://github.com/yourusername/GHFollowers/issues)
- 发送邮件至：your.email@example.com

---

<div align="center">

**⭐ 如果这个项目对你有帮助，请给个 Star！⭐**

Made with ❤️ by CHI YU CHAN

</div>
