//
//  GFItemInfoVC.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 1/2/2024.
//

import UIKit

/// GFItemInfoVC 类：信息项视图控制器基类
/// 用于显示用户统计信息（如仓库数、关注者数等）和操作按钮
/// 子类 GFFollowerItemVC 和 GFReportItemVC 继承此类并实现具体功能
class GFItemInfoVC: UIViewController {
    /// 堆栈视图：用于水平排列两个信息项视图
    let stackView = UIStackView()
    /// 信息项视图 1
    let itemInfoViewOne = GFItemInfoView()
    /// 信息项视图 2
    let itemInfoViewTwo = GFItemInfoView()
    /// 操作按钮
    let actionButton = GFButton()

    /// 用户数据模型
    var user: User!

    /// 初始化方法
    /// - Parameter user: 用户数据对象
    init(user: User!) {
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
        configureBackgroundView()
        configureStackView()
        layoutUI()
        configureActionButton()
    }

    /// 配置背景视图样式
    private func configureBackgroundView() {
        // 设置圆角
        view.layer.cornerRadius = 18
        // 设置背景颜色为次要系统背景色
        view.backgroundColor = .secondarySystemBackground
    }

    /// 配置堆栈视图
    private func configureStackView() {
        // 水平排列
        stackView.axis = .horizontal
        // 等间距分布
        stackView.distribution = .equalSpacing
        // 添加子视图
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
    }

    /// 配置操作按钮
    private func configureActionButton() {
        // 添加点击事件监听
        actionButton.addTarget(self, action: #selector(actionButonnTapped), for: .touchUpInside)
    }

    /// 操作按钮点击事件处理方法
    /// 子类应重写此方法以实现具体逻辑
    @objc func actionButonnTapped() {
        // 空实现，由子类重写
    }

    /// 配置 UI 布局约束
    private func layoutUI() {
        view.addSubviews(stackView, actionButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20

        NSLayoutConstraint.activate([
            // 堆栈视图布局
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),

            // 操作按钮布局
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

}
