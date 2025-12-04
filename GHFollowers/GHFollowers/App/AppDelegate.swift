//
//  AppDelegate.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 20/1/2024.
//

import UIKit

// @main 标记：指定这是应用程序的入口点
@main
// AppDelegate 类：应用程序委托，负责处理应用程序级别的事件和生命周期
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    /// 应用程序启动完成时调用
    /// - Parameters:
    ///   - application: 当前应用程序实例
    ///   - launchOptions: 启动选项字典，包含启动应用的原因信息（例如：推送通知、URL scheme等）
    /// - Returns: 返回 true 表示应用启动成功
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // 应用启动后的自定义配置点
        // 可以在这里进行全局配置，如设置外观、注册通知等
        return true
    }

    // MARK: - UISceneSession 生命周期管理
    // 以下方法用于管理多窗口场景（iOS 13+）

    /// 当新的场景会话即将创建时调用
    /// - Parameters:
    ///   - application: 当前应用程序实例
    ///   - connectingSceneSession: 正在连接的场景会话
    ///   - options: 场景连接选项
    /// - Returns: 返回用于创建新场景的配置对象
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        // 当创建新的场景会话时调用
        // 使用此方法选择要创建新场景的配置
        return UISceneConfiguration(
            name: "Default Configuration",  // 配置名称
            sessionRole: connectingSceneSession.role  // 场景角色（窗口或外部显示）
        )
    }

    /// 当用户丢弃场景会话时调用
    /// - Parameters:
    ///   - application: 当前应用程序实例
    ///   - sceneSessions: 被丢弃的场景会话集合
    func application(
        _ application: UIApplication,
        didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) {
        // 当用户丢弃场景会话时调用
        // 如果应用未运行时有会话被丢弃，此方法会在 application:didFinishLaunchingWithOptions: 之后立即调用
        // 使用此方法释放与被丢弃场景相关的资源，因为这些场景不会再返回
    }

}
