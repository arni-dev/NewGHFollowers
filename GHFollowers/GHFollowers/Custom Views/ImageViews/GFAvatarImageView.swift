//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 24/1/2024.
//

import UIKit

/// GFAvatarImageView 类：自定义头像图片视图，继承自 UIImageView
/// 用于显示用户头像，支持异步下载和缓存
class GFAvatarImageView: UIImageView {
    /// 图片缓存，使用网络管理器的共享缓存
    let cache = NetworkManager.shared.cache
    
    /// 占位图片，在头像未加载或加载失败时显示
    let placeholderImage = Images.placeholder

    /// 标准初始化方法
    /// - Parameter frame: 图片视图的框架
    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    /// 从 Storyboard/XIB 初始化时调用
    /// 由于本项目使用代码布局，此方法不会被调用
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 配置图片视图的基本样式
    private func configure() {
        // 设置圆角半径
        layer.cornerRadius = 10
        
        // 裁剪超出边界的内容（使圆角生效）
        clipsToBounds = true
        
        // 设置默认图片为占位图
        image = placeholderImage
        
        // 禁用自动调整大小掩码转换为约束
        translatesAutoresizingMaskIntoConstraints = false
    }

    /// 从指定 URL 下载头像图片
    /// 使用异步方式下载，不会阻塞主线程
    /// - Parameter url: 头像图片的 URL 字符串
    func downloadAvatarImage(fromURL url: String) {
        // 创建异步任务
        Task {
            // 调用网络管理器下载图片，如果下载失败则使用占位图
            image = await NetworkManager.shared.downloadImage(from: url) ?? placeholderImage
        }
    }
}
