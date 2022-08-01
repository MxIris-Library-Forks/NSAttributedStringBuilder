#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public typealias ATextGroup = NSAttributedString.AttrTextGroup

public extension NSAttributedString {
    struct AttrTextGroup: Component {
        public let string: String = ""
        
        public let attributes: Attributes = [:]
        
        private var attributedTexts: [AText]
        
        private var components: [Component]
        
        public var attributedString: NSAttributedString {
            let mas = NSMutableAttributedString(string: "")
            for component in components {
                mas.append(component.attributedString)
            }
            return mas
        }
        
        public init(@AttrTextGroupBuilder attrTextGroupBuilder: () -> [Component]) {
            self.init(components: attrTextGroupBuilder())
            
        }
        
        private init(components: [Component]) {
            self.components = components
            self.attributedTexts = components.compactMap { $0 as? AText }
        }
        
        public func attributes(_ newAttributes: Attributes) -> Component {
            guard attributedTexts.count > 0 else { return self }
            var tempComponent = [Component]()
            for attribute in newAttributes {
                tempComponent.append(contentsOf: setAttributed(with: attribute, to: components))
            }
            
            return AttrTextGroup(components: tempComponent)
        }
        private func setAttributed(with newAttribute: (key: NSAttributedString.Key, value: Any), to components: [Component]) -> [Component] {
            var tempComponent = [Component]()
            for component in components {
                if let attributedText = component as? AText {
                    let tempString = attributedText.string
                    var tempAttributes = attributedText.attributes
                    tempAttributes[newAttribute.key] = newAttribute.value
                    tempComponent.append(AText(tempString, attributes: tempAttributes))
                } else if let group = component as? AttrTextGroup {
                    tempComponent.append(contentsOf: setAttributed(with: newAttribute, to: group.components))
                } else {
                    tempComponent.append(component)
                }
            }
            return tempComponent
        }
    }
}

@resultBuilder
public enum AttrTextGroupBuilder {
    public static func buildBlock(_ components: Component...) -> [Component] {
        components.map { $0 }
    }
}
