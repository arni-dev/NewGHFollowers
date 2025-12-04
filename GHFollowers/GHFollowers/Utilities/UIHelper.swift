//
//  UIHelper.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 25/1/2024.
//

import UIKit

/// UIHelper 枚举：UI 辅助工具，提供常用的 UI 布局方法
enum UIHelper {
    /// 创建三列流式布局
    /// 用于在集合视图中显示三列网格布局（例如显示关注者列表）
    /// - Parameter view: 包含集合视图的父视图，用于获取宽度
    /// - Returns: 配置好的 UICollectionViewFlowLayout 对象
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        // 获取视图的总宽度
        let width = view.bounds.width
        
        // 设置边距（左右两侧的空白区域）
        let padding: CGFloat = 12
        
        // 设置列之间的最小间距
        let minimumItemSpacing: CGFloat = 10
        
        // 计算可用宽度：总宽度 - 左右边距 - 列间距
        // 左右边距各占 padding，两个列间距各占 minimumItemSpacing
        let availableWidth = width - (padding * 2) - minimumItemSpacing * 2
        
        // 计算每个单元格的宽度：可用宽度除以 3（三列布局）
        let itemWidth = availableWidth / 3

        // 创建流式布局对象
        let flowLayout = UICollectionViewFlowLayout()
        
        // 设置内边距（上、左、下、右）
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        
        // 设置每个单元格的大小
        // 宽度为计算出的 itemWidth，高度为宽度加 40（为文字预留空间）
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)

        return flowLayout
    }
}
