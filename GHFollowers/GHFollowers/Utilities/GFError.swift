//
//  GFError.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 23/1/2024.
//

import Foundation

/// GFError 枚举：定义应用中可能出现的各种错误类型
/// 遵循 Error 协议，每个错误都有对应的用户友好提示信息
enum GFError: Error {
    /// 无效的 URL：构建 URL 时出错
    case invalidURL
    
    /// 无法完成请求：通常是网络连接问题
    case unableToComplete
    
    /// 无效的响应：服务器返回的响应格式不正确
    case invalidResponse
    
    /// 无效的数据：从服务器接收到的数据格式不正确或无法解析
    case invalidData
    
    /// 无法收藏：收藏用户时出错
    case unableToFavorite
    
    /// 已在收藏中：该用户已经被收藏过了
    case alreadyInFavorites
    
    /// 获取本地化的错误消息
    var rawValue: String {
        switch self {
        case .invalidURL:
            return "error.invalidURL".localized
        case .unableToComplete:
            return "error.unableToComplete".localized
        case .invalidResponse:
            return "error.invalidResponse".localized
        case .invalidData:
            return "error.invalidData".localized
        case .unableToFavorite:
            return "error.unableToFavorite".localized
        case .alreadyInFavorites:
            return "error.alreadyInFavorites".localized
        }
    }
}
