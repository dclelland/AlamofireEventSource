# AlamofireEventSource

Alamofire plugin for Server-Sent Events (SSE).

## Usage

```swift
import Alamofire
import AlamofireEventSource

let endpoint = URL(string: "http://localhost/sse")!
let request = Session.default.eventSourceRequest(endpoint, lastEventID: "0").responseEventSource { eventSource in
    switch eventSource.event {
    case .message(let message):
        print("Event source received message:", message)
    case .complete(let completion):
        print("Event source completed:", completion)
    }
}
```

## Installation

Ursus can be installed using Cocoapods by adding the following line to your podfile:

```ruby
`pod 'AlamofireEventSource', '~> 1.2'`
```

I can probably help set up Carthage or Swift Package Manager support if you need it.

## Todo list

Things that would make this codebase nicer:

- [ ] Add support for Combine publishers

## Reference

- https://developer.mozilla.org/en-US/docs/Web/API/Server-sent_events/Using_server-sent_events
- https://developer.mozilla.org/en-US/docs/Web/API/EventSource
