//
//  FollowerView.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 13/2/2024.
//

import SwiftUI

/// FollowerView 结构体：关注者视图（SwiftUI）
/// 显示关注者的头像和用户名
struct FollowerView: View {

    /// 头像 URL 地址
    private var avatarUrl: String
    
    /// 用户名
    private var username: String

    /// 头像图片状态：使用 @State 属性包装器管理图片加载状态
    @State private var image: UIImage?

    /// 初始化方法
    /// - Parameters:
    ///   - avatarUrl: 头像 URL 地址
    ///   - username: 用户名
    init(avatarUrl: String, username: String) {
        self.avatarUrl = avatarUrl
        self.username = username
    }

    /// 视图主体
    var body: some View {
        VStack {
            // 头像图片：圆形裁剪
            Image(uiImage: image ?? Images.placeholder)
                .resizable()  // 允许调整大小
                .frame(width: 100, height: 100)  // 设置固定大小
                .aspectRatio(contentMode: .fit)  // 保持宽高比
                .clipShape(Circle())  // 裁剪为圆形

            // 用户名文本
            Text(username)
                .bold()  // 粗体
                .lineLimit(1)  // 限制为单行
                .minimumScaleFactor(0.6)  // 最小缩放比例，避免文字被截断
        }
        .task {
            // 异步任务：下载头像图片
            // .task 修饰符会在视图出现时自动执行异步任务
            self.image = await NetworkManager.shared.downloadImage(from: avatarUrl)
        }
    }
}
