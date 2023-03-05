import SnowPack

final class OnboardingViewController: SimpleOnboardingViewController {
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.applyRoundedCorners(22.0)
        button.height(44.0)
        button.width(66.0)
        
        button.addAction(UIAction { [weak self] action in
            self?.next()
        }, for: .touchUpInside)
        
        return button
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.applyRoundedCorners(22.0)
        button.height(44.0)
        button.width(66.0)
        
        button.addAction(UIAction { [weak self] action in
            self?.previous()
        }, for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideNavigationBar(animated: false)
        
        [nextButton, backButton].forEach(headerView.addSubview)
        nextButton.centerYToSuperview()
        nextButton.trailingToSuperview(offset: 8.0)
        backButton.centerYToSuperview()
        backButton.leadingToSuperview(offset: 8.0)
    }
    
}
