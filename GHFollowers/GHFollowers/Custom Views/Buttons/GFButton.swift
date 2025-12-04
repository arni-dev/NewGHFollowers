//
//  GFButton.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 20/1/2024.
//

import UIKit

/// GFButton 类：自定义按钮，继承自 UIButton
/// 提供统一的按钮样式和配置
class GFButton: UIButton {
    /// 标准初始化方法
    /// - Parameter frame: 按钮的框架
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
    /// 创建一个带有颜色、标题和图标的按钮
    /// - Parameters:
    ///   - color: 按钮的主题颜色
    ///   - title: 按钮标题文字
    ///   - systemImageName: SF Symbol 系统图标名称
    convenience init(color: UIColor, title: String, systemImageName: String) {
        self.init(frame: .zero)
        set(color: color, title: title, systemImageName: systemImageName)
    }

    /// 配置按钮的基本样式
    private func configure() {
        // 使用 tinted 配置样式（iOS 15+ 的新 API）
        // 这会创建一个带有淡色背景和彩色前景的按钮
        configuration = .tinted()
        
        // 设置圆角样式为中等
        configuration?.cornerStyle = .medium

        // 禁用自动调整大小掩码转换为约束
        translatesAutoresizingMaskIntoConstraints = false
    }

    /// 设置按钮的颜色、标题和图标
    /// - Parameters:
    ///   - color: 按钮的主题颜色
    ///   - title: 按钮标题文字
    ///   - systemImageName: SF Symbol 系统图标名称
    func set(color: UIColor, title: String, systemImageName: String) {
        // 设置背景颜色
        configuration?.baseBackgroundColor = color
        
        // 设置前景颜色（文字和图标颜色）
        configuration?.baseForegroundColor = color
        
        // 设置按钮标题
        configuration?.title = title
        
        // 设置按钮图标（使用 SF Symbol）
        configuration?.image = UIImage(systemName: systemImageName)
        
        // 设置图标与文字之间的间距
        configuration?.imagePadding = 6
        
        // 设置图标位置在文字左侧
        configuration?.imagePlacement = .leading
    }
}

// MARK: - 预览
// SwiftUI 预览，用于在 Xcode 中快速查看按钮效果
#Preview {
     GFButton(color: .blue, title: "Test Button", systemImageName: "pencil")
}
