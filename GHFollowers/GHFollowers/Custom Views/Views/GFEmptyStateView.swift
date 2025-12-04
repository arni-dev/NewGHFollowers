//
//  GFEmptyStateView.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 30/1/2024.
//

import UIKit

/// GFEmptyStateView 类：空状态视图
/// 当没有数据时显示友好的提示信息和背景图
class GFEmptyStateView: UIView {
    /// 消息标签：显示提示文字
    let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    
    /// Logo 图片视图：显示背景装饰图
    let logoImageView = UIImageView()

    /// 标准初始化方法
    /// - Parameter frame: 视图框架
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    /// 从 Storyboard/XIB 初始化时调用
    /// 由于本项目使用代码布局，此方法不会被调用
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 便捷初始化方法
    /// - Parameter message: 要显示的提示消息
    convenience init(message: String) {
        self.init(frame: .zero)
        // 设置消息文本
        messageLabel.text = message
    }

    /// 配置视图
    private func configure() {
        // 添加子视图
        addSubviews(messageLabel, logoImageView)
        // 配置消息标签
        configureMessageLabel()
        // 配置 Logo 图片视图
        configureLogoImageView()
    }

    /// 配置消息标签的布局约束
    private func configureMessageLabel() {
        // 最多显示 3 行
        messageLabel.numberOfLines = 3
        // 设置文字颜色为次要标签颜色
        messageLabel.textColor = .secondaryLabel

        NSLayoutConstraint.activate([
            // 垂直居中，向上偏移 150 点
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            // 左边距 40 点
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            // 右边距 40 点
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            // 高度 200 点
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    /// 配置 Logo 图片视图的布局约束
    private func configureLogoImageView() {
        // 设置空状态 Logo 图片
        logoImageView.image = Images.emptyStateLogo
        // 禁用自动调整大小掩码转换为约束
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // 宽度为父视图宽度的 1.3 倍（部分超出屏幕）
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            // 高度与宽度相同（保持正方形）
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            // 右侧超出 170 点（创建部分遮挡效果）
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            // 底部超出 40 点
            logoImageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 40)
        ])
    }
}
