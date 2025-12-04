//
//  FavoriteCell.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 12/2/2024.
//

import UIKit

/// FavoriteCell 类：收藏单元格
/// 用于在表格视图中显示收藏的用户信息
class FavoriteCell: UITableViewCell {
    /// 单元格重用标识符
    static let reuseID = "FavoriteCell"

    /// 头像图片视图
    let avatarImageView = GFAvatarImageView(frame: .zero)
    
    /// 用户名标签
    let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 26)

    /// 初始化方法
    /// - Parameters:
    ///   - style: 单元格样式
    ///   - reuseIdentifier: 重用标识符
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    /// 从 Storyboard/XIB 初始化时调用
    /// 由于本项目使用代码布局，此方法不会被调用
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 设置单元格内容
    /// - Parameter favorite: 收藏的关注者数据
    func set(favorite: Follower) {
        // 设置用户名
        usernameLabel.text = favorite.login
        // 下载并显示头像
        avatarImageView.downloadAvatarImage(fromURL: favorite.avatarUrl)
    }

    /// 配置单元格的布局和样式
    private func configure() {
        // 添加子视图
        addSubviews(avatarImageView, usernameLabel)

        // 设置右侧箭头指示器
        accessoryType = .disclosureIndicator
        
        // 设置内边距
        let padding: CGFloat = 12

        // 设置布局约束
        NSLayoutConstraint.activate([
            // 头像图片视图：垂直居中，左边距 12 点，60x60 大小
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),

            // 用户名标签：垂直居中，距离头像 24 点，右边距 12 点，高度 40 点
            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
