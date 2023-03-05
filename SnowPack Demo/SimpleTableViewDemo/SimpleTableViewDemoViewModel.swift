import SnowPack

// the possible routes that this viewmodel can take to navigate forward
extension Route {
    static let tableViewDemo = Route("tableViewDemo")
    static let collectionViewDemo = Route("collectionViewDemo")
    static let mvvmIntro = Route("mvvmIntro")
    static let blurDemo = Route("blurDemo")
    static let apiDemo = Route("apiDemo")
    static let onboardingDemo = Route("onboarding")
}

final class SimpleTableViewDemoViewModel: ViewModel {
    
    // believe it or not, this is dependency injected 👀
    let sessionManager = SessionManager.instance
    
    func handle(_ index: Int) {
        let routes: [Route] = [.tableViewDemo, .collectionViewDemo, .blurDemo, .mvvmIntro, .apiDemo, .onboardingDemo]
        guard index < routes.count else { return }
        let route = routes[index]
        
        switch route {
        case .tableViewDemo:
            print("you're already here :)")
        case .collectionViewDemo:
            let viewModel = SimpleCollectionViewDemoViewModel()
            let viewController = SimpleCollectionViewDemoViewController(viewModel: viewModel)
            navigationEvent.send(viewController)
        case .mvvmIntro:
            print("hmmm... something seems to be missing here")
        case .blurDemo:
            let viewController = BlurDemoViewController(nibName: nil, bundle: nil)
            navigationEvent.send(viewController)
        case .apiDemo:
            let viewModel = SimpleWeatherViewModel()
            let viewController = SimpleWeatherViewController(viewModel: viewModel)
            navigationEvent.send(viewController)
        case .onboardingDemo:
            let viewControllers = (1...4).map({ _ in RandomViewController() })
            let viewController = OnboardingViewController(onboardingStages: viewControllers)
            navigationEvent.send(viewController)
        default:
            break
        }
    }
}
