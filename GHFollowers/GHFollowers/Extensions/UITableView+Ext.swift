//
//  UITableView+Ext.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 13/2/2024.
//

import UIKit

/// UITableView 扩展：为 UITableView 添加便捷的数据刷新和视图管理方法
extension UITableView {
    /// 在主线程上重新加载表格数据
    /// 由于 UI 更新必须在主线程执行，此方法确保数据刷新在主线程进行
    func reloadDataOnMainThread() {
        // 切换到主线程
        DispatchQueue.main.async {
            // 重新加载表格数据
            self.reloadData()
        }
    }

    /// 移除多余的空白单元格
    /// 当表格数据不足以填满整个屏幕时，会显示空白单元格
    /// 此方法通过设置一个空的 footer 视图来隐藏这些空白单元格
    func removeExcessCells() {
        // 设置表格的 footer 为一个空视图
        tableFooterView = UIView(frame: .zero)
    }
}
