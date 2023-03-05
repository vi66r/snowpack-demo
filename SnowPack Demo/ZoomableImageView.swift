import UIKit

open class ZoomableImageView: UIScrollView {
    
    public enum ZoomType: String {
        case inside
        case outside
    }
    
    public var zoomType: ZoomType = .inside
    
    
    
}
