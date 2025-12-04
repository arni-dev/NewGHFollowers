//
//  AppCoordinator.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 14/2/2024.
//

import UIKit

/// AppCoordinator 类：应用程序的根协调器
/// 这是整个应用导航层级的最顶层，负责启动主要的导航流程
class AppCoordinator: Coordinator {
    
    // 应用的主窗口引用
    let window: UIWindow?

    // 父协调器（AppCoordinator 是根协调器，所以没有父协调器）
    var parentCoordinator: Coordinator?
    
    // 子协调器数组，存储当前管理的所有子协调器
    var children: [Coordinator] = []

    /// 初始化方法
    /// - Parameter window: 应用的主窗口
    init(window: UIWindow?) {
        self.window = window
    }

    /// 启动应用协调器
    /// 创建并启动主协调器，设置应用的根视图控制器
    func start() {
        // 创建主协调器实例
        let mainCoordinator = MainCoordinator()
        // 启动主协调器，开始主要的导航流程
        mainCoordinator.start()
        // 将主协调器添加到子协调器数组中进行管理
        children = [mainCoordinator]
        // 将主协调器的根视图控制器设置为窗口的根视图控制器
        window?.rootViewController = mainCoordinator.rootViewController
    }
}
