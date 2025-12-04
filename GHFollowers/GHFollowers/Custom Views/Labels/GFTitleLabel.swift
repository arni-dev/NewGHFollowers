//
//  GFTitleLabel.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 22/1/2024.
//

import UIKit

/// GFTitleLabel 类：自定义标题标签，继承自 UILabel
/// 用于显示粗体的标题文字
class GFTitleLabel: UILabel {
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
    /// 创建一个指定对齐方式和字体大小的标题标签
    /// - Parameters:
    ///   - textAlignment: 文字对齐方式（左对齐、居中、右对齐等）
    ///   - fontSize: 字体大小
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        // 设置文字对齐方式
        self.textAlignment = textAlignment
        // 设置字体为系统字体，粗体样式
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configure()
    }

    /// 配置标签的基本样式
    private func configure() {
        // 设置文字颜色为系统标签颜色(自动适配深色/浅色模式)
        textColor = .label
        
        // 允许字体自动调整大小以适应标签宽度
        adjustsFontSizeToFitWidth = true
        
        // 设置最小缩放比例为 0.9(最小可缩小到原字体大小的 90%)
        minimumScaleFactor = 0.9
        
        // 设置文字截断模式:从尾部截断(显示省略号)
        lineBreakMode = .byTruncatingTail
        
        // 设置行数为1(标题通常只显示一行)
        numberOfLines = 1
        
        // 禁用自动调整大小掩码转换为约束
        translatesAutoresizingMaskIntoConstraints = false
    }
}
