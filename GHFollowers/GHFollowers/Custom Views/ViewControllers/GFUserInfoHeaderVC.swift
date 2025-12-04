//
//  GFUserInfoHeaderVC.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 30/1/2024.
//

import UIKit

/// GFUserInfoHeaderVC 类：用户信息头部视图控制器
/// 显示用户的基本信息，如头像、用户名、姓名、位置和简介
class GFUserInfoHeaderVC: UIViewController {
    /// 头像图片视图
    let avatarImageView = GFAvatarImageView(frame: .zero)
    /// 用户名标签
    let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 34)
    /// 姓名标签
    let nameLabel = GFSecondaryTitleLabel(fontSize: 18)
    /// 位置图标
    let locationImageView = UIImageView()
    /// 位置标签
    let locationLabel = GFSecondaryTitleLabel(fontSize: 18)
    /// 简介标签
    let bioLabel = GFBodyLabel(textAlignment: .left)

    /// 用户数据模型
    var user: User!

    /// 初始化方法
    /// - Parameter user: 用户数据对象
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }

    /// 从 Storyboard/XIB 初始化时调用
    /// 由于本项目使用代码布局，此方法不会被调用
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 视图加载完成后调用
    override func viewDidLoad() {
        super.viewDidLoad()
        // 添加所有子视图
        view.addSubviews(avatarImageView, usernameLabel, nameLabel, locationImageView, locationLabel, bioLabel)
        // 布局 UI
        layoutUI()
        // 配置 UI 元素内容
        configureUIElements()
    }

    /// 配置 UI 元素的内容和样式
    func configureUIElements() {
        // 确保导航栏样式正确
        navigationController?.navigationBar.barStyle = .default
        // 下载并显示头像
        avatarImageView.downloadAvatarImage(fromURL: user.avatarUrl)
        // 设置用户名
        usernameLabel.text = user.login
        // 设置姓名，如果为空则显示空字符串
        nameLabel.text = user.name ?? ""
        // 设置位置，如果为空则显示默认文本
        locationLabel.text = user.location ?? "No Location"
        // 设置简介，如果为空则显示默认文本
        bioLabel.text = user.bio ?? "No Bio Available"
        // 简介最多显示 3 行
        bioLabel.numberOfLines = 3

        // 设置位置图标
        locationImageView.image = SFSymbols.location
        // 设置图标颜色
        locationImageView.tintColor = .secondaryLabel
    }

    /// 配置 UI 布局约束
    func layoutUI() {
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        locationImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // 头像布局
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),

            // 用户名布局
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),

            // 姓名布局
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),

            // 位置图标布局
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,
                                                       constant: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),

            // 位置标签布局
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),

            // 简介标签布局
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
}
