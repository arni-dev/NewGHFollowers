//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 30/1/2024.
//

import UIKit
import SafariServices
import Combine

/// UserInfoVCDelegate 协议：用户信息视图控制器代理
/// 用于处理请求查看关注者的事件
protocol UserInfoVCDelegate: AnyObject {
    /// 请求查看关注者时调用
    /// - Parameter username: 用户名
    func didRequestFollowers(for username: String)
}

/// UserInfoVC 类：用户信息视图控制器
/// 显示用户的详细信息，包括头部信息、仓库统计、关注者统计和注册日期
/// 继承自 GFDataLoadingVC 以获得加载指示器功能
class UserInfoVC: GFDataLoadingVC {
    /// Combine 订阅集合
    private var cancellables = Set<AnyCancellable>()

    /// 滚动视图：支持在小屏幕上滚动查看内容
    let scrollView = UIScrollView()
    /// 内容视图：包含所有子视图的容器
    let contentView = UIView()

    /// 头部视图容器
    let headerView = UIView()
    /// 信息项视图容器 1（仓库/Gist）
    let itemViewOne = UIView()
    /// 信息项视图容器 2（关注者/正在关注）
    let itemViewTwo = UIView()
    /// 注册日期标签
    let dateLabel = GFBodyLabel(textAlignment: .center)
    /// 视图容器数组，用于批量布局
    var itemViews: [UIView] = []

    /// 用户名
    var username: String!

    /// 协调器的弱引用
    weak var coordinator: UserInfoCoordinator?
    /// 代理对象
    weak var delegate: UserInfoVCDelegate?
    /// 视图模型
    private let viewModel: UserInfoViewModel

    /// 初始化方法
    /// - Parameter viewModel: 用户信息视图模型
    init(viewModel: UserInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    /// 从 Storyboard/XIB 初始化时调用
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 视图加载完成后调用
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置数据绑定
        setupBindings()

        // 配置 UI
        configureViewController()
        configureScrollView()
        layoutUI()

        // 获取用户信息
        getUserInfo()
    }

    /// 设置 Combine 数据绑定
    func setupBindings() {
        cancellables = [
            // 监听用户数据的变化
            viewModel.$user
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { [weak self] user in
                    guard let self, let user else { return }
                    // 更新 UI 元素
                    self.configureUIElements(with: user)
                })
        ]
    }

    /// 配置视图控制器的基本属性
    func configureViewController() {
        view.backgroundColor = .systemBackground
        // 添加完成按钮
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDoneButton))
        navigationItem.rightBarButtonItem = doneButton
    }

    /// 配置滚动视图
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        // 固定滚动视图到边缘
        scrollView.pinToEdges(of: view)
        // 固定内容视图到滚动视图边缘
        contentView.pinToEdges(of: scrollView)

        NSLayoutConstraint.activate([
            // 内容视图宽度等于滚动视图宽度
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            // 设置固定高度（根据内容调整）
            contentView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }

    /// 获取用户信息
    func getUserInfo() {
        Task {
            do {
                // 异步获取用户信息
                try await viewModel.getUserInfo(for: username)
            } catch {
                // 错误处理
                if let gfError = error as? GFError {
                    presentGFAlert(title: "alert.somethingWentWrong".localized, message: gfError.rawValue, buttonTitle: "alert.ok".localized)
                }
            }
        }
    }

    /// 配置 UI 元素内容
    /// - Parameter user: 用户数据对象
    func configureUIElements(with user: User) {
        // 添加子视图控制器
        self.add(childVC: GFReportItemVC(user: user, delegate: self), to: self.itemViewOne)
        self.add(childVC: GFFollowerItemVC(user: user, delegate: self), to: self.itemViewTwo)
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        // 设置注册日期
        self.dateLabel.text = String(format: "userInfo.githubSince".localized, user.createdAt.convertToMonthYearFormat())
    }

    /// 配置 UI 布局约束
    func layoutUI() {
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140

        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        for itemView in itemViews {
            contentView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
            ])
        }

        NSLayoutConstraint.activate([
            // 头部视图布局
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),

            // 信息项 1 布局
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),

            // 信息项 2 布局
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),

            // 日期标签布局
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    /// 添加子视图控制器
    /// - Parameters:
    ///   - childVC: 子视图控制器
    ///   - containerView: 容器视图
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

    /// 点击完成按钮时调用
    @objc func didTapDoneButton() {
        coordinator?.dismiss()
    }
}

// MARK: - GFReportItemVCDelegate
extension UserInfoVC: GFReportItemVCDelegate {
    /// 点击 GitHub 个人资料按钮时调用
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlert(
                title: "userInfo.invalidURL".localized,
                message: "userInfo.invalidURLMessage".localized,
                buttonTitle: "alert.ok".localized
            )
            return
        }

        // 打开 Safari 浏览器
        presentSafariVC(with: url)
    }
}

// MARK: - GFFollowerItemVCDelegate
extension UserInfoVC: GFFollowerItemVCDelegate {
    /// 点击获取关注者按钮时调用
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlert(
                title: "userInfo.noFollowers".localized,
                message: "userInfo.noFollowersMessage".localized,
                buttonTitle: "userInfo.soSad".localized
            )
            return
        }

        // 通知代理请求关注者列表
        delegate?.didRequestFollowers(for: user.login)
        // 关闭当前页面
        coordinator?.dismiss()
    }
}
