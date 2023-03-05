import SnowPack

final class SimpleWeatherViewController: ViewController {
        
    var viewModel: SimpleWeatherViewModel?
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28.0, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    lazy var conditionStack: UIStackView = {
        let stack = UIStackView(axis: .horizontal, alignment: .center, distribution: .equalCentering)
        stack.height(36.0)
        [conditionLabel, conditionIcon].forEach(stack.addArrangedSubview)
        return stack
    }()
    
    lazy var conditionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0)
        label.textAlignment = .center
        return label
    }()
    
    lazy var conditionIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.heightWidth(36.0)
        return imageView
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 64.0, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    init(viewModel: SimpleWeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Live API Demo"
        
        [locationLabel, conditionStack, temperatureLabel].forEach(addSubview)
        
        temperatureLabel.height(64.0)
        temperatureLabel.width(300.0)
        temperatureLabel.centerInSuperview()
        
        conditionStack.bottomToTop(of: temperatureLabel, offset: -4.0)
        conditionStack.centerXToSuperview()
        
        locationLabel.bottomToTop(of: conditionStack, offset: -6.0)
        locationLabel.centerXToSuperview()
        
        bind(viewModel)
    }
    
    func bind(_ viewModel: SimpleWeatherViewModel?) {
        guard isViewLoaded, let viewModel = viewModel else { return }
        
        viewModel.refreshEvent.receive(on: DispatchQueue.main).sink { [weak self] in
            guard let data = viewModel.weatherData else { return }
            self?.locationLabel.text = data.location.name
            self?.temperatureLabel.text = "\(data.current.temp_f)ºF"
            self?.conditionLabel.text = data.current.condition.text
            self?.conditionIcon.loadImage(
                from: URL(string: "https:" + data.current.condition.icon.absoluteString)!
            )
            self?.conditionLabel.sizeToFit()
        }.store(in: &cancellables)
        
    }
}
