import SnowPack

class SimpleTableViewDemoViewController: ViewController {
    
    var viewModel: SimpleTableViewDemoViewModel? {
        didSet {
            bind(viewModel)
        }
    }
    
    lazy var randomLabel: UILabel = {
        let label = UILabel()
        label.text = "this is not a UINavigationBar 🤔"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        return label
    }()
    
    var options: [String] {
        ["SimpleTableView Demo",
         "SimpleCollectionView Demo",
         "View Blurring Demo",
         "An Intro to SnowPack and MVVM",
         "Loading Data from an API",
         "Onboarding Demo"
        ]
    }
    
    var sections: [SimpleTableViewSection<SimpleTableViewDemoCell>] {
        [SimpleTableViewSection(elements: options)]
    }
    
    lazy var table: SimpleTableView<SimpleTableViewDemoCell> = {
        let tableView = SimpleTableView(elements: sections,
                                        staticCellHeight: 44.0)
        return tableView
    }()
    
    init(viewModel: SimpleTableViewDemoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SnowPack Demo"
        headerView.addSubview(randomLabel)
        addSubview(table)
        table.edgesToSuperview(usingSafeArea: true)
        randomLabel.edgesToSuperview()
        bind(viewModel)
    }
    
    func bind(_ viewModel: SimpleTableViewDemoViewModel?) {
        guard isViewLoaded, let viewModel = viewModel else { return }
        
        viewModel.navigationEvent
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: navigate(to:))
            .store(in: &cancellables)
        
        linkActions()
    }
    
    func linkActions() {
        table.cellSelected = { [weak self] cell, indexPath in
            guard let row = indexPath?.row else { return }
            self?.viewModel?.handle(row)
        }
    }
}
