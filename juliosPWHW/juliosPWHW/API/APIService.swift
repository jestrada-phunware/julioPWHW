//
//  APIService.swift
//  juliosPWHW
//
//  Created by Julio Estrada on 6/15/18.
//  Copyright © 2018 Julio Estrada. All rights reserved.
//

import Foundation

class APIService {
    static let shared = APIService()

    let baseUrl = "https://raw.githubusercontent.com/phunware-services/dev-interview-homework/master/feed.json"
    func fetchEvents(_ completion: @escaping (_ result: [Event]) -> ()) {
        let url = URL(string: baseUrl)!
        let request = URLRequest(url: url)
        let session: URLSession = {
            let config = URLSessionConfiguration.default
            return URLSession(configuration: config)
        }()

        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: ", error)
                return
            }
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let events = try decoder.decode([Event].self, from: data)

                completion(events)
            } catch let decodeError {
                print("Decoding error is: ", decodeError)
            }

        }
        task.resume()
    }
}


