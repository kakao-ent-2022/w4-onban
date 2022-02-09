
import UIKit

class BadgeLabel: UILabel {
    
    var topInset: CGFloat = 4.0
    var bottomInset: CGFloat = 4.0
    var leftInset: CGFloat = 5.0
    var rightInset: CGFloat = 5.0
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init() {
        super.init(frame: CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .white
        font = defaultFont(.sansBold, size: 12)
    }
    
    override func drawText(in rect: CGRect) {
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
}
