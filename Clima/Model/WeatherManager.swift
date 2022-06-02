import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = K.weatherApiKey
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(from: urlString)
    }
        
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(from: urlString)
    }
    
    func performRequest(from urlString: String) {
        //1. Create a URL
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            let urlSession = URLSession(configuration: .default)
            
            //3. Give the session a task
            let urlTask = urlSession.dataTask(with: url, completionHandler: handleMethod)
            
            //4. Start the task
            urlTask.resume()
        }
    }
    
    func handleMethod(data: Data?, response: URLResponse?, error: Error?) -> Void {
        if error != nil {
            delegate?.didFailWithError(error: error!)
            
            return
        }
        
        if let safeData = data {
            if let weather = parseJson(safeData) {
                delegate?.didUpdateWeather(self, weather: weather)
            }
        }
    }
    
    func parseJson(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            
            return nil
        }
    }
}
