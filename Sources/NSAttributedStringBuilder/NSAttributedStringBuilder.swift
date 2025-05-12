// NSAttributedString does not support SwiftUI Font and color, we still need to use UI/NS Font/Color
#if canImport(UIKit)
import UIKit

public typealias Font = UIFont
public typealias Color = UIColor
#elseif canImport(AppKit)
import AppKit

public typealias Font = NSFont
public typealias Color = NSColor
#endif

public typealias Attributes = [NSAttributedString.Key: Any]

@resultBuilder
public enum NSAttributedStringBuilder {
    public static func buildBlock() -> [Component] {
        []
    }

    public static func buildBlock(_ components: [Component]...) -> [Component] {
        components.flatMap { $0 }
    }

    public static func buildEither(first component: [Component]?) -> [Component] {
        component ?? []
    }

    public static func buildEither(second component: [Component]?) -> [Component] {
        component ?? []
    }

    public static func buildOptional(_ component: [Component]?) -> [Component] {
        component ?? []
    }

    public static func buildExpression(_ expression: [Component]?) -> [Component] {
        expression ?? []
    }

    public static func buildExpression(_ expression: Component?) -> [Component] {
        expression.map { [$0] } ?? []
    }

    public static func buildArray(_ components: [[Component]]) -> [Component] {
        components.flatMap { $0 }
    }

    public static func buildFinalResult(_ components: [any Component]) -> NSAttributedString {
        let mas = NSMutableAttributedString(string: "")
        for component in components {
            mas.append(component.attributedString)
        }
        return mas
    }
}

extension NSAttributedString {
    public convenience init(@NSAttributedStringBuilder _ builder: () -> NSAttributedString) {
        self.init(attributedString: builder())
    }
}
