//
//  String+Ext.swift
//  GHFollowers
//
//  Created by CHI YU CHAN on 9/2/2024.
//

import Foundation

/// String 扩展：为 String 类型添加日期转换相关的便捷方法
extension String {
    /// 将字符串转换为 Date 对象
    /// - Returns: 转换后的 Date 对象，如果转换失败则返回 nil
    func convertToDate() -> Date? {
        // 创建日期格式化器
        let dateFormatter =  DateFormatter()
        
        // 设置日期格式：ISO 8601 格式
        // 例如：2024-01-20T10:30:00+0800
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        // 设置区域标识符为 POSIX，确保日期解析的一致性
        // 避免因用户设备的区域设置不同而导致解析失败
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        // 设置时区为当前时区
        dateFormatter.timeZone = .current

        // 将字符串转换为 Date 对象
        return dateFormatter.date(from: self)

    }

    /// 将字符串转换为显示格式的日期字符串
    /// 例如：将 "2024-01-20T10:30:00+0800" 转换为 "January 2024"
    /// - Returns: 格式化后的日期字符串，如果转换失败则返回 "N/A"
    func convertToDisplayFormat() -> String {
        // 先将字符串转换为 Date 对象
        guard let date = self.convertToDate() else { return "N/A"}
        
        // 再将 Date 对象转换为"月份 年份"格式
        return date.convertToMonthYearFormat()
    }
}

// MARK: - Localization
/// String 扩展：提供本地化功能
extension String {
    /// 获取本地化字符串
    /// - Returns: 本地化后的字符串
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    /// 获取本地化字符串（带注释）
    /// - Parameter comment: 注释,帮助翻译人员理解上下文
    /// - Returns: 本地化后的字符串
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
}
