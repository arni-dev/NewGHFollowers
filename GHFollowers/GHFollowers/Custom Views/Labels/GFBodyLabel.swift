//
//  GFBodyLabel.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 22/1/2024.
//

import UIKit

/// GFBodyLabel 类：自定义正文标签，继承自 UILabel
/// 用于显示次要的正文内容
class GFBodyLabel: UILabel {
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
    /// 创建一个指定对齐方式的正文标签
    /// - Parameter textAlignment: 文字对齐方式
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        // 设置文字对齐方式
        self.textAlignment = textAlignment
    }

    /// 配置标签的基本样式
    private func configure() {
        // 设置文字颜色为次要标签颜色(比主标签颜色浅一些)
        textColor = .secondaryLabel
        
        // 设置字体为系统首选字体,正文样式
        font = UIFont.preferredFont(forTextStyle: .body)
        
        // 根据用户的字体大小设置自动调整字体
        // 支持辅助功能中的动态字体大小
        adjustsFontForContentSizeCategory = true
        
        // 设置最小缩放比例
        minimumScaleFactor = 0.9
        
        // 设置换行模式:按单词换行
        lineBreakMode = .byWordWrapping
        
        // 设置行数为0(允许多行显示)
        numberOfLines = 0
        
        // 禁用自动调整大小掩码转换为约束
        translatesAutoresizingMaskIntoConstraints = false
    }
}
