import SnowPack

final class SimpleTableViewDemoCell: UIView, Hydratable {
    
    var text: String = "" {
        didSet {
            label.text = text
            label.sizeToFit()
        }
    }
    
    lazy var label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var trailingChevron: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.forward"))
        imageView.contentMode = .scaleAspectFit
        imageView.heightWidth(18.0)
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .background
        [label, trailingChevron].forEach(addSubview)
        label.centerYToSuperview()
        label.leadingToSuperview(offset: 8.0)
        trailingChevron.centerYToSuperview()
        trailingChevron.trailingToSuperview(offset: 8.0)
        
        guard let lighterGray = UIColor.lightGray.lightened else { return }
        applyBorders(to: [.top], color: lighterGray, thickness: 1.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hydrate(with model: String) {
        text = model
    }
}
