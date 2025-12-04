//
//  GFAlertVC.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 22/1/2024.
//

import UIKit

/// GFAlertVC 类：自定义警告弹窗视图控制器
/// 用于显示自定义样式的警告提示信息
class GFAlertVC: UIViewController {
    /// 容器视图：包含所有弹窗内容的容器
    let containerView = GFAlertContainerView()
    
    /// 标题标签：显示警告标题
    let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    
    /// 消息标签：显示详细消息内容
    let messageLabel = GFBodyLabel(textAlignment: .center)
    
    /// 操作按钮：用户点击后关闭弹窗
    let actionButton = GFButton(color: .systemPink, title: "Ok", systemImageName: "checkmark.circle")

    /// 警告标题文本
    var alertTitle: String?
    
    /// 消息文本
    var message: String?
    
    /// 按钮标题文本
    var buttonTitle: String?

    /// 内边距常量
    let padding: CGFloat = 20

    /// 初始化方法
    /// - Parameters:
    ///   - alertTitle: 警告标题（可选）
    ///   - message: 消息内容（可选）
    ///   - buttonTitle: 按钮标题（可选）
    init(alertTitle: String? = nil, message: String? = nil, buttonTitle: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.message = message
        self.buttonTitle = buttonTitle
    }

    /// 从 Storyboard/XIB 初始化时调用
    /// 由于本项目使用代码布局，此方法不会被调用
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 视图加载完成后调用
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置半透明黑色背景
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        // 添加所有子视图
        view.addSubviews(containerView, titleLabel, actionButton, messageLabel)

        // 配置各个视图的布局
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
    }

    /// 配置容器视图的布局约束
    func configureContainerView() {
        NSLayoutConstraint.activate([
            // 垂直居中
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            // 水平居中
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            // 宽度 280 点
            containerView.widthAnchor.constraint(equalToConstant: 280),
            // 高度 220 点
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }

    /// 配置标题标签的布局约束
    func configureTitleLabel() {
        // 设置标题文本，如果没有提供则使用默认值
        titleLabel.text = alertTitle ?? "alert.defaultTitle".localized

        NSLayoutConstraint.activate([
            // 距离容器顶部 20 点
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            // 左边距 20 点
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            // 右边距 20 点
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            // 高度 28 点
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }

    /// 配置操作按钮的布局约束
    func configureActionButton() {
        // 设置按钮标题，如果没有提供则使用默认值
        actionButton.setTitle(buttonTitle ?? "alert.ok".localized, for: .normal)
        // 添加点击事件监听
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)

        NSLayoutConstraint.activate([
            // 距离容器底部 20 点
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            // 左边距 20 点
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            // 右边距 20 点
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            // 高度 44 点
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    /// 配置消息标签的布局约束
    func configureMessageLabel() {
        // 设置消息文本，如果没有提供则使用默认值
        messageLabel.text = message ?? "alert.defaultMessage".localized
        // 最多显示 4 行
        messageLabel.numberOfLines = 4

        NSLayoutConstraint.activate([
            // 距离标题底部 8 点
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            // 左边距 20 点
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            // 右边距 20 点
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            // 距离按钮顶部 12 点
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        ])
    }

    /// 关闭弹窗
    @objc func dismissVC() {
        dismiss(animated: true)
    }

}
