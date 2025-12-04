//
//  FollowerListCoordinator.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 14/2/2024.
//

import UIKit

/// FollowerListCoordinator 类：关注者列表协调器
/// 负责管理关注者列表场景的导航流程
class FollowerListCoordinator: Coordinator {
    /// 父协调器的弱引用
    weak var parentCoordinator: Coordinator?

    /// 子协调器数组
    var children: [Coordinator] = []

    /// 导航控制器
    var navigationController: UINavigationController

    /// 当前查看的用户名
    private let username: String

    /// 初始化方法
    /// - Parameters:
    ///   - username: 用户名
    ///   - navigationController: 导航控制器
    init(username: String, navigationController: UINavigationController) {
        self.username = username
        self.navigationController = navigationController
    }

    /// 关注者列表视图控制器：使用懒加载
    lazy var viewController: FollowerListVC = {
        // 创建视图模型
        let viewModel = FollowerListViewModel(username: username)
        // 创建视图控制器
        let followerListVC = FollowerListVC(viewModel: viewModel)
        // 设置标题
        followerListVC.title = username
        return followerListVC
    }()

    /// 启动协调器
    func start() {
        // 设置视图控制器的协调器引用
        viewController.coordinator = self
        // 推送视图控制器到导航栈
        navigationController.pushViewController(viewController, animated: true)
    }

    /// 导航到用户信息页面
    /// - Parameter username: 用户名
    func routeToUserInfoVC(username: String) {
        // 创建用户信息协调器，以模态方式展示
        let userInfoCoordinator = UserInfoCoordinator(rootViewController: viewController)
        // 设置父协调器
        userInfoCoordinator.parentCoordinator = self
        // 添加到子协调器数组
        children = [userInfoCoordinator]

        // 设置目标用户名
        userInfoCoordinator.viewController.username = username
        // 设置代理，以便处理后续操作（如查看关注者）
        userInfoCoordinator.viewController.delegate = viewController

        // 启动用户信息协调器
        userInfoCoordinator.start()
    }
}
