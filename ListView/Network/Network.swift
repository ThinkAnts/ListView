//
//  Network.swift
//  ListView
//
//  Created by Ravi on 18/09/19.
//  Copyright © 2019 ThinkAnts. All rights reserved.
//

import Foundation

struct Networking {
    
    func performNetworkTask<T: Codable>(endpoint: APIList,
                                        type: T.Type, method: String, params: Data?,
                                        completion: ((_ response: [T]) -> Void)?) {
        let urlString = endpoint.baseURL.appendingPathComponent(endpoint.path).absoluteString.removingPercentEncoding
        let session = URLSession.shared
        
        guard let urlRequest = URL(string: urlString ?? "") else { return }
        var request = URLRequest(url: urlRequest)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if method == "PUT" || method == "POST" {
            request.httpBody = params
        }
        
        let urlSession = session.dataTask(with: request) { (data, _, error) in
            if error != nil {
                return
            }
            guard let data = data else {
                return
            }
            let response = Response(data: data)
            guard let decoded = response.decode(type) else {
                return
            }
            completion?(decoded)
        }
        urlSession.resume()
    }
}
