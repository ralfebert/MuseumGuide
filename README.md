# MuseumGuide

Example project to explore structured concurrency & SwiftUI - shows a random artwork loaded from a museum API:

<img src="https://ralfebert-assets.fra1.cdn.digitaloceanspaces.com/museum_example-ddc1397a.jpg" width="200"/>

I define all the endpoint logic (loading, error handling, decoding) as `async` methods in a separate type - here `await` is 🎂 super awesome to pause while the data is loading and then being able to continue with error handling and decoding without any completion handler:  
see [MetMuseumEndpoints](MuseumGuide/MetMuseumEndpoints.swift#L43)

What's important to me is to have a generic SwiftUI View to handle how it looks if something is in progress or when an error occurs.    
So I want something like [AsyncResultView](MuseumGuide/AsyncResultView.swift)

So I want to model "something is in progress" in a stateful way. I am not sure if there is a better approach with async/await as part of the game,
but so far it seems making this explicit as a type / part of the model state seems to be the right way:  
[AsyncResult](MuseumGuide/AsyncResult.swift)  
[RandomArtworkModel#L7](MuseumGuide/RandomArtworkModel.swift#L7)

The tricky part seems to be to bring these two worlds together.   
See [RandomArtworkModel#L12](MuseumGuide/RandomArtworkModel.swift#L12).   
I want this to be async as well so it can be used with the new `.refreshable` modifier.   
But I also want to update the state in the Model so I always know if something is in progress.

I am currently pondering these questions:  

* Is this great or is there a better way to structure this?  
* How can the `RandomArtworkModel#reload` method be generic? (async + MainActor seems to prevent writing this code only once and reusing it)
