//
//  Endpoint.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 23/2/2024.
//

import Foundation

/// Endpoint 枚举：定义应用中所有的 API 端点
/// 使用枚举来组织不同类型的 API 请求，使代码更清晰、类型安全
enum Endpoint {
    /// 用户相关的 API 端点
    case user(User)

    /// User 枚举：定义所有与用户相关的 API 端点
    enum User {
        /// 获取指定用户的关注者列表
        /// - Parameters:
        ///   - username: GitHub 用户名
        ///   - page: 页码（用于分页加载）
        case getfollowers(username: String, page: Int)
        
        /// 获取指定用户的详细信息
        /// - Parameter username: GitHub 用户名
        case getUserInfo(username: String)
    }

    /// MethodType 枚举：定义 HTTP 请求方法类型
    enum MethodType {
        /// GET 请求：用于获取数据
        case GET
    }
}

// MARK: - 端点配置扩展
extension Endpoint {

    /// API 主机地址
    var host: String { "api.github.com" }

    /// API 路径
    /// 根据不同的端点类型返回对应的路径
    var path: String {
        switch self {
        case let .user(.getfollowers(username, _)):
            // 获取关注者列表的路径：/users/{username}/followers
            return "/users/\(username)/followers"
        case let .user(.getUserInfo(username)):
            // 获取用户信息的路径：/users/{username}
            return "/users/\(username)"
        }
    }

    /// HTTP 请求方法类型
    /// 根据不同的端点返回对应的请求方法
    var methodType: MethodType {
        switch self {
        case .user(.getfollowers), .user(.getUserInfo):
            // 这两个端点都使用 GET 方法
            return .GET
        }
    }

    /// URL 查询参数
    /// 返回需要附加到 URL 的查询参数字典
    var queryItems: [String: String]? {
        switch self {
        case let .user(.getfollowers(_, page)):
            // 获取关注者列表时的查询参数
            return ["per_page": "100",  // 每页返回 100 条数据
                    "page": String(page)]  // 当前页码
        case .user(.getUserInfo):
            // 获取用户信息不需要查询参数
            return nil
        }
    }
}

// MARK: - URL 构建扩展
extension Endpoint {

    /// 构建完整的 URL
    /// 将主机、路径和查询参数组合成完整的 URL
    var url: URL? {
        // 创建 URL 组件对象
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"  // 使用 HTTPS 协议
        urlComponents.host = host  // 设置主机地址
        urlComponents.path = path  // 设置路径

        // 创建查询参数数组
        var requestQueryItems = [URLQueryItem]()

        // 将查询参数字典转换为 URLQueryItem 数组
        queryItems?.forEach { item in
            requestQueryItems.append(URLQueryItem(name: item.key, value: item.value))
        }
        urlComponents.queryItems = requestQueryItems

        // 返回构建好的 URL
        return urlComponents.url
    }

}
