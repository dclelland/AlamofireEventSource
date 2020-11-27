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
    
}
