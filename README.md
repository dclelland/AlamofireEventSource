# AlamofireEventSource

Alamofire plugin for Server-Sent Events (SSE)

Cocoapods: `pod 'AlamofireEventSource', '~> 0.1.0'`

```swift
import Alamofire
import AlamofireEventSource

let endpoint = URL(string: "http://localhost/sse")!
let session = Session.default
let request = session.eventSourceRequest(endpoint, lastEventID: "0").responseEventSource { eventSource in
    switch eventSource.event {
    case .message(let message):
        print("Event source received message:", message)
    case .complete(let completion):
        print("Event source completed:", completion)
    }
}
```