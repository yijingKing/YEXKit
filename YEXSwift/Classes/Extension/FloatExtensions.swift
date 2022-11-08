/*******************************************************************************
Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ

Author:        ╰莪呮想好好宠Nǐつ
E-mail:        1091676312@qq.com
GitHub:        https://github.com/yijingKing
********************************************************************************/

import UIKit

public extension Float {
    
    /// 转 Int
    var int: Int { return Int(self) }
    
    /// 转 Int64
    var int64: Int64 { return Int64(self) }
    
    /// 转 Double
    var double: Double { return Double(self) }
    
    /// 转 String
    var string: String { return String(Float(self)) }
    
    /// 转 NSNumber
    var number: NSNumber { return NSNumber.init(value: Float(self)) }
    
}

public extension Float {
    
    /// 浮点数四舍五入,places
    /// - Parameter places: 小数保留的位数
    /// - Returns: 保留后的小数
    func round(to places: Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}

public extension Float {
    /**
     NumberFormatter.Style:
     none                   四舍五入的整数
     decimal                小数形式（以国际化格式输出 保留三位小数,第四位小数四舍五入）
     currency               货币形式（以货币通用格式输出 保留2位小数,第三位小数四舍五入,在前面添加货币符号）
     percent                百分数形式
     scientific             科学计数
     spellOut               朗读形式（英文表示）
     ordinal                序数形式
     currencyISOCode        货币形式
     currencyPlural         货币形式
     currencyAccounting     会计计数
     */
    /// 转换成带百分号
    /// - Parameters:
    ///   - minFraction: 最小分数位(默认0)
    ///   - maxFraction: 最大分数位(默认2)
    ///   - minInteger: 最小整数位
    ///   - maxInteger: 最大整数位
    /// - Returns: 转换成带百分号字符串
    func localized(_ style: NumberFormatter.Style,minFraction: Int? = nil,maxFraction: Int? = nil,minInteger: Int? = nil,maxInteger: Int? = nil) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = style
        
        if let min = minFraction {
            numberFormatter.minimumFractionDigits = min
        }
        if let max = maxFraction {
            numberFormatter.maximumFractionDigits = max
        }
        numberFormatter.minimumIntegerDigits = minInteger ?? 1
        if let max = maxInteger {
            numberFormatter.maximumIntegerDigits = max
        }
        return numberFormatter.string(for: self)
    }
    
    ///分数(默认最小2位,最大3位)
    func decimal(min minFraction: Int? = 2,max maxFraction: Int? = nil) -> String? {
        return localized(.decimal, minFraction: minFraction, maxFraction: maxFraction,minInteger: 1,maxInteger: nil)
    }
    ///百分数(默认最小2位,最大3位)
    func percent(min minFraction: Int? = 2,max maxFraction: Int? = nil) -> String? {
        return localized(.percent, minFraction: minFraction, maxFraction: maxFraction,minInteger: 1,maxInteger: nil)
    }
    
    /// 分割位数
    /// - Parameters:
    ///   - style: 小数形式
    ///   - groupingSeparator: 分隔符号
    ///   - groupingSize: 分隔位数
    /// - Returns: 分割后的字符串
    func separator(_ style: NumberFormatter.Style,separator: String? = ",",length: Int? = 4) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = style
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.groupingSeparator = separator
        numberFormatter.groupingSize = length ?? 0
        return numberFormatter.string(for: self)
    }
    
    /// 增加前后缀
    /// - Parameters:
    ///   - style: 小数形式
    ///   - prefix: 前缀
    ///   - suffix: 后缀
    /// - Returns: 增加后的字符串
    func positive(_ style: NumberFormatter.Style,_ prefix: String? = nil,_ suffix: String? = nil) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = style
        numberFormatter.positivePrefix = prefix
        numberFormatter.positiveSuffix = suffix
        return numberFormatter.string(for: self)
    }
}


