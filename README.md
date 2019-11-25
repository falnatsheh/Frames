## Demo
[![Demo](https://i.imgur.com/U1iwR0F.png)](https://vimeo.com/375491031)

https://vimeo.com/375491031

## Details

- From the UI perspective, I used Instagram app as an inspiration. Videos will auto-pay as soon as the user scroll to them and when clicked they will be presented in a new VC (similar to how Instagram transition a video post to IGTV full screen). When the user enters the full-screen view they will be able to pause/play the video and swipe right/left to view other videos.

- The app built using a simple MVC architecture. It contains two VCs, one that displays video posts (`MainViewController`) and another that displays videos in full screen (`PlayerViewController`). Storage, API Client, Views and Models are all separated into their own components/classes. 

- The tricky part of working with videos in a UICollectionView is AVPlayer cell recycling. My strategy in this app is to load videos when they're visible to the user and remove them when they're not (more precisely when `prepareForReuse` is called). 

- The app uses [Coverr](https://coverr.co/) APIs (It's similar to unsplash.com but for videos) to get video posts/links.

Note: `MainViewController.playVisibleCellVideo()` can be called multiple times on the same video when the user scroll. However, only one call will result in creating an AVPlayer,  other requests will be ignored (See also `VideoPlayerView.play(url:)` for more details).

## Suggestions on how to improve / expand the features of this app
- Since it’s a simple example app I used MVC. If you would like me to update the sample app to MVVM architecture and add unit/UI test please let me know (that would be my default setup for a large project). 

-  AVPlayers handling could be moved to a separate manager class. This would provide a smoother transition when animating the player between different views.

- Offline handling.

- Update CoreData and introduce reactive framework to the app (Rx/Combine Swift) to automatically update UI state.
