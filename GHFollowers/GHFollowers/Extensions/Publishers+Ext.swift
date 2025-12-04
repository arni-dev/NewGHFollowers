//
//  Publishers+Ext.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 14/2/2024.
//

import UIKit
import Combine

/// UITextField 扩展：为 UITextField 添加 Combine 框架的响应式编程支持
extension UITextField {

    /// 文本发布者：将文本框的文本变化转换为 Combine 发布者
    /// 使用 Combine 框架实现响应式编程，可以方便地监听文本变化
    /// - Returns: 发布文本变化的 Publisher，永不失败（Never）
    var textPublisher: AnyPublisher<String, Never> {
        // 监听文本框的文本变化通知
        NotificationCenter.default.publisher(
            for: UITextField.textDidChangeNotification,  // 文本变化通知
            object: self  // 只监听当前文本框的通知
        )
        // 从通知中提取文本框对象，并获取其文本内容
        // compactMap 会自动过滤掉 nil 值
        .compactMap { ($0.object as? UITextField)?.text }
        // 将 Publisher 类型擦除为 AnyPublisher，隐藏具体实现细节
        .eraseToAnyPublisher()
    }

}
