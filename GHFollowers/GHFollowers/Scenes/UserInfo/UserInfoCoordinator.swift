//
//  UserInfoCoordinator.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 16/2/2024.
//

import UIKit

/// UserInfoCoordinator 类：用户信息协调器
/// 负责管理用户信息场景的导航流程（模态展示）
class UserInfoCoordinator: Coordinator {
    /// 父协调器的弱引用
    weak var parentCoordinator: Coordinator?
    /// 子协调器数组
    var children: [Coordinator] = []

    /// 根视图控制器（用于展示模态视图的父视图控制器）
    var rootViewController: UIViewController

    /// 用户信息视图控制器：使用懒加载
    lazy var viewController: UserInfoVC = {
        // 创建视图模型
        let viewModel = UserInfoViewModel()
        // 创建视图控制器
        let userInfoVC = UserInfoVC(viewModel: viewModel)
        return userInfoVC
    }()

    /// 初始化方法
    /// - Parameter rootViewController: 根视图控制器
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }

    /// 启动协调器
    func start() {
        // 设置视图控制器的协调器引用
        viewController.coordinator = self

        // 创建导航控制器作为容器（为了显示导航栏和完成按钮）
        let navController = UINavigationController()
        navController.setViewControllers([viewController], animated: false)
        
        // 模态展示导航控制器
        rootViewController.present(navController, animated: true)
    }

    /// 关闭用户信息页面
    func dismiss() {
        // 关闭模态视图
        viewController.dismiss(animated: true) { [weak self] in
            // 从父协调器的子协调器数组中移除自己
            self?.parentCoordinator?.children.removeAll { $0 is UserInfoCoordinator }
        }
    }
}
