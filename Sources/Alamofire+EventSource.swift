//
//  Alamofire+EventSource.swift
//  AlamofireEventSource
//
//  Created by Daniel Clelland on 7/08/20.
//

import Foundation
import Alamofire

extension Session {
    
    public func eventSourceRequest(_ convertible: URLConvertible, method: HTTPMethod = .get, headers: HTTPHeaders? = nil, lastEventID: String? = nil) -> DataStreamRequest {
        return streamRequest(convertible, headers: headers) { request in
            request.timeoutInterval = TimeInterval(Int32.max)
            request.headers.add(name: "Accept", value: "text/event-stream")
            request.headers.add(name: "Cache-Control", value: "no-cache")
            if let lastEventID = lastEventID {
                request.headers.add(name: "Last-Event-ID", value: lastEventID)
            }
        }
    }
    
}

extension DataStreamRequest {
    
    public struct EventSource {
        
        public let event: EventSourceEvent
        
        public let token: CancellationToken

        public func cancel() {
            token.cancel()
        }
        
    }
    
    public enum EventSourceEvent {
        
        case message(EventSourceMessage)
        
        case complete(Completion)
        
    }

    @discardableResult public func responseEventSource(using serializer: EventSourceSerializer = .default, on queue: DispatchQueue = .main, handler: @escaping (EventSource) -> Void) -> DataStreamRequest {
        return responseStream(using: serializer, on: queue) { stream in
            switch stream.event {
            case .stream(let result):
                for message in try result.get() {
                    handler(EventSource(event: .message(message), token: stream.token))
                }
            case .complete(let completion):
                handler(EventSource(event: .complete(completion), token: stream.token))
            }
        }
    }

}
