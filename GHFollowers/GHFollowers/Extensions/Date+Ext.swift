//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 9/2/2024.
//

import Foundation

/// Date 扩展：为 Date 类型添加便捷的格式化方法
extension Date {
    /// 将日期转换为"月份 年份"格式的字符串
    /// 例如：January 2024
    /// - Returns: 格式化后的日期字符串
    func convertToMonthYearFormat() -> String {
        // 使用 formatted 方法格式化日期
        // .month(.wide) 表示完整的月份名称（如 January）
        // .year(.defaultDigits) 表示完整的年份（如 2024）
        return formatted(.dateTime.month(.wide).year(.defaultDigits))
    }
}
