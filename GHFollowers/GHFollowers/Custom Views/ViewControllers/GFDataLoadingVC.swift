//
//  GFDataLoadingVC.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 13/2/2024.
//

import UIKit

/// GFDataLoadingVC 类：数据加载视图控制器
/// 提供显示加载指示器和空状态视图的功能
/// 其他视图控制器可以继承此类来获得这些功能
class GFDataLoadingVC: UIViewController {
     /// 容器视图：用于显示加载指示器的容器
     var containerView: UIView!

    /// 显示加载视图
    /// 在屏幕上显示一个半透明的加载指示器
    func showLoadingView() {
        // 创建覆盖整个屏幕的容器视图
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)

        // 设置背景颜色为系统背景色
        containerView.backgroundColor = .systemBackground
        // 初始透明度为 0
        containerView.alpha = 0

        // 使用动画淡入显示
        UIView.animate(withDuration: 0.25) {
            self.containerView.alpha = 0.8
        }

        // 创建大号活动指示器
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)

        // 禁用自动调整大小掩码转换为约束
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        // 设置指示器居中
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])

        // 开始动画
        activityIndicator.startAnimating()
    }

    /// 关闭加载视图
    /// 从屏幕上移除加载指示器
    func dismissLoadingView() {
        // 确保在主线程执行 UI 操作
        DispatchQueue.main.async {
            // 从父视图移除
            self.containerView.removeFromSuperview()
            // 释放引用
            self.containerView = nil
        }
    }

    /// 显示空状态视图
    /// 当没有数据时显示友好的提示信息
    /// - Parameters:
    ///   - message: 要显示的提示消息
    ///   - view: 要添加空状态视图的父视图
    func showEmptyStateView(with message: String, in view: UIView) {
        // 创建空状态视图
        let emptyStateView = GFEmptyStateView(message: message)
        // 设置为与父视图相同大小
        emptyStateView.frame = view.bounds
        // 添加到父视图
        view.addSubview(emptyStateView)
    }

}
