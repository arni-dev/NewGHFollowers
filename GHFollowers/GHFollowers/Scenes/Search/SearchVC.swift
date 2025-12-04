//
//  SearchVC.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 20/1/2024.
//

import UIKit
import Combine

/// SearchVC 类：搜索屏幕视图控制器
/// 这是应用的主入口界面，允许用户输入 GitHub 用户名进行搜索。
class SearchVC: UIViewController {
    
    /// 存储 Combine 的订阅对象，用于内存管理。
    /// 当 SearchVC 被销毁时，这些订阅也会自动取消，防止内存泄漏。
    private var cancellables = Set<AnyCancellable>()

    /// Logo 图片视图
    /// 使用 lazy 加载，确保只有在首次使用时才创建，提高性能。
    lazy private var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.ghLogo // 设置 GitHub Logo 图片
        return imageView
    }()

    /// 用户名输入框
    /// 自定义 GFTextField 组件，用于输入 GitHub 用户名。
    lazy private var usernameTextField: GFTextField = {
        let textField = GFTextField()
        textField.delegate = self // 设置代理，处理键盘回车事件
        textField.spellCheckingType = .no // 关闭拼写检查，因为用户名通常不是单词
        return textField
    }()

    /// 操作按钮（"Get Followers"）
    /// 自定义 GFButton 组件，点击后触发搜索。
    lazy private var callToActionButton: GFButton = {
        let button = GFButton(
            color: .systemGreen, // 设置按钮颜色为系统绿色
            title: "search.getFollowers".localized, // 设置按钮标题
            systemImageName: "person.3" // 设置按钮图标（SF Symbols）
        )
        // 添加点击事件监听，点击时调用 didTapCallToActionButton 方法
        button.addTarget(self, action: #selector(didTapCallToActionButton), for: .touchUpInside)
        return button
    }()

    /// 协调器引用
    /// 使用 weak 关键字防止循环引用（Coordinator 持有 VC，VC 弱引用 Coordinator）。
    weak var coordinator: SearchCoordinator?
    
    /// 视图模型
    /// 负责处理搜索相关的业务逻辑和状态。
    private var viewModel: SearchViewModel

    /// 初始化方法
    /// - Parameter viewModel: 注入的视图模型
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    /// 从 Storyboard/XIB 初始化时调用
    /// 本项目使用纯代码布局，因此如果尝试从 Storyboard 初始化会报错。
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 视图加载完成后调用
    /// 在这里进行 UI 的初始化配置和布局。
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置视图背景颜色为系统背景色（支持深色模式）
        view.backgroundColor = .systemBackground
        // 将子视图添加到主视图中
        view.addSubviews(logoImageView, usernameTextField, callToActionButton)

        // 设置数据绑定
        setupBindings()

        // 配置各个 UI 组件的布局和属性
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        
        // 添加点击手势，点击空白处收起键盘
        createDismissKeyboardTapGesture()

        // 监听键盘布局指南，确保键盘弹出时布局正确（iOS 15+ 新特性）
        NSLayoutConstraint.activate([
            view.keyboardLayoutGuide.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor)
        ])
    }

    /// 视图即将显示时调用
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 每次进入搜索页面时清空用户名
        viewModel.username = ""
        // 隐藏导航栏，因为搜索页面不需要导航栏
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    /// 设置 Combine 数据绑定
    private func setupBindings() {
        cancellables = [
            // 监听输入框文本变化，实时更新 ViewModel 中的 username
            usernameTextField.textPublisher.sink { [weak self] text in
                self?.viewModel.username = text
            },
            // 监听 ViewModel 中 username 的变化，反向更新输入框（双向绑定）
            viewModel.$username.sink { [weak self] username in self?.usernameTextField.text = username }
        ]
    }

    /// 创建点击手势以收起键盘
    private func createDismissKeyboardTapGesture() {
        // 创建点击手势识别器，目标是 view，动作是 endEditing
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        // 将手势添加到视图中
        view.addGestureRecognizer(tap)
    }

    /// 处理操作按钮点击事件
    @objc private func didTapCallToActionButton() {
        // 检查用户名是否为空
        guard !viewModel.username.isEmpty else {
            // 如果为空，显示警告弹窗
            presentGFAlert(
                title: "search.emptyUsername".localized,
                message: "search.emptyUsernameMessage".localized,
                buttonTitle: "alert.ok".localized
            )
            return
        }

        // 收起键盘
        usernameTextField.resignFirstResponder()
        // 通过协调器导航到关注者列表页面
        coordinator?.routeToFollowerListVC(username: viewModel.username)
    }

    /// 配置 Logo 图片视图的布局
    private func configureLogoImageView() {
        // 重要：这是使用 Auto Layout 的关键一步。
        // 将此属性设置为 false，告诉系统不要将 Autoresizing Mask 转换为约束。
        // 如果不设置，手动添加的约束会与系统自动生成的约束冲突。
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        // 激活一组布局约束
        NSLayoutConstraint.activate([
            // 顶部约束：距离安全区域顶部 80 点
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            // 水平居中约束：与父视图中心对齐
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            // 高度约束：固定为 200 点
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            // 宽度约束：固定为 200 点
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }

    /// 配置输入框的布局
    private func configureTextField() {
        // 注意：GFTextField 在初始化时已经设置了 translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // 顶部约束：距离 Logo 图片底部 48 点
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            // 左边距约束：距离父视图左边 50 点
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            // 右边距约束：距离父视图右边 50 点
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            // 高度约束：固定为 50 点
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    /// 配置操作按钮的布局
    private func configureCallToActionButton() {
        // 注意：GFButton 在初始化时已经设置了 translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // 底部约束：距离安全区域底部 50 点
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            // 左边距约束：距离父视图左边 50 点
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            // 右边距约束：距离父视图右边 50 点
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            // 高度约束：固定为 50 点
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}

// MARK: - UITextFieldDelegate
extension SearchVC: UITextFieldDelegate {
    /// 当用户点击键盘上的"Go"或"Return"键时调用
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 执行与点击按钮相同的操作
        didTapCallToActionButton()
        return true
    }
}

// MARK: - SwiftUI Preview
// 使用 SwiftUI 预览 UIKit 视图控制器
#Preview {
    SearchVC(viewModel: SearchViewModel())
}
