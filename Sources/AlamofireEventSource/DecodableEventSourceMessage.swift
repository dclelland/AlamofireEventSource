//
//  DecodableEventSourceMessage.swift
//  Alamofire
//
//  Created by Daniel Clelland on 8/08/20.
//

import Foundation

public struct DecodableEventSourceMessage<T: Decodable> {
    
    public var event: String?
    public var id: String?
    public var data: T?
    public var retry: String?
    
    public init(event: String? = nil, id: String? = nil, data: T? = nil, retry: String? = nil) {
        self.event = event
        self.id = id
        self.data = data
        self.retry = retry
    }
}
