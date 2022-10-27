/*******************************************************************************
 Copyright (K), 2020 - ~, ╰莪呮想好好宠Nǐつ
 
 Author:        ╰莪呮想好好宠Nǐつ
 E-mail:        1091676312@qq.com
 GitHub:        https://github.com/yijingKing
 ********************************************************************************/

import UIKit
import Foundation
import QuartzCore

//MARK: --- 框线
public extension YEXProtocol where T: UIView {
    /// 单边边框线
    func addBorder(side: UIView.ViewSide, thickness: CGFloat, color: UIColor, leftOffset: CGFloat = 0, rightOffset: CGFloat = 0, topOffset: CGFloat = 0, bottomOffset: CGFloat = 0) {
        obj.layoutIfNeeded()
        switch side {
        case .top:
            let border: CALayer = obj._getOneSidedBorder(frame: CGRect(x: 0 + leftOffset,
                                                                       y: 0 + topOffset,
                                                                       width: obj.bounds.size.width - leftOffset - rightOffset,
                                                                       height: thickness), color: color)
            obj.layer.addSublayer(border)
        case .right:
            let border: CALayer = obj._getOneSidedBorder(frame: CGRect(x: obj.frame.size.width-thickness-rightOffset,
                                                                       y: 0 + topOffset, width: thickness,
                                                                       height: obj.bounds.size.height - topOffset - bottomOffset), color: color)
            obj.layer.addSublayer(border)
        case .bottom:
            let border: CALayer = obj._getOneSidedBorder(frame: CGRect(x: 0 + leftOffset,
                                                                       y: obj.bounds.size.height-thickness-bottomOffset,
                                                                       width: obj.bounds.size.width - leftOffset - rightOffset, height: thickness), color: color)
            obj.layer.addSublayer(border)
        case .left:
            let border: CALayer = obj._getOneSidedBorder(frame: CGRect(x: 0 + leftOffset,
                                                                       y: 0 + topOffset,
                                                                       width: thickness,
                                                                       height: obj.bounds.size.height - topOffset - bottomOffset), color: color)
            obj.layer.addSublayer(border)
        }
    }
    /// 渐变色
    func gradientLayer (direction: UIView.GradientDirection,locations: Array<NSNumber> = [0.0,1.0] ,colors: [UIColor]) {
        obj.layoutIfNeeded()
        let gradientLayer = CAGradientLayer.init()
        gradientLayer.frame = obj.bounds
        var cgColors = [CGColor]()
        colors.forEach { (colo) in
            cgColors.append(colo.cgColor)
        }
        gradientLayer.colors = cgColors
        gradientLayer.locations = locations
        switch direction {
        case .vertical:
            gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint.init(x: 0, y: 1.0)
            break
        case .level:
            gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint.init(x: 1.0, y: 0)
            break
        case .leftTop:
            gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint.init(x: 1.0, y: 1.0)
            break
        case .leftBottom:
            gradientLayer.startPoint = CGPoint.init(x: 0, y: 1.0)
            gradientLayer.endPoint = CGPoint.init(x: 1.0, y: 0.0)
            break
        }
        obj.layer.insertSublayer(gradientLayer, at: 0)
    }
    /// 添加多个视图
    func addSubviews(_ views: [UIView]) {
        views.forEach { eachView in
            obj.addSubview(eachView)
        }
    }
}

//MARK: --- 跳转
public extension YEXProtocol where T: UIView {
    func push(_ vc: UIViewController, animated: Bool = true) {
        if let currentC = currentController {
            if currentC.isKind(of: UINavigationController.self) {
                if let nav = currentC as? UINavigationController {
                    if nav.viewControllers.count > 0 {
                        vc.hidesBottomBarWhenPushed = true
                    }
                    nav.pushViewController(vc, animated: animated)
                }
            } else {
                if let nav = currentC.navigationController {
                    if nav.viewControllers.count > 0 {
                        vc.hidesBottomBarWhenPushed = true
                    }
                    nav.pushViewController(vc, animated: animated)
                }
            }
        }
    }

    func pop(_ animated: Bool = true) {
        if let currentC = currentController {
            if currentC.isKind(of: UINavigationController.self) {
                ((currentC as? UINavigationController))?.popViewController(animated: animated)
            } else {
                currentC.dismiss(animated: animated, completion: nil)
            }
        }
    }
    
    func popRootViewController(_ animated: Bool = true) {
        if let currentC = currentController {
            if currentC.isKind(of: UINavigationController.self) {
                ((currentC as? UINavigationController))?.popToRootViewController(animated: animated)
            }
        }
    }
    
    func present(_ vc: UIViewController, animated: Bool = true) {
        currentController?.present(vc, animated: animated, completion: nil)
    }

    func dismiss(_ animated: Bool = true) {
        currentController? .dismiss(animated: animated, completion: nil)
    }
    
    ///获取父控制器
    var currentController: UIViewController? {
        for view in sequence(first: obj.superview, next: { $0?.superview }) {
            if let responder = view?.next {
                if responder.isKind(of: UINavigationController.self) {
                    let tab = responder as? UINavigationController
                    return tab?.visibleViewController
                } else if responder.isKind(of: UITabBarController.self) {
                    let tab = responder as? UITabBarController
                    return tab?.selectedViewController
                } else if responder.isKind(of: UIViewController.self) {
                    let vc = responder as? UIViewController
                    return vc
                }
            }
        }
        return nil
    }
}

//MARK: --- layer
public extension YEXProtocol where T: UIView {
    //MARK: --- 切圆角
    ///切圆角
    func cornerRadii(_ radii: CGFloat) {
        obj.cornerRadii = .init(radii)
    }
    //MARK: --- 切圆角
    ///切圆角
    func cornerRadii(_ topLeft: CGFloat,_ topRight: CGFloat,_ bottomLeft: CGFloat,_ bottomRight: CGFloat) {
        obj.cornerRadii = .init(topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight)
    }
    //MARK: --- 边框
    ///边框
    func borderWidth(width: CGFloat) {
        obj.layer.borderWidth = width
    }
    //MARK: --- 阴影
    ///阴影
    func addShadow(offset: CGSize, radius: CGFloat, color: UIColor, opacity: Float,_ cornerRadius: CGFloat? = nil) {
        obj.layer.shadowOffset = offset
        obj.layer.shadowRadius = radius
        obj.layer.shadowOpacity = opacity
        obj.layer.shadowColor = color.cgColor
        if let r = cornerRadius {
            obj.layer.shadowPath = UIBezierPath(roundedRect: obj.bounds, cornerRadius: r).cgPath
        }
    }
    //MARK: ------- 边框
    ///边框
    func addBorder(width: CGFloat, _ color: UIColor = .black) {
        obj.layer.borderWidth = width
        obj.layer.borderColor = color.cgColor
        obj.layer.masksToBounds = true
    }
    ///边框-上
    func addBorderTop(_ size: CGFloat,_ padding: CGFloat = 0,_ color: UIColor = .black) {
        obj._addBorderUtility(x: padding, y: 0, width: obj.frame.width - padding * 2, height: size, color: color)
    }
    ///边框-下
    func addBorderBottom(_ size: CGFloat,_ padding: CGFloat = 0,_ color: UIColor = .black) {
        obj._addBorderUtility(x: padding, y: obj.frame.height - size, width: obj.frame.width - padding * 2, height: size, color: color)
    }
    ///边框-左
    func addBorderLeft(_ size: CGFloat,_ padding: CGFloat = 0,_ color: UIColor = .black) {
        obj._addBorderUtility(x: 0, y: padding, width: size, height: obj.frame.height - padding * 2, color: color)
    }
    ///边框-右
    func addBorderRight(_ size: CGFloat,_ padding: CGFloat = 0,_ color: UIColor = .black) {
        obj._addBorderUtility(x: obj.frame.width - size, y: padding, width: size, height: obj.frame.height - padding * 2, color: color)
    }
    //MARK: --- 绘画
    ///画圆
    func drawCircle(fillColor: UIColor,_ strokeColor: UIColor = .black, strokeWidth: CGFloat) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: obj.width, height: obj.width), cornerRadius: obj.width / 2)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = strokeWidth
        obj.layer.addSublayer(shapeLayer)
    }
    ///画中空圆
    func drawStroke(width: CGFloat,_ color: UIColor = .black) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: width, height: width), cornerRadius: width / 2)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        obj.layer.addSublayer(shapeLayer)
    }
    ///画虚线
    func drawDashLine(lineLength: Int ,lineSpacing: Int,lineColor: UIColor) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = obj.bounds
        //        只要是CALayer这种类型,他的anchorPoint默认都是(0.5,0.5)
        shapeLayer.anchorPoint = CGPoint(x: 0, y: 0)
        //        shapeLayer.fillColor = UIColor.blue.cgColor
        shapeLayer.strokeColor = lineColor.cgColor
        
        shapeLayer.lineWidth = obj.bounds.size.height
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        
        shapeLayer.lineDashPattern = [NSNumber(value: lineLength),NSNumber(value: lineSpacing)]
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: obj.bounds.size.width, y: 0))
        
        shapeLayer.path = path
        obj.layer.addSublayer(shapeLayer)
    }
    ///移除layer
    func removeLayer() {
        obj.layer.mask = nil
        obj.layer.borderWidth = 0
    }
}

//MARK: --- 转换
public extension YEXProtocol where T: UIView {
    ///转换成图片
    func toImage(_ size:CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, obj.isOpaque, 0.0)
        obj.drawHierarchy(in: obj.bounds, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img ?? UIImage.init()
    }
    ///转换成图片
    func toImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: obj.bounds)
        return renderer.image { rendererContext in
            obj.layer.render(in: rendererContext.cgContext)
        }
    }
}

public extension YEXProtocol where T: UIView {
    ///视图包含控制器
    func viewContainingController() -> UIViewController? {
        var nextResponder: UIResponder? = obj
        repeat {
            nextResponder = nextResponder?.next
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
        } while nextResponder != nil
        return nil
    }
}


public extension UIView {
    /// 渐变色方向
    enum GradientDirection: Int {
        ///垂直
        case vertical
        ///水平
        case level
        ///左上到右下
        case leftTop
        ///左下到右上
        case leftBottom
    }
    enum ViewSide: Int {
        case top
        case right
        case bottom
        case left
    }
    fileprivate func _getOneSidedBorder(frame: CGRect, color: UIColor) -> CALayer {
        let border:CALayer = CALayer()
        border.frame = frame
        border.backgroundColor = color.cgColor
        return border
    }
    fileprivate func _getViewBackedOneSidedBorder(frame: CGRect, color: UIColor) -> UIView {
        let border:UIView = UIView.init(frame: frame)
        border.backgroundColor = color
        return border
    }
}

//MARK: --- frame
public extension UIView {
    var x: CGFloat {
        get {
            return frame.origin.x
        } set(value) {
            frame = CGRect(x: value, y: y, width: width, height: height)
        }
    }
    var y: CGFloat {
        get {
            return frame.origin.y
        } set(value) {
            frame = CGRect(x: x, y: value, width: width, height: height)
        }
    }
    var width: CGFloat {
        get {
            return frame.size.width
        } set(value) {
            frame = CGRect(x: x, y: y, width: value, height: height)
        }
    }
    var height: CGFloat {
        get {
            return frame.size.height
        } set(value) {
            frame = CGRect(x: x, y: y, width: width, height: value)
        }
    }
    var left: CGFloat {
        get {
            return x
        } set(value) {
            x = value
        }
    }
    var right: CGFloat {
        get {
            return x + width
        } set(value) {
            x = value - width
        }
    }
    var top: CGFloat {
        get {
            return y
        } set(value) {
            y = value
        }
    }
    var bottom: CGFloat {
        get {
            return y + height
        } set(value) {
            y = value - height
        }
    }
    var origin: CGPoint {
        get {
            return frame.origin
        } set(value) {
            frame = CGRect(origin: value, size: frame.size)
        }
    }
    var centerX: CGFloat {
        get {
            return center.x
        } set(value) {
            center.x = value
        }
    }
    var centerY: CGFloat {
        get {
            return center.y
        } set(value) {
            center.y = value
        }
    }
    var size: CGSize {
        get {
            return frame.size
        } set(value) {
            frame = CGRect(origin: frame.origin, size: value)
        }
    }
    fileprivate func _addBorderUtility(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: x, y: y, width: width, height: height)
        layer.addSublayer(border)
    }
}

//MARK: --- 手势
public extension UIView {
    ///多击
    func addTapGesture(_ tapNumber: Int,
                       _ target: AnyObject,
                       _ action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    ///单击
    func addTapGesture(_ action: ((UITapGestureRecognizer) -> Void)?) {
        let tap = YEXBlockTap(tapCount: 1, fingerCount: 1, action: action)
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    ///滑动
    func addSwipeGesture(_ direction: UISwipeGestureRecognizer.Direction,
                         _ numberOfTouches: Int = 1,
                         _ action: ((UISwipeGestureRecognizer) -> Void)?) {
        let swipe = YEXBlockSwipe(direction: direction, fingerCount: numberOfTouches, action: action)
        addGestureRecognizer(swipe)
        isUserInteractionEnabled = true
    }
    ///拖动
    func addPanGesture(_ target: AnyObject,_ action: Selector) {
        let pan = UIPanGestureRecognizer(target: target, action: action)
        addGestureRecognizer(pan)
        isUserInteractionEnabled = true
    }
    ///拖动
    func addPanGesture(_ action: ((UIPanGestureRecognizer) -> Void)?) {
        let pan = YEXBlockPan(action: action)
        addGestureRecognizer(pan)
        isUserInteractionEnabled = true
    }
    ///长按
    func addLongPressGesture(_ target: AnyObject,_ action: Selector) {
        let longPress = UILongPressGestureRecognizer(target: target, action: action)
        addGestureRecognizer(longPress)
        isUserInteractionEnabled = true
    }
    ///长按
    func addLongPressGesture(_ action: ((UILongPressGestureRecognizer) -> Void)?) {
        let longPress = YEXBlockLongPress(action: action)
        addGestureRecognizer(longPress)
        isUserInteractionEnabled = true
    }
}

//MARK: --- 圆角
fileprivate extension UIView {
    private static var cornerRadiiKey: Void?
    private class Wrapper<T> {
        let value: T?
        init(_ value: T?) {
            self.value = value
        }
    }
    
    var cornerRadii: YEXCornerRadii? {
        get {
            let wrapper: Wrapper<YEXCornerRadii>? = associated.get(&UIView.cornerRadiiKey)
            return wrapper?.value
        }
        set {
            let wrapper = Wrapper(newValue)
            associated.set(retain: &UIView.cornerRadiiKey, wrapper)
            
            if let value = newValue {
                update(value)
                
            } else {
                layer.mask = nil
            }
        }
    }
    
    private static let swizzled: Void = {
        let originalSelector = #selector(UIView.layoutSubviews)
        let swizzledSelector = #selector(UIView._layoutSubviews)
        
        guard
            let originalMethod = class_getInstanceMethod(UIView.self, originalSelector),
            let swizzledMethod = class_getInstanceMethod(UIView.self, swizzledSelector) else {
            return
        }
        
        // 在进行 Swizzling 的时候,需要用 class_addMethod 先进行判断一下原有类中是否有要替换方法的实现
        let didAddMethod: Bool = class_addMethod(
            UIView.self,
            originalSelector,
            method_getImplementation(swizzledMethod),
            method_getTypeEncoding(swizzledMethod)
        )
        // 如果 class_addMethod 返回 yes,说明当前类中没有要替换方法的实现,所以需要在父类中查找,这时候就用到 method_getImplemetation 去获取 class_getInstanceMethod 里面的方法实现,然后再进行 class_replaceMethod 来实现 Swizzing
        if didAddMethod {
            class_replaceMethod(
                UIView.self,
                swizzledSelector,
                method_getImplementation(originalMethod),
                method_getTypeEncoding(originalMethod)
            )
            
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    } ()
    
    @objc
    private func _layoutSubviews() {
        _layoutSubviews()
        update(cornerRadii)
    }
    
    private func update(_ cornerRadii: YEXCornerRadii?) {
        guard let cornerRadii = cornerRadii else {
            return
        }
        
        let lastShapeLayer = layer.mask as? CAShapeLayer
        let lastPath = lastShapeLayer?.path
        let path = YEXCornerRadii.path(bounds, cornerRadii)
        // 防止相同路径多次设置
        guard lastPath != path else { return }
        // 移除原有路径动画
        lastShapeLayer?.removeAnimation(forKey: "cornerradii.path")
        // 重置新路径mask
        let mask = CAShapeLayer()
        mask.path = path
        layer.mask = mask
        // 同步视图大小变更动画
        if let temp = layer.animation(forKey: "bounds.size") {
            let animation = CABasicAnimation(keyPath: "path")
            animation.duration = temp.duration
            animation.fillMode = temp.fillMode
            animation.timingFunction = temp.timingFunction
            animation.fromValue = lastPath
            animation.toValue = path
            mask.add(animation, forKey: "cornerradii.path")
        }
    }
    
    struct YEXCornerRadii: Equatable {
        public var topLeft: CGFloat
        public var topRight: CGFloat
        public var bottomLeft: CGFloat
        public var bottomRight: CGFloat
        
        public init(_ radii: CGFloat = 0) {
            self.topLeft = radii
            self.topRight = radii
            self.bottomLeft = radii
            self.bottomRight = radii
        }
        
        public init(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) {
            self.topLeft = topLeft
            self.topRight = topRight
            self.bottomLeft = bottomLeft
            self.bottomRight = bottomRight
        }
        
        public func with(topLeft: CGFloat) -> YEXCornerRadii {
            var temp = self
            temp.topLeft = topLeft
            return temp
        }
        
        public func with(topRight: CGFloat) -> YEXCornerRadii {
            var temp = self
            temp.topRight = topRight
            return temp
        }
        
        public func with(bottomLeft: CGFloat) -> YEXCornerRadii {
            var temp = self
            temp.bottomLeft = bottomLeft
            return temp
        }
        
        public func with(bottomRight: CGFloat) -> YEXCornerRadii {
            var temp = self
            temp.bottomRight = bottomRight
            return temp
        }
        
        public static let zero: YEXCornerRadii = .init(topLeft: 0, topRight: 0, bottomLeft: 0, bottomRight: 0)
        
        static func path(_ bounds: CGRect, _ radii: YEXCornerRadii) -> CGPath {
            let minX = bounds.minX
            let minY = bounds.minY
            let maxX = bounds.maxX
            let maxY = bounds.maxY
            
            let topLeftCenter: CGPoint = .init(x: minX + radii.topLeft, y: minY + radii.topLeft)
            let topRightCenter: CGPoint = .init(x: maxX - radii.topRight, y: minY + radii.topRight)
            let bottomLeftCenter: CGPoint = .init(x: minX + radii.bottomLeft, y: maxY - radii.bottomLeft)
            let bottomRightCenter: CGPoint = .init(x: maxX - radii.bottomRight, y: maxY - radii.bottomRight)
            
            let path = CGMutablePath()
            path.addArc(
                center: topLeftCenter,
                radius: radii.topLeft,
                startAngle: .pi,
                endAngle: .pi / 2 * 3,
                clockwise: false
            )
            path.addArc(
                center: topRightCenter,
                radius: radii.topRight,
                startAngle: .pi / 2 * 3,
                endAngle: 0,
                clockwise: false
            )
            path.addArc(
                center: bottomRightCenter,
                radius: radii.bottomRight,
                startAngle: 0,
                endAngle: .pi / 2,
                clockwise: false
            )
            path.addArc(
                center: bottomLeftCenter,
                radius: radii.bottomLeft,
                startAngle: .pi / 2,
                endAngle: .pi,
                clockwise: false
            )
            path.closeSubpath()
            return path
        }
    }
}

// MARK: - 扩展
public extension UIView {
    /// 添加多个视图
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }
}

