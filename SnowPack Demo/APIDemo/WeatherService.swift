import SnowPack

extension API {
    static var weather = API("https://api.weatherapi.com/v1/current.json")
}

extension Endpoint {
    static func getWeather(for location: String) -> Endpoint { Endpoint(.weather, "?q=\(location)") }
}

class WeatherService {
    
    init() {
        API.weather.authenticationKeyName = "key"
        API.weather.authenticationStyle = .parameter
        API.weather.authenticationKeyValue = "get your own weather papi key"
    }
    
    func getWeather() async throws -> WeatherResponse {
        try await Networker.execute(.getWeather(for: "new york"))
    }
    
}

// MARK: Server Response Modeling

struct WeatherResponse: Codable {
    let location: WeatherLocationResponse
    let current: CurrentWeatherResponse
}

struct WeatherLocationResponse: Codable {
    let name: String
}

struct CurrentWeatherResponse: Codable {
    let temp_f: Double
    let condition: WeatherConditionResponse
}

struct WeatherConditionResponse: Codable {
    let text: String
    let icon: URL
}
