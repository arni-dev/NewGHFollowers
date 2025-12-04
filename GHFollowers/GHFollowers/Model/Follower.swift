//
//  Follower.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 23/1/2024.
//

import Foundation

/// Follower 结构体：表示 GitHub 关注者的数据模型
/// 遵循 Codable 协议以支持 JSON 编解码
/// 遵循 Hashable 协议以支持在集合（Set）和字典（Dictionary）中使用
struct Follower: Codable, Hashable {
    /// 用户的登录名（GitHub 用户名）
    var login: String
    
    /// 用户的头像 URL 地址
    var avatarUrl: String
}
