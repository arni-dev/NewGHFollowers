//
//  UserInfoViewModel.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 16/2/2024.
//

import Foundation

/// UserInfoViewModel 类：用户信息视图模型
/// 负责获取和管理用户详细信息数据
class UserInfoViewModel {

    /// 用户数据对象：使用 @Published 发布数据变化
    @Published var user: User?

    /// 获取用户信息
    /// - Parameter username: GitHub 用户名
    /// - Throws: 网络请求错误
    func getUserInfo(for username: String) async throws {
        // 发起网络请求获取用户信息
        let user = try await NetworkManager.shared.request(session: .shared, .user(.getUserInfo(username: username)), type: User.self)
        // 更新用户数据
        self.user = user
    }
}
