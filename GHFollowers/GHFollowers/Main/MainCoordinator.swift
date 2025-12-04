//
//  MainCoordinator.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 14/2/2024.
//

import UIKit

/// MainCoordinator 类：主协调器，负责管理应用的主要导航结构
/// 使用标签栏（Tab Bar）来组织搜索和收藏两个主要功能模块
class MainCoordinator: Coordinator {
    /// 父协调器的弱引用（避免循环引用）
    weak var parentCoordinator: Coordinator?

    /// 子协调器数组，存储搜索和收藏列表的协调器
    var children: [Coordinator] = []

    /// 根视图控制器：标签栏控制器
    var rootViewController: UITabBarController

    /// 初始化方法
    /// 创建标签栏控制器并配置导航栏和标签栏的外观
    init() {
        // 创建标签栏控制器
        self.rootViewController = UITabBarController()
        
        // 设置标签栏的选中颜色为系统绿色
        UITabBar.appearance().tintColor = .systemGreen
        
        // 配置导航栏外观
        configureNavigationBar()
        
        // 配置标签栏外观
        configureTabBar()
    }

    /// 启动主协调器
    /// 创建并启动搜索和收藏列表两个子协调器，并将它们的视图控制器添加到标签栏
    func start() {
        // 创建搜索协调器
        let searchCoordinator = SearchCoordinator()
        // 启动搜索协调器
        searchCoordinator.start()
        // 将搜索协调器添加到子协调器数组
        children.append(searchCoordinator)

        // 创建收藏列表协调器
        let favoriteListCoordinator = FavoriteListCoordinator()
        // 启动收藏列表协调器
        favoriteListCoordinator.start()
        // 将收藏列表协调器添加到子协调器数组
        children.append(favoriteListCoordinator)

        // 获取搜索协调器的根视图控制器（第一个标签）
        let firstViewController = searchCoordinator.rootViewController
        // 获取收藏列表协调器的根视图控制器（第二个标签）
        let secondViewController = favoriteListCoordinator.rootViewController

        // 将两个视图控制器设置为标签栏的子视图控制器
        rootViewController.viewControllers = [firstViewController, secondViewController]
    }

    /// 配置导航栏外观
    /// 设置导航栏的按钮颜色为系统绿色
    func configureNavigationBar() {
        UINavigationBar.appearance().tintColor = .systemGreen
    }

    /// 配置标签栏外观
    /// 设置标签栏的背景样式和模糊效果
    func configureTabBar() {
        // 创建标签栏外观对象
        let tabBarAppearance = UITabBarAppearance()
        
        // 使用默认背景配置
        tabBarAppearance.configureWithDefaultBackground()
        
        // 设置背景模糊效果为系统 Chrome 材质
        tabBarAppearance.backgroundEffect = UIBlurEffect(style: .systemChromeMaterial)
        
        // 将外观应用到标签栏的滚动边缘（当内容滚动到顶部时的外观）
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
}
