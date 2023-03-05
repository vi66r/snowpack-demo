import SnowPack

struct CollectionViewImageCellModel {
    let imageURL: URL
    let title: String
    let shouldBlur: Bool
}

final class CollectionViewImageCell: UIView, Hydratable {
    
    var isSpotlighted = false
    
    var shouldBlur: Bool = false {
        didSet {
            _ = shouldBlur ? imageView.applyBlurOverlay(animated: true) : imageView.removeBlurOverlay(animated: true)
        }
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.applyRoundedCorners(45.0, curve: .continuous)
            .applyBorder(.accent, width: 5.0)
            .applyBoundingShadow()
            .applyBackgroundColor(.surface)
            .contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var captionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0)
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        
        [imageView, captionLabel].forEach(addSubview)
        
        imageView.centerXToSuperview()
        imageView.topToSuperview()
        imageView.heightWidth(145.0)
        
        captionLabel.centerXToSuperview()
        captionLabel.topToBottom(of: imageView, offset: 4.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hydrate(with model: CollectionViewImageCellModel) {
        imageView.loadImage(from: model.imageURL)
        captionLabel.text = model.title
        
        layoutSubviews() // need to call this here otherwise the blur method doesn't know how to lay out
        
        if model.shouldBlur {
            imageView.applyBlurOverlay(animated: false, intensity: 0.15)
            imageView.contentMode = .scaleAspectFit
        } else {
            imageView.removeBlurOverlay(animated: false)
            imageView.contentMode = .scaleAspectFill
        }
    }
}
