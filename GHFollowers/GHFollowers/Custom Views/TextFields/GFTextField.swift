//
//  GFTextField.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 20/1/2024.
//

import UIKit

/// GFTextField 类：自定义文本输入框，继承自 UITextField
/// 提供统一的文本框样式和配置
class GFTextField: UITextField {
    /// 标准初始化方法
    /// - Parameter frame: 文本框的框架
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    /// 从 Storyboard/XIB 初始化时调用
    /// 由于本项目使用代码布局，此方法不会被调用
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 配置文本框的样式和行为
    private func configure() {
        // 禁用自动调整大小掩码转换为约束
        translatesAutoresizingMaskIntoConstraints = false

        // 设置圆角半径
        layer.cornerRadius = 10.0
        
        // 设置边框宽度
        layer.borderWidth = 2
        
        // 设置边框颜色为系统灰色
        layer.borderColor = UIColor.systemGray4.cgColor

        // 设置文字颜色为系统标签颜色（自动适配深色/浅色模式）
        textColor = .label
        
        // 设置光标颜色
        tintColor = .label
        
        // 设置文字居中对齐
        textAlignment = .center
        
        // 设置字体为系统首选字体，样式为 title2
        font = UIFont.preferredFont(forTextStyle: .title2)
        
        // 允许字体自动调整大小以适应文本框宽度
        adjustsFontSizeToFitWidth = true
        
        // 设置最小字体大小
        minimumFontSize = 12

        // 设置背景颜色为第三级系统背景色
        backgroundColor = .tertiarySystemBackground
        
        // 禁用自动更正
        autocorrectionType = .no
        
        // 设置键盘返回键类型为"Go"
        returnKeyType = .go
        
        // 设置清除按钮模式：编辑时显示
        clearButtonMode = .whileEditing
        
        // 设置占位符文字
        placeholder = "输入用户名"
    }
    
    // MARK: - Workaround for iOS Text Magnifier NaN Bug
    
    /// 选择性禁用文本操作
    /// 允许粘贴,但禁用选择操作以避免触发放大镜的 NaN bug
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        // 允许粘贴操作
        if action == #selector(paste(_:)) {
            return super.canPerformAction(action, withSender: sender)
        }
        
        // 禁用以下操作以避免触发文本放大镜:
        // - select: 选择
        // - selectAll: 全选
        // - copy: 复制(需要先选择,会触发放大镜)
        // - cut: 剪切(需要先选择,会触发放大镜)
        let disabledActions: [Selector] = [
            #selector(select(_:)),
            #selector(selectAll(_:)),
            #selector(copy(_:)),
            #selector(cut(_:))
        ]
        
        if disabledActions.contains(action) {
            return false
        }
        
        // 其他操作使用默认行为
        return super.canPerformAction(action, withSender: sender)
    }
}
