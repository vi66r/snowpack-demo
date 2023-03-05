import SnowPack

final class BlurDemoViewController: ViewController {
    
    var blurred = false
    
    lazy var imageButton: UIButton = {
        let button = UIButton()
        Task {
            let image: UIImage? = try? await .load(from: URL(string: "https://i.imgur.com/cAf4UKz.jpeg")!)
            button.setImage(image, for: .normal)
        }
        button.imageView?.contentMode = .scaleAspectFill
        button.heightWidth(250.0)
            .applyRoundedCorners(55.0, curve: .continuous)
        button.addAction(UIAction { [weak self] action in
            self?.blurOrUnblurImage()
        } , for: .touchUpInside)
        return button
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0)
        label.text = "neow you see me"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "View Blurring Demo"
        
        [imageButton, label].forEach(addSubview)
        
        imageButton.centerInSuperview()
        label.centerXToSuperview()
        label.topToBottom(of: imageButton, offset: 12.0)
    }
    
    func blurOrUnblurImage() {
        if blurred {
            imageButton.removeBlurOverlay(animated: true)
            blurred = false
            label.text = "neow you see me"
        } else {
            imageButton.applyBlurOverlay(animated: true)
            blurred = true
            label.text = "neow you don't"
        }
    }
    
}
