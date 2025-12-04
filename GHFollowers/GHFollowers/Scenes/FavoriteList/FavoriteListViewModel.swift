//
//  FavoriteListViewModel.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 15/2/2024.
//

import Foundation

/// FavoriteListViewModel 类：收藏列表视图模型
/// 负责管理收藏列表的数据获取和删除操作
class FavoriteListViewModel {
    /// 收藏列表数据：使用 @Published 发布数据变化
    @Published var favorites: [Follower] = []

    /// 初始化方法
    init() {}

    /// 获取收藏列表
    /// 从 UserDefaults 中读取保存的收藏用户
    func retrieveFavorites() async throws {
        Task {
            // 异步获取收藏列表
            let favroites = try await PersistenceManager.retrieveFavorites()
            // 更新数据源
            self.favorites = favroites
        }
    }

    /// 移除收藏
    /// - Parameter favorite: 要移除的用户
    func remove(favorite: Follower) async throws {
        // 调用持久化管理器执行移除操作
        try await PersistenceManager.updateWith(favorite: favorite, actionType: .remove)
    }
}
