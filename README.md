# MuseumGuide

Example project to explore structured concurrency & SwiftUI - shows a random artwork loaded from the [The Metropolitan Museum of Art API](https://metmuseum.github.io/):

<img src="https://ralfebert-assets.fra1.cdn.digitaloceanspaces.com/museum-example-xcode-f5b986f2.jpg" height="200"/>

## Endpoints / Service

I define all the endpoint logic (urls, encoding the request, error handling, decoding the response) as `async` methods in a separate type - here `await` is 🎂 super awesome to pause while the data is loading and then being able to continue with error handling and decoding without dancing around with completion handlers.  

I want to stick to Swift/Foundation APIs as much as possible / don't want to introduce a dependency like Alamofire for this. But I use my very minimalistic [SweetURLRequest](https://github.com/ralfebert/SweetURLRequest) package that I have extracted from numerous projects so I don't have to write the same boilerplate code again and again:

see [MetMuseumEndpoints](MuseumGuide/MetMuseumEndpoints.swift#L43)

## Error / progress handling in SwiftUI

What's important to me is to have a generic SwiftUI View to handle how it looks if something is in progress or when an error occurs.    
So I want something like [AsyncResultView](MuseumGuide/AsyncResultView.swift).

This requirement implies that I want to represent "something is in progress" in a stateful way. I am not sure if there is a better approach with async/await as part of the game, but so far it seems making this explicit as a generic type (instead of having additional flags like isInProgress) / part of the model state seems to be the way to go:  
[AsyncResult](MuseumGuide/AsyncResult.swift)  
[RandomArtworkModel#L7](MuseumGuide/RandomArtworkModel.swift#L7)

## Models

The tricky part seems to be to bring these two worlds together.
When using Combine, I model the asynchronous task in a separate Model that handles the asynchronous task and knows what state it is in. I adopted this approach for async/await, see [RandomArtworkModel#L12](MuseumGuide/RandomArtworkModel.swift#L12).   

I kept the reload method `async` so it can be used with the new `.refreshable` modifier. But I also update the state in the Model so I always know if something is in progress.

## Open Questions

I am currently pondering these questions:  

* Is this great or is there a better way to structure this?  
* SwiftUI's `.refreshable` modifier implies a different structure where the View itself knows the state of the async task and visualizes it. This is very different than usual. Is this a good idea / does it blend well with async in the model layer?
* If the data is already loaded and you reload it, you can either set it to inProgress (with the app not showing the previous result anymore) or keep the current value and update it when finished. What's currently not possible to represent is "show the previous result AND show that it's loading"
* How can the `RandomArtworkModel#reload` method be generic? (async + MainActor seems to prevent writing this code only once and reusing it)
