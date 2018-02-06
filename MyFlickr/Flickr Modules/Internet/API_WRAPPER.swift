//
//  API_WRAPPER.swift
//  MyFlickr
//
//  Created by Александр Чернов on 02.01.2018.
//  Copyright © 2018 Александр Чернов. All rights reserved.
//

import UIKit

class API_WRAPPER {
    
    // данные картинок
    class func getRawData ( complection: @escaping (JSON) -> Void ) {
        let urlString = "https://www.flickr.com/services/rest?method=flickr.interestingness.getList&api_key=3988023e15f45c8d4ef5590261b1dc53&per_page=20&page=1&format=json&nojsoncallback=1"
        /* oбъект класса URL - передаем строчку */
        let url = URL(string: urlString)!
        /* конструируем запрос в интернет - объект URLRequest */
        let request = URLRequest(url: url)
        /* отправляем запрос в интернет 1 стадия - получаем объект URLSessionDataTask */
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if data != nil {
                // let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                //print(responseString)
                let jsonResponse = JSON(data!)
                //print(jsonResponse)
                complection(jsonResponse)
            }
        }
        
        /* отправляем запрос в интернет 2 стадия - у объекта URLSessionDataTask вызываем процедуру resume */
        task.resume()
    }
}

