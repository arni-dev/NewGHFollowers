//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 12/2/2024.
//

import Foundation

/// PersistenceActionType 枚举：定义持久化操作的类型
enum PersistenceActionType {
    /// 添加操作：将项目添加到收藏列表
    case add
    
    /// 移除操作：从收藏列表中移除项目
    case remove
}

/// PersistenceManager 枚举：持久化管理器，负责管理收藏数据的本地存储
/// 使用 UserDefaults 来存储用户的收藏列表
enum PersistenceManager {
    /// UserDefaults 实例，用于本地数据存储
    static private let defaults = UserDefaults.standard

    /// Keys 枚举：定义 UserDefaults 中使用的键名
    enum Keys {
        /// 收藏列表的键名
        static let favorites = "favorites"
    }

    /// 更新收藏列表（添加或移除收藏）
    /// - Parameters:
    ///   - favorite: 要操作的 Follower 对象
    ///   - actionType: 操作类型（添加或移除）
    /// - Throws: 可能抛出 GFError 类型的错误
    static func updateWith(favorite: Follower, actionType: PersistenceActionType) async throws {
        // 先获取当前的收藏列表
        var favorites = try await retrieveFavorites()

        // 根据操作类型执行相应的操作
        switch actionType {
        case .add:
            // 添加操作：先检查是否已经收藏过
            guard !favorites.contains(favorite) else {
                throw GFError.alreadyInFavorites
            }
            // 将新的收藏添加到列表
            favorites.append(favorite)
            
        case .remove:
            // 移除操作：从列表中移除指定的收藏
            favorites.removeAll(where: { $0.login == favorite.login })
        }

        // 保存更新后的收藏列表
        try save(favorites: favorites)
    }

    /// 获取收藏列表
    /// - Returns: Follower 数组，如果没有收藏则返回空数组
    /// - Throws: 如果解码失败则抛出错误
    static func retrieveFavorites() async throws -> [Follower] {
        // 从 UserDefaults 中获取收藏数据
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            // 如果没有数据，返回空数组
            return []
        }

        do {
            // 创建 JSON 解码器
            let decoder = JSONDecoder()
            // 将数据解码为 Follower 数组
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            return favorites
        } catch {
            // 解码失败，抛出错误
            throw GFError.unableToComplete
        }
    }

    /// 保存收藏列表到本地
    /// - Parameter favorites: 要保存的 Follower 数组
    /// - Throws: 如果编码失败则抛出错误
    static func save(favorites: [Follower]) throws {
        do {
            // 创建 JSON 编码器
            let encoder = JSONEncoder()
            // 将 Follower 数组编码为 Data
            let encodedFavorites = try encoder.encode(favorites)
            // 保存到 UserDefaults
            defaults.set(encodedFavorites, forKey: Keys.favorites)
        } catch {
           // 编码失败，抛出错误
           throw GFError.unableToFavorite
        }
    }
}
