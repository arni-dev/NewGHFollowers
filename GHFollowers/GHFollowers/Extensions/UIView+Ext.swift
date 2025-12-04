//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 13/2/2024.
//

import UIKit

/// UIView 扩展：为 UIView 添加便捷的布局和视图管理方法
extension UIView {

    /// 将当前视图固定到父视图的所有边缘
    /// 使用 Auto Layout 约束将视图的上、下、左、右四条边与父视图对齐
    /// - Parameter superview: 父视图
    func pinToEdges(of superview: UIView) {
        // 禁用自动调整大小掩码转换为约束
        // 这是使用 Auto Layout 的必要步骤
        translatesAutoresizingMaskIntoConstraints = false
        
        // 激活所有边缘的约束
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),        // 顶部对齐
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),  // 左侧对齐
            trailingAnchor.constraint(equalTo: superview.trailingAnchor), // 右侧对齐
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)])    // 底部对齐
    }

    /// 批量添加子视图
    /// 使用可变参数，可以一次性添加多个子视图
    /// - Parameter views: 要添加的子视图列表
    func addSubviews(_ views: UIView...) {
        // 遍历所有传入的视图
        for view in views {
            // 将每个视图添加为子视图
            addSubview(view)
        }
    }
}
