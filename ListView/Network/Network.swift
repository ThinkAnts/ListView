//
//  Network.swift
//  ListView
//
//  Created by Ravi on 18/09/19.
//  Copyright © 2019 ThinkAnts. All rights reserved.
//

import Foundation

struct Networking {

    let session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    func performNetworkTask<T: Codable>(endpoint: APIList,
                                        type: T.Type, method: String, params: Data?,
                                        completion: ((_ response: Result<T, DataResponseError>) -> Void)?) {
        let urlRequest = URLRequest(url: endpoint.baseURL.appendingPathComponent(endpoint.path))
        let encodedURLRequest = urlRequest.encode(with: endpoint.paramters)
        
        let urlSession = session.dataTask(with: encodedURLRequest, completionHandler: { data, response, error in
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.hasSuccessStatusCode,
                let data = data
                else {
                    completion?(Result.failure(DataResponseError.network))
                    return
            }

            let response = Response(data: data)
            guard let decoded = response.decode(type) else {
                completion?(Result.failure(DataResponseError.decoding))
                return
            }
            completion?(Result.success(decoded))
        })
        urlSession.resume()
    }
}
