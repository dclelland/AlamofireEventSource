//
//  DecodableEventSourceSerializer.swift
//  Alamofire
//
//  Created by Daniel Clelland on 8/08/20.
//

import Foundation
import Alamofire

public class DecodableEventSourceSerializer<T: Decodable>: DataStreamSerializer {
    
    public let decoder: DataDecoder
    
    private let serializer: EventSourceSerializer
    
    public init(decoder: DataDecoder = JSONDecoder(), delimiter: Data = EventSourceSerializer.doubleNewlineDelimiter) {
        self.decoder = decoder
        self.serializer = EventSourceSerializer(delimiter: delimiter)
    }
    
    public func serialize(_ data: Data) throws -> [DecodableEventSourceMessage<T>] {
        return try serializer.serialize(data).map { message in
            return try DecodableEventSourceMessage(
                event: message.event,
                id: message.id,
                data: message.data?.data(using: .utf8).flatMap { data in
                    return try decoder.decode(T.self, from: data)
                },
                retry: message.retry
            )
        }
    }
    
}
