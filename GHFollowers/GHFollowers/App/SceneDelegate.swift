//
//  SceneDelegate.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 20/1/2024.
//

import UIKit

// SceneDelegate 类：场景委托，负责管理应用的 UI 窗口和场景生命周期（iOS 13+）
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // 应用的主窗口，用于显示所有视图
    var window: UIWindow?
    
    // 应用协调器，负责管理整个应用的导航流程
    var appCoordinator: AppCoordinator?

    /// 场景即将连接到会话时调用
    /// 这是设置窗口和初始视图控制器的最佳位置
    /// - Parameters:
    ///   - scene: 正在连接的场景对象
    ///   - session: 场景会话对象
    ///   - connectionOptions: 连接选项，包含启动场景的原因信息
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {

        // 确保场景是 UIWindowScene 类型，否则直接返回
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // 创建一个新的 UIWindow，大小与场景的坐标空间边界一致
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        // 将窗口与当前的 windowScene 关联
        window?.windowScene = windowScene

        // 创建应用协调器，传入窗口对象
        appCoordinator = AppCoordinator(window: window)
        // 启动协调器，开始应用的导航流程
        appCoordinator?.start()

        // 使窗口成为主窗口并显示
        window?.makeKeyAndVisible()
    }

    /// 场景断开连接时调用
    /// - Parameter scene: 被断开的场景对象
    func sceneDidDisconnect(_ scene: UIScene) {
        // 当场景被系统释放时调用
        // 这通常发生在场景进入后台后不久，或者当会话被丢弃时
        // 释放与此场景相关的资源，这些资源可以在下次场景连接时重新创建
    }

    /// 场景变为活跃状态时调用
    /// - Parameter scene: 变为活跃的场景对象
    func sceneDidBecomeActive(_ scene: UIScene) {
        // 当场景从非活跃状态转换为活跃状态时调用
        // 使用此方法重新启动在场景非活跃时暂停（或尚未开始）的任务
        // 例如：恢复动画、重新开始计时器等
    }

    /// 场景即将变为非活跃状态时调用
    /// - Parameter scene: 即将变为非活跃的场景对象
    func sceneWillResignActive(_ scene: UIScene) {
        // 当场景将从活跃状态转换为非活跃状态时调用
        // 这可能由于临时中断（例如来电）而发生
        // 使用此方法暂停正在进行的任务、禁用计时器等
    }

    /// 场景即将从后台进入前台时调用
    /// - Parameter scene: 即将进入前台的场景对象
    func sceneWillEnterForeground(_ scene: UIScene) {
        // 当场景从后台转换到前台时调用
        // 使用此方法撤销进入后台时所做的更改
        // 例如：刷新 UI、重新加载数据等
    }

    /// 场景即将从前台进入后台时调用
    /// - Parameter scene: 即将进入后台的场景对象
    func sceneDidEnterBackground(_ scene: UIScene) {
        // 当场景从前台转换到后台时调用
        // 使用此方法保存数据、释放共享资源，并存储足够的场景特定状态信息
        // 以便将场景恢复到当前状态
    }

}
