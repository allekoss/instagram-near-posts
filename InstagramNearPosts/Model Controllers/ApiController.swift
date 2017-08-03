//
//  ApiController.swift
//  InstagramNearPosts
//
//  Created by Alejandro Jimenez Lopez on 8/1/17.
//  Copyright © 2017 allekoss. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

// MARK: - ApiController

class ApiController {
    
    fileprivate let accessToken: String
    
    enum Result<T> {
        case tokenExpired
        case failure(Error)
        case success(T)
    }
    
    struct CircularArea {
        let lat: Double
        let lng: Double
        let distance: Int
    }
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    func loadUser(completion: @escaping (Result<User>) -> Void) {
        Alamofire.request(ApiRouter.user(accessToken: accessToken))
            .validate()
            .responseObject(keyPath: "data") { [unowned self] (response: DataResponse<User>) in
                
                self.handleResponse(response: response, completion: completion)
        }
    }
    
    func loadPosts(searchArea: CircularArea, completion: @escaping (Result<[Post]>) -> Void) {
        Alamofire.request(ApiRouter.nearMedia(accessToken: accessToken, lat: searchArea.lat, lng: searchArea.lng, distance: searchArea.distance))
            .validate()
            .responseArray(keyPath: "data") { [unowned self] (response: DataResponse<[Post]>) in
                
                self.handleResponse(response: response, completion: completion)
        }
    }
    
    fileprivate func handleResponse<T>(response: DataResponse<T>, completion: @escaping (Result<T>) -> Void) {
        switch response.result {
        case .success(let value):
            completion(Result.success(value))
        case .failure(let error):
            if let statusCode = response.response?.statusCode, statusCode == 400 {
                completion(Result.tokenExpired)
            }
            else {
                completion(Result.failure(error))
            }
        }
    }
    
}

// MARK: - ApiRouter

public enum ApiRouter: URLRequestConvertible {
    fileprivate static let baseURL = URL(string: "https://api.instagram.com/v1")!
    
    case user(accessToken: String)
    case nearMedia(accessToken: String, lat: Double, lng: Double, distance: Int)
    
    var method: HTTPMethod {
        switch self {
        case .user, .nearMedia:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .user:
            return "/users/self"
        case .nearMedia:
            return "/media/search"
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let parameters: [String: Any] = {
            switch self {
            case .user(let accessToken):
                return ["access_token": accessToken]
            case let .nearMedia(accessToken, lat, lng, distance):
                return ["access_token": accessToken, "lat": lat, "lng": lng, "distance": distance]
            }
        }()
        
        var request = URLRequest(url: ApiRouter.baseURL.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(10 * 1000)
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
}

