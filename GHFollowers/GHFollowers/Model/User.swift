//
//  User.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 23/1/2024.
//

import Foundation

/// User 结构体：表示 GitHub 用户的详细信息数据模型
/// 遵循 Codable 协议以支持 JSON 编解码
struct User: Codable {
    /// 用户的登录名（GitHub 用户名）
    let login: String
    
    /// 用户的头像 URL 地址
    let avatarUrl: String
    
    /// 用户的真实姓名（可选，用户可能未设置）
    var name: String?
    
    /// 用户的所在地（可选，用户可能未设置）
    var location: String?
    
    /// 用户的个人简介（可选，用户可能未设置）
    var bio: String?
    
    /// 用户的公开仓库数量
    let publicRepos: Int
    
    /// 用户的公开 Gist 数量（Gist 是 GitHub 的代码片段分享功能）
    let publicGists: Int
    
    /// 用户的 GitHub 主页 URL
    let htmlUrl: String
    
    /// 用户正在关注的人数
    let following: Int
    
    /// 关注该用户的人数（粉丝数）
    let followers: Int
    
    /// 用户账号的创建时间
    let createdAt: Date
}
