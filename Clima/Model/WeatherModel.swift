//
import Foundation

struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temperature: Double
    
    var conditionName: String {
        return getConditionName(weatherID: conditionID)
    }
    
    var weatherName: String {
        return getWeatherName(weatherID: conditionID)
    }
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    func getConditionName(weatherID: Int) -> String {
        switch weatherID {
            case 200...232:
                return "cloud.bolt"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 701...781:
                return "cloud.fog"
            case 800:
                return "sun.max"
            case 801...804:
                return "cloud"
            default:
                return "cloud"
        }
    }
    
    func getWeatherName(weatherID: Int) -> String {
        switch weatherID {
        case 200...232:
            return "Thunderstorm"
        case 300...321:
            return "Drizzle"
        case 500...531:
            return "Rainy"
        case 600...622:
            return "Snowy"
        case 701...781:
            return "Foggy"
        case 800:
            return "Sunny"
        case 801...804:
            return "Cloudy"
        default:
            return "Cloudy"
        }
    }
}
