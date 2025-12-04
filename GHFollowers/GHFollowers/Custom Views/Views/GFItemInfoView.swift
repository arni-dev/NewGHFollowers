//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 31/1/2024.
//

import UIKit

/// ItemInfoType 枚举：信息项类型
/// 定义了四种不同的信息类型
enum ItemInfoType {
    case repos      // 公开仓库
    case gists      // 公开 Gist
    case following  // 正在关注
    case followers  // 关注者
}

/// GFItemInfoView 类：信息项视图
/// 用于显示单个统计信息，包含图标、标题和数量
class GFItemInfoView: UIView {
    /// 图标图片视图
    let symbolImageView = UIImageView()
    /// 标题标签
    let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    /// 数量标签
    let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)

    /// 标准初始化方法
    /// - Parameter frame: 视图框架
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    /// 从 Storyboard/XIB 初始化时调用
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 配置视图布局和样式
    func configure() {
        addSubviews(symbolImageView, titleLabel, countLabel)

        // 配置图标视图
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label

        NSLayoutConstraint.activate([
            // 图标布局
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),

            // 标题布局
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),

            // 数量布局
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }

    /// 设置信息项内容
    /// - Parameters:
    ///   - itemInfoType: 信息类型
    ///   - count: 数量
    func set(itemInfoType: ItemInfoType, withCount count: Int) {
        // 根据类型设置图标和标题
        switch itemInfoType {
        case .repos:
            symbolImageView.image = SFSymbols.repos
            titleLabel.text = "itemInfo.publicRepos".localized
        case .gists:
            symbolImageView.image = SFSymbols.gists
            titleLabel.text = "itemInfo.publicGists".localized
        case .following:
            symbolImageView.image = SFSymbols.following
            titleLabel.text = "itemInfo.following".localized
        case .followers:
            symbolImageView.image = SFSymbols.followers
            titleLabel.text = "itemInfo.followers".localized
        }

        // 设置数量文本
        countLabel.text = String(count)
    }
}
