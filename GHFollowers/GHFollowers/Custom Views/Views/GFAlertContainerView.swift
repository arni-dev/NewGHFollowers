//
//  GFAlertContainerView.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 12/2/2024.
//

import UIKit

/// GFAlertContainerView 类：警告容器视图
/// 用于包含警告弹窗的内容，提供圆角和边框样式
class GFAlertContainerView: UIView {
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

    /// 配置视图的样式
    private func configure() {
        // 设置背景颜色为系统背景色
        backgroundColor = .systemBackground
        
        // 设置圆角半径
        layer.cornerRadius = 16
        
        // 设置边框宽度
        layer.borderWidth = 2
        
        // 设置边框颜色为白色
        layer.borderColor = UIColor.white.cgColor
        
        // 禁用自动调整大小掩码转换为约束
        translatesAutoresizingMaskIntoConstraints = false
    }
}
