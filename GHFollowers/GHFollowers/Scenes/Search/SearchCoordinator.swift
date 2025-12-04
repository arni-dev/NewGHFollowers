//
//  SearchCoordinator.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 14/2/2024.
//

import UIKit

/// SearchCoordinator 类：搜索协调器
/// 负责管理搜索功能模块的导航流程
class SearchCoordinator: Coordinator {
    /// 父协调器的弱引用
    weak var parentCoordinator: Coordinator?

    /// 子协调器数组，存储关注者列表协调器
    var children: [Coordinator] = []

    /// 根视图控制器：导航控制器
    var rootViewController = UINavigationController()

    /// 搜索视图控制器：使用懒加载，在首次访问时才创建
    lazy var viewController: SearchVC = {
        // 创建视图模型
        let viewModel = SearchViewModel()
        // 创建搜索视图控制器
        let searchVC = SearchVC(viewModel: viewModel)
        // 设置标题
        searchVC.title = "Search"
        // 设置标签栏项：使用系统搜索图标
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return searchVC
    }()

    /// 启动搜索协调器
    /// 设置视图控制器的协调器引用，并将其设置为导航控制器的根视图控制器
    func start() {
        // 设置视图控制器的协调器引用，用于导航回调
        viewController.coordinator = self
        // 将搜索视图控制器设置为导航控制器的根视图控制器
        rootViewController.setViewControllers([viewController], animated: false)
    }
}

// MARK: - 导航方法
extension SearchCoordinator {
    /// 导航到关注者列表页面
    /// - Parameter username: GitHub 用户名
    func routeToFollowerListVC(username: String) {
        // 创建关注者列表协调器，传入用户名和导航控制器
        let followerListCoordinator = FollowerListCoordinator(username: username,
                                                              navigationController: rootViewController)
        // 设置父协调器引用
        followerListCoordinator.parentCoordinator = self
        // 将关注者列表协调器添加到子协调器数组
        children = [followerListCoordinator]
        // 启动关注者列表协调器
        followerListCoordinator.start()
    }
}
