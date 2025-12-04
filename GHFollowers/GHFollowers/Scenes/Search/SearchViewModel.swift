//
//  SearchViewModel.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 14/2/2024.
//

import Foundation

/// SearchViewModel 类：搜索视图模型
/// 负责管理搜索界面的数据和状态
class SearchViewModel {
    /// 用户名：使用 @Published 属性包装器，当值改变时会自动通知订阅者
    /// 这是 Combine 框架的响应式编程特性
    @Published var username = ""

    /// 初始化方法
    init() {}
}
