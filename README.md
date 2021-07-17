# MuseumGuide

Example project to explore structured concurrency & SwiftUI - shows a random artwork loaded from the [The Metropolitan Museum of Art API](https://metmuseum.github.io/):

<img src="https://ralfebert-assets.fra1.cdn.digitaloceanspaces.com/museum-example-xcode-f5b986f2.jpg" height="200"/>

## Endpoints / Service

I define all the endpoint logic (loading, error handling, decoding) as `async` methods in a separate type - here `await` is 🎂 super awesome to pause while the data is loading and then being able to continue with error handling and decoding without any completion handler.  

I want to stick to Swift/Foundation APIs as much as possible / don't want to introduce a dependency like Alamofire for this. But I use my very minimalistic [SweetURLRequest](https://github.com/ralfebert/SweetURLRequest) package that I have extracted from the code from numerous projects so I don't have to write the same boilerplate code again and again:

see [MetMuseumEndpoints](MuseumGuide/MetMuseumEndpoints.swift#L43)

## Error / progress handling in SwiftUI

What's important to me is to have a generic SwiftUI View to handle how it looks if something is in progress or when an error occurs.    
So I want something like [AsyncResultView](MuseumGuide/AsyncResultView.swift).

So I want to model "something is in progress" in a stateful way. I am not sure if there is a better approach with async/await as part of the game,
but so far it seems making this explicit as a type / part of the model state seems to be the right way:  
[AsyncResult](MuseumGuide/AsyncResult.swift)  
[RandomArtworkModel#L7](MuseumGuide/RandomArtworkModel.swift#L7)

## Models

The tricky part seems to be to bring these two worlds together.
With Combine I modeled the asynchronous task as a separate Model that handles the asynchronous task and knows what state it is in and I tried to adaopt this approach in the world of async/await.  

See [RandomArtworkModel#L12](MuseumGuide/RandomArtworkModel.swift#L12).   

I kept the reload method `async` so it can be used with the new `.refreshable` modifier. But I also update the state in the Model so I always know if something is in progress.

## Discussion

I am currently pondering these questions:  

* Is this great or is there a better way to structure this?  
* How can the `RandomArtworkModel#reload` method be generic? (async + MainActor seems to prevent writing this code only once and reusing it)
