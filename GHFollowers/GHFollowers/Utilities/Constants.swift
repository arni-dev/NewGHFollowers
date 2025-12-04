//
//  Constants.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 30/1/2024.
//

import Foundation
import UIKit

/// SFSymbols 枚举：存储应用中使用的 SF Symbols 系统图标
/// SF Symbols 是苹果提供的系统图标库，可以自动适配不同的尺寸和粗细
enum SFSymbols {
    /// 位置图标：地图标记和椭圆，用于显示用户所在地
    static let location = UIImage(systemName: "mappin.and.ellipse")
    
    /// 仓库图标：文件夹，用于显示用户的公开仓库
    static let repos = UIImage(systemName: "folder")
    
    /// Gist 图标：左对齐文本，用于显示用户的代码片段
    static let gists = UIImage(systemName: "text.alignleft")
    
    /// 粉丝图标：心形，用于显示关注该用户的人数
    static let followers = UIImage(systemName: "heart")
    
    /// 关注图标：两个人，用于显示用户正在关注的人数
    static let following = UIImage(systemName: "person.2")
}

/// Images 枚举：存储应用中使用的自定义图片资源
enum Images {
    /// 头像占位图：当用户头像加载失败或未加载时显示
    static let placeholder = UIImage(resource: .avatarPlaceholder)
    
    /// GitHub Logo：GitHub 的标志图片
    static let ghLogo = UIImage(resource: .ghLogo)
    
    /// 空状态 Logo：当列表为空时显示的图片
    static let emptyStateLogo = UIImage(resource: .emptyStateLogo)
}
