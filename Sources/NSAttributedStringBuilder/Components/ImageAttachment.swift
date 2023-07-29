#if canImport(UIKit)
import UIKit
public typealias Image = UIImage
#elseif canImport(AppKit)
import AppKit
public typealias Image = NSImage
#endif
#if !os(watchOS)
public typealias ImageAttachment = NSAttributedString.ImageAttachment

public extension NSAttributedString {
    struct ImageAttachment: Component {
        // MARK: Lifecycle

        public init(_ image: Image, bounds: Rect? = nil) {
            let attachment = NSTextAttachment()
            attachment.image = image

            if let bounds = bounds {
                attachment.bounds = bounds
            }

            self.attachment = attachment
        }

        // MARK: Public

        public let string: String = ""
        public let attributes: Attributes = [:]

        public var attributedString: NSAttributedString {
            NSAttributedString(attachment: attachment)
        }

        // MARK: Private

        private let attachment: NSTextAttachment
    }
}
#endif
