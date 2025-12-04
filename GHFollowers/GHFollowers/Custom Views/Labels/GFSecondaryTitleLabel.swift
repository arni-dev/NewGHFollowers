//
//  GFSecondaryTitleLabel.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 30/1/2024.
//

import UIKit

/// GFSecondaryTitleLabel 类：自定义次要标题标签，继承自 UILabel
/// 用于显示中等粗细的次要标题文字
class GFSecondaryTitleLabel: UILabel {
    /// 标准初始化方法
    /// - Parameter frame: 标签的框架
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
    /// 创建一个指定字体大小的次要标题标签
    /// - Parameter fontSize: 字体大小
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        // 设置字体为系统字体，中等粗细
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }

    /// 配置标签的基本样式
    private func configure() {
        // 设置文字颜色为次要标签颜色
        textColor = .secondaryLabel
        
        // 允许字体自动调整大小以适应标签宽度
        adjustsFontSizeToFitWidth = true
        
        // 设置最小缩放比例
        minimumScaleFactor = 0.9
        
        // 设置文字截断模式：从尾部截断
        lineBreakMode = .byTruncatingTail
        
        // 禁用自动调整大小掩码转换为约束
        translatesAutoresizingMaskIntoConstraints = false
    }
}
