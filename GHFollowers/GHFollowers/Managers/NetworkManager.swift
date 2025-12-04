//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 23/1/2024.
//

import UIKit

/// NetworkManager 类：网络管理器，负责处理所有网络请求和图片下载
/// 使用单例模式确保全局只有一个实例
final class NetworkManager {
    /// 单例实例，全局共享
    static let shared = NetworkManager()

    /// GitHub API 的基础 URL
    let baseURL = "https://api.github.com"
    
    /// 图片缓存，用于存储已下载的头像图片，避免重复下载
    /// NSCache 会在内存不足时自动清理缓存
    let cache = NSCache<NSString, UIImage>()
    
    /// JSON 解码器，用于将服务器返回的 JSON 数据解码为 Swift 对象
    let decoder = JSONDecoder()

    /// 私有初始化方法，防止外部创建新实例（单例模式）
    private init() {
        // 设置 JSON 键名解码策略：将 snake_case 转换为 camelCase
        // 例如：avatar_url -> avatarUrl
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        // 设置日期解码策略：使用 ISO 8601 标准格式
        decoder.dateDecodingStrategy = .iso8601
    }

    /// 异步下载图片
    /// - Parameter urlString: 图片的 URL 字符串
    /// - Returns: 下载的 UIImage 对象，如果下载失败则返回 nil
    func downloadImage(from urlString: String) async -> UIImage? {
        // 创建缓存键
        let cacheKey = NSString(string: urlString)

        // 先检查缓存中是否已有该图片
        if let image = cache.object(forKey: cacheKey) {
            return image
        }

        // 将字符串转换为 URL 对象
        guard let url = URL(string: urlString) else {
            return nil
        }

        do {
            // 使用 URLSession 下载图片数据
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // 将数据转换为 UIImage
            guard let image = UIImage(data: data) else {
                return nil
            }
            
            // 将图片存入缓存，下次使用时可直接从缓存获取
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            // 下载失败，返回 nil
            return nil
        }
    }
}

// MARK: - 网络请求扩展
extension NetworkManager {
    /// 通用网络请求方法，支持任何遵循 Codable 协议的返回类型
    /// - Parameters:
    ///   - session: URLSession 实例，用于执行网络请求
    ///   - endpoint: 请求的端点（包含 URL、请求方法等信息）
    ///   - type: 期望返回的数据类型（必须遵循 Codable 协议）
    /// - Returns: 解码后的数据对象
    /// - Throws: 可能抛出 GFError 类型的错误
    func request<T: Codable>(session: URLSession,
                             _ endpoint: Endpoint,
                             type: T.Type) async throws -> T {
        // 从端点获取 URL，如果无法构建则抛出错误
        guard let url = endpoint.url else {
            throw GFError.invalidURL
        }

        // 根据 URL 和请求方法构建请求对象
        let request = buildRequest(from: url, methodType: endpoint.methodType)

        // 执行网络请求，获取数据和响应
        let (data, response) = try await session.data(for: request)

        // 验证响应状态码是否在 200-300 之间（表示成功）
        guard let response = response as? HTTPURLResponse,
                (200...300) ~= response.statusCode else {
            throw GFError.invalidResponse
        }
        
        // 尝试将 JSON 数据解码为指定类型
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            // 解码失败，抛出无效数据错误
            throw GFError.invalidData
        }
    }
}

// MARK: - 私有辅助方法
private extension NetworkManager {
    /// 构建 URLRequest 对象
    /// - Parameters:
    ///   - url: 请求的 URL
    ///   - methodType: HTTP 请求方法类型（GET、POST 等）
    /// - Returns: 配置好的 URLRequest 对象
    func buildRequest(from url: URL, methodType: Endpoint.MethodType) -> URLRequest {
        var request = URLRequest(url: url)

        // 根据方法类型设置 HTTP 方法
        switch methodType {
        case .GET:
            request.httpMethod = "GET"
        }
        return request
    }
}
