import SnowPack

final class SimpleCollectionViewDemoViewController: ViewController {
    
    var viewModel: SimpleCollectionViewDemoViewModel? {
        didSet { bind(viewModel) }
    }
    
    lazy var collectionView: SimpleCollectionView<CollectionViewImageCell> = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = SimpleCollectionView<CollectionViewImageCell>(elements: [],
                                                                           layout: layout,
                                                                           backgroundColor: .background,
                                                                           contentInset: .horizontal(10.0),
                                                                           staticCellSize: .square(170.0))
        return collectionView
    }()
    
    init(viewModel: SimpleCollectionViewDemoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "CollectionView Demo"
        
        addSubview(collectionView)
        collectionView.edgesToSuperview(usingSafeArea: true)
        
        bind(viewModel)
        viewModel?.requestInitialLoad()
    }
    
    func bind(_ viewModel: SimpleCollectionViewDemoViewModel?) {
        guard isViewLoaded, let viewModel = viewModel else { return }
        
        viewModel.initialLoadEvent
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.collectionView.elements = viewModel.data
            }.store(in: &cancellables)
        
        linkActions()
    }
    
    func linkActions() {
        
        collectionView.cellSelected = { [weak self] cell, indexPath in
            guard let indexPath = indexPath, let cell = cell, cell.captionLabel.text != "yor forger" else {
                self?.triggerSystemAlert(title: "HMMMMMMM",
                                         message: "mad sus if you're trying to unblur this 🤔",
                                         dismissTitle: "🥴")
                return
            }
            
            if cell.captionLabel.text == "beluga" {
                if cell.isSpotlighted {
                    self?.collectionView.removeSpotlight()
                    cell.isSpotlighted = false
                } else {
                    self?.collectionView.spotlightCell(at: indexPath, style: .blur)
                    cell.isSpotlighted = true
                }
                return
            }
            
            if cell.captionLabel.text == "noot" {
                if cell.isSpotlighted {
                    self?.collectionView.removeSpotlight()
                    cell.isSpotlighted = false
                } else {
                    self?.collectionView.spotlightCell(at: indexPath, style: .dim)
                    cell.isSpotlighted = true
                }
                return
            }
            
            cell.shouldBlur = !cell.shouldBlur
        }
        
    }
    
}
