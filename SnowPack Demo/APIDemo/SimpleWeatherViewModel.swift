import SnowPack

final class SimpleWeatherViewModel: ViewModel {
    
    let weatherService = WeatherService() //ideally dependency injected
    
    var weatherData: WeatherResponse? {
        didSet { refreshEvent.send() }
    }
    
    override init() {
        super.init()
        
        Task {
            await fetchWeather()
        }
    }
    
    func fetchWeather() async {
        guard let weather = try? await weatherService.getWeather() else { return }
        weatherData = weather
    }
    
}
