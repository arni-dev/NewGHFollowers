//
//  FollowerListViewModel.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 15/2/2024.
//

import Foundation

/// FollowerListViewModel 类：关注者列表视图模型
/// 负责管理关注者列表的数据、搜索逻辑和分页状态
class FollowerListViewModel {
    /// 关注者列表：使用 @Published 发布数据变化
    @Published var followers: [Follower] = []
    
    /// 过滤后的关注者列表（搜索结果）
    @Published var filterFollowers: [Follower] = []

    /// 当前活动的列表：根据搜索状态返回全部或过滤后的列表
    var activeArray: [Follower] {
        isSearching ? filterFollowers : followers
    }

    /// 是否正在搜索
    var isSearching = false
    
    /// 是否还有更多关注者可加载（每页 100 个）
    var hasMoreFollower: Bool {
        followers.count >= 100
    }
    
    /// 是否正在加载更多关注者，防止重复请求
    var isLoadingMoreFollowers = false

    /// 当前用户名
    var username: String
    
    /// 当前页码
    var page = 1

    /// 初始化方法
    /// - Parameters:
    ///   - username: 用户名
    ///   - page: 起始页码
    init(username: String, page: Int = 1) {
        self.username = username
        self.page = page
    }

    /// 获取关注者列表
    /// - Throws: 网络请求错误
    func getFollowers() async throws {
        // 发起网络请求获取关注者
        let followers = try await NetworkManager.shared.request(session: .shared, .user(.getfollowers(username: username, page: page)), type: [Follower].self)
        // 将新获取的数据追加到列表中
        self.followers.append(contentsOf: followers)
    }

    /// 搜索关注者
    /// - Parameter filter: 搜索关键词
    func searchFollowers(with filter: String) {
        // 如果不在搜索状态，清空过滤列表
        guard isSearching else {
            filterFollowers.removeAll()
            isSearching = false
            return
        }
        // 根据用户名过滤关注者（忽略大小写）
        filterFollowers = followers.filter {$0.login.lowercased().contains(filter.lowercased())}
    }

    /// 添加用户到收藏列表
    /// - Throws: 网络请求或持久化错误
    func addUserFavorites() async throws {
        // 获取用户详细信息
        let user = try await NetworkManager.shared.request(session: .shared, .user(.getUserInfo(username: username)), type: User.self)
        // 创建收藏对象
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        // 保存到本地存储
        try await PersistenceManager.updateWith(favorite: favorite, actionType: .add)
    }

    /// 重置视图模型状态
    /// 用于切换用户时清空数据
    func reset() {
        page = 1
        followers.removeAll()
        filterFollowers.removeAll()
        isSearching = false
    }
}
