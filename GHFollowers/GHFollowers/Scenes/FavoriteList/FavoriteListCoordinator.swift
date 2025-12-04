//
//  FavoriteListCoordinator.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 14/2/2024.
//

import UIKit

/// FavoriteListCoordinator 类：收藏列表协调器
/// 负责管理收藏列表场景的导航流程
class FavoriteListCoordinator: Coordinator {
    /// 父协调器的弱引用
    weak var parentCoordinator: Coordinator?

    /// 子协调器数组
    var children: [Coordinator] = []

    /// 根视图控制器（导航控制器）
    var rootViewController = UINavigationController()

    /// 收藏列表视图控制器：使用懒加载
    lazy var viewController: FavoritesListVC = {
        // 创建视图模型
        let viewModel = FavoriteListViewModel()
        // 创建视图控制器
        let favoriteListVC = FavoritesListVC(viewModel: viewModel)
        // 设置标题
        favoriteListVC.title = "Favorite"
        // 设置 TabBar 图标
        favoriteListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        // 设置协调器引用
        favoriteListVC.coordinator = self
        return favoriteListVC
    }()

    /// 启动协调器
    func start() {
        viewController.coordinator = self
        // 设置导航控制器的根视图控制器
        rootViewController.setViewControllers([viewController], animated: false)
    }

    /// 导航到关注者列表页面
    /// - Parameter username: 用户名
    func routeToFollowerListVC(username: String) {
        // 创建关注者列表协调器
        let followerListCoordinator = FollowerListCoordinator(username: username,
                                                              navigationController: rootViewController)
        // 设置父协调器
        followerListCoordinator.parentCoordinator = self
        // 添加到子协调器数组
        children = [followerListCoordinator]
        // 启动子协调器
        followerListCoordinator.start()
    }
}
