//
//  EventSourceSerializer.swift
//  AlamofireEventSource
//
//  Created by Daniel Clelland on 7/08/20.
//

import Foundation
import Alamofire

public class EventSourceSerializer: DataStreamSerializer {
    
    public static let `default` = EventSourceSerializer(delimiter: "\n\n".data(using: .utf8)!)
    
    public let delimiter: Data
    
    public var buffer = Data()
    
    public init(delimiter: Data) {
        self.delimiter = delimiter
    }
    
    public func serialize(_ data: Data) throws -> [EventSourceMessage] {
        buffer.append(data)
        return extractMessagesFromBuffer().compactMap(EventSourceMessage.init(parsing:))
    }

    private func extractMessagesFromBuffer() -> [String] {
        var messages = [String]()
        var searchRange: Range<Data.Index> = buffer.startIndex..<buffer.endIndex
        
        while let delimiterRange = buffer.range(of: delimiter, in: searchRange) {
            let subdata = buffer.subdata(in: searchRange.startIndex..<delimiterRange.endIndex)

            if let message = String(bytes: subdata, encoding: .utf8) {
                messages.append(message)
            }

            searchRange = delimiterRange.endIndex..<buffer.endIndex
        }

        buffer.removeSubrange(buffer.startIndex..<searchRange.startIndex)

        return messages
    }
    
}
