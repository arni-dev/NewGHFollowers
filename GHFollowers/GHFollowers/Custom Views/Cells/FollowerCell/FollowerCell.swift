//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 24/1/2024.
//

import UIKit
import SwiftUI

/// FollowerCell 类：关注者单元格
/// 用于在集合视图中显示单个关注者的信息
/// 使用 SwiftUI 的 UIHostingConfiguration 来嵌入 SwiftUI 视图
class FollowerCell: UICollectionViewCell {
    /// 单元格重用标识符
    static let reuseID = "FollowerCell"

    /// 便捷初始化方法
    /// - Parameter image: 图片（未使用，保留用于兼容性）
    convenience init(image: UIImage) {
        self.init(frame: .zero)
    }
    
    /// 标准初始化方法
    /// - Parameter frame: 单元格框架
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    /// 从 Storyboard/XIB 初始化时调用
    /// 由于本项目使用代码布局，此方法不会被调用
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 设置单元格内容
    /// - Parameter follower: 关注者数据模型
    func set(follower: Follower) {
        // 使用 UIHostingConfiguration 嵌入 SwiftUI 视图
        // 这是 iOS 16+ 的新特性，允许在 UIKit 中使用 SwiftUI 视图
        contentConfiguration = UIHostingConfiguration { FollowerView(avatarUrl: follower.avatarUrl,
                                                                     username: follower.login)
        }
    }
}
