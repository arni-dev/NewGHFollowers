//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 1/2/2024.
//

import Foundation

/// GFFollowerItemVCDelegate 协议：关注者信息项视图控制器代理
/// 用于处理点击"Get Followers"按钮的事件
protocol GFFollowerItemVCDelegate: AnyObject {
    /// 点击获取关注者按钮时调用
    /// - Parameter user: 当前用户
    func didTapGetFollowers(for user: User)
}

/// GFFollowerItemVC 类：关注者信息项视图控制器
/// 继承自 GFItemInfoVC，用于显示关注者和正在关注的数量
class GFFollowerItemVC: GFItemInfoVC {
    /// 代理对象，用于回调点击事件
    weak var delegate: GFFollowerItemVCDelegate?

    /// 初始化方法
    /// - Parameters:
    ///   - user: 用户数据对象
    ///   - delegate: 代理对象
    init(user: User, delegate: GFFollowerItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }

    /// 从 Storyboard/XIB 初始化时调用
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 视图加载完成后调用
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }

    /// 配置信息项内容
    private func configureItems() {
        // 设置第一个信息项为关注者数量
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        // 设置第二个信息项为正在关注数量
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        // 配置按钮样式和标题
        actionButton.set(color: .systemGreen, title: "itemInfo.getFollowers".localized, systemImageName: "person.3")
    }

    /// 重写按钮点击事件处理方法
    override func actionButonnTapped() {
        // 通知代理处理点击事件
        delegate?.didTapGetFollowers(for: user)
    }
}
