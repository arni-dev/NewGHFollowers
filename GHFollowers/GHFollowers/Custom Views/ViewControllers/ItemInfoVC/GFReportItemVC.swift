//
//  GFReportItemVC.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 1/2/2024.
//

import Foundation

/// GFReportItemVCDelegate 协议：报告信息项视图控制器代理
/// 用于处理点击"GitHub Profile"按钮的事件
protocol GFReportItemVCDelegate: AnyObject {
    /// 点击 GitHub 个人资料按钮时调用
    /// - Parameter user: 当前用户
    func didTapGitHubProfile(for user: User)
}

/// GFReportItemVC 类：报告信息项视图控制器
/// 继承自 GFItemInfoVC，用于显示公开仓库和 Gist 的数量
class GFReportItemVC: GFItemInfoVC {
    /// 代理对象，用于回调点击事件
    weak var delegate: GFReportItemVCDelegate?

    /// 初始化方法
    /// - Parameters:
    ///   - user: 用户数据对象
    ///   - delegate: 代理对象
    init(user: User, delegate: GFReportItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }

    /// 从 Storyboard/XIB 初始化时调用
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 视图加载完成后调用
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }

    /// 配置信息项内容
    private func configureItems() {
        // 设置第一个信息项为公开仓库数量
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        // 设置第二个信息项为公开 Gist 数量
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        // 配置按钮样式和标题
        actionButton.set(color: .systemPurple, title: "itemInfo.githubProfile".localized, systemImageName: "person")
    }

    /// 重写按钮点击事件处理方法
    override func actionButonnTapped() {
        // 通知代理处理点击事件
        delegate?.didTapGitHubProfile(for: user)
    }
}
