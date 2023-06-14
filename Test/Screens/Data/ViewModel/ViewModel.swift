//
//  ViewModel.swift
//  Test
//
//  Created by Deepak on 11/06/23.
//

import UIKit
import Foundation

class ViewModel: NSObject {

    var weatherServiceObj = WeatherService()
    
    func getWeatherInfo(dict:[String:String],completion: @escaping (Bool, WeatherInfoViewModel?, String?) -> ()){
        
        weatherServiceObj.getWeatherData(params: dict, completion: { success, model, error in
            
            if success, let data = model{
                let weatherInfoViewModel = self.createWeatherInfoViewModel(record: data)
                completion(true,weatherInfoViewModel,nil)
            }else{
                print(error!)
                completion(false,nil,error)
            }
        })
    }
    
    func createWeatherInfoViewModel(record:Record) -> WeatherInfoViewModel{
        
        let locationNameVal = "Weather for " + record.name + ", " + record.sys.country
        let img_url = self.getImageUrl(iconId: record.weather[0].id)
        let temp = String(record.main.temp) + "° C"
        let feels_like = String(record.main.feelsLike) + "° C"
        let temp_min = String(record.main.tempMin) + "° C"
        let temp_max = String(record.main.tempMax) + "° C"
        let pressure = String(record.main.pressure) + "hPa"
        let humidity = String(record.main.humidity) + "%"
        let visibility = String(record.visibility/1000) + "km"
        let windSpeed = String(record.wind.speed) + "m/s"
        
        
        return WeatherInfoViewModel(lat: record.coord.lat, long: record.coord.lon, locationName: locationNameVal, description: record.weather[0].description, img_url: self.getImageUrl(iconId: record.weather[0].id), temp: temp, feels_like: feels_like, temp_min: temp_min, temp_max: temp_max, pressure: pressure, humidity: humidity, visibility: visibility, windSpeed: windSpeed)
    }
    
    
    func getImageUrl(iconId:Int) -> String{
        
        var imgUrl = ""
        
        switch iconId{
            
         case 200,201,202,210,211,212,221,230,231,232:
           imgUrl = "https://openweathermap.org/img/wn/11d@2x.png"
           break
         case 300,301,302,310,311,312,313,314,321,520,521,522,531:
           imgUrl = "https://openweathermap.org/img/wn/09d@2x.png"
           break
         case 500,501,502,503,504:
           imgUrl = "https://openweathermap.org/img/wn/10d@2x.png"
           break
         case 511,600,601,602,611,612,613,615,616,620,621,622:
           imgUrl = "https://openweathermap.org/img/wn/13d@2x.png"
           break
         case 701,711,721,731,741,751,761,762,771,781:
           imgUrl = "https://openweathermap.org/img/wn/50d@2x.png"
           break
         case 800:
           imgUrl = "https://openweathermap.org/img/wn/01d@2x.png"
           break
         case 801:
           imgUrl = "https://openweathermap.org/img/wn/02d@2x.png"
           break
         case 802:
           imgUrl = "https://openweathermap.org/img/wn/03d@2x.png"
           break
         case 803,804:
           imgUrl = "https://openweathermap.org/img/wn/04d@2x.png"
           break
         default:
           break
        }
        return imgUrl
    }
    

    
}
