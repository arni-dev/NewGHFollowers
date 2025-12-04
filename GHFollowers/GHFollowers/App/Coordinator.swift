//
//  Coordinator.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 14/2/2024.
//

import UIKit

/// Coordinator 协议：协调器模式的核心协议
/// 协调器模式用于管理应用的导航流程，将导航逻辑从视图控制器中分离出来
/// 这样可以让视图控制器更加专注于显示内容，而不是处理导航逻辑
protocol Coordinator: AnyObject {
    
    /// 父协调器：当前协调器的上级协调器
    /// 用于建立协调器之间的层级关系，便于向上传递事件或返回上一级
    var parentCoordinator: Coordinator? { get set }
    
    /// 子协调器数组：当前协调器管理的所有子协调器
    /// 用于管理子流程，例如从主流程跳转到详情流程时，详情协调器就是主协调器的子协调器
    var children: [Coordinator] { get set }

    /// 启动协调器
    /// 每个协调器必须实现此方法，用于开始其管理的导航流程
    /// 通常在此方法中创建并显示第一个视图控制器
    func start()
}
