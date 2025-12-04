//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 23/1/2024.
//

import UIKit
import SafariServices

/// UIViewController 扩展：为视图控制器添加便捷的弹窗和浏览器展示方法
extension UIViewController {
    /// 展示自定义的 GHFollowers 警告弹窗
    /// - Parameters:
    ///   - title: 弹窗标题
    ///   - message: 弹窗消息内容
    ///   - buttonTitle: 按钮文字
    func presentGFAlert(title: String, message: String, buttonTitle: String) {
        // 创建自定义警告视图控制器
        let alertVC = GFAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
        
        // 设置为全屏覆盖模式
        alertVC.modalPresentationStyle = .overFullScreen
        
        // 设置淡入淡出的过渡动画
        alertVC.modalTransitionStyle = .crossDissolve
        
        // 展示警告弹窗
        self.present(alertVC, animated: true)
    }

    /// 展示默认的错误提示弹窗
    /// 当发生未知错误时使用此方法
    func presentDefaultError() {
        // 创建带有默认错误信息的警告视图控制器
        let alertVC = GFAlertVC(
            alertTitle: "alert.defaultTitle".localized,  // 标题：出错了
            message: "alert.retry".localized,  // 消息：无法完成任务，请重试
            buttonTitle: "alert.ok".localized  // 按钮文字：确定
        )
        
        // 设置为全屏覆盖模式
        alertVC.modalPresentationStyle = .overFullScreen
        
        // 设置淡入淡出的过渡动画
        alertVC.modalTransitionStyle = .crossDissolve
        
        // 展示警告弹窗
        self.present(alertVC, animated: true)
    }

    /// 展示 Safari 浏览器视图控制器
    /// 用于在应用内打开网页，无需跳转到外部浏览器
    /// - Parameter url: 要打开的网页 URL
    func presentSafariVC(with url: URL) {
        // 创建 Safari 视图控制器
        let safariVC = SFSafariViewController(url: url)
        
        // 设置控制按钮的颜色为系统绿色
        safariVC.preferredControlTintColor = .systemGreen
        
        // 展示 Safari 视图控制器
        present(safariVC, animated: true)
    }
}
