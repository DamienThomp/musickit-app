# MuzakKit - SwiftUI App with MusicKit Integration

MuzakKit is a SwiftUI-based iOS demo app that integrates with Apple Music through the MusicKit framework. The app allows users to explore music recommendations, search the Apple Music catalog or their personal library. It also provides detailed pages for albums, artists, and playlists, as well as the ability to play music if the user has an active Apple Music subscription.

- App design is a simplified version of the Apple Music App. 
- This demo app is a work in progress, code refactor passes will happen and features will be added or improved:
  - ~~Music player improvements with animation and layout.~~ ✅
  - ~~Add more error handling (view container for loading state)~~ ✅
  - Improved playlist features: editing and creating.
  - General code cleanup.
  - Fix mocked data for SwiftUI previews.
- This app was built to experiment with SwiftUI features by building a complete app that connects to a framework (in this case MusicKit).
- This app loosely followed the [MV pattern](https://azamsharp.com/2022/08/09/intro-to-mv-state-pattern.html) for state management.

## Features

- **Browse Page**: Display music recommendations from Apple Music based on the user's preferences.
- **Search Page**: Search the Apple Music catalog or user's personal library (Playlists, Albums, Artists, Genres).
- **Library Page**: View saved music content such as:
  - Playlists
  - Albums
  - Artists
  - Genres
- **Detail Pages**:
  - Album details with track listing
  - Artist details with discography
  - Playlist details with track listing
- **Music Playback**: Play music directly from the Apple Music catalog if the user has an active subscription.
  
## Prerequisites

- **Apple Developer Account**: Required for using MusicKit and accessing the Apple Music API.
- **Apple Music Subscription**: Required to play music and access full playback features.
- **Xcode 15+**: The app is built with SwiftUI with a minimum build target of iOS 17 and requires Xcode 15 or later for building and running.

## Features in Detail

### Browse Page
- Fetches and displays curated music recommendations from Apple Music, allowing users to discover new tracks, albums, and playlists based on their tastes.

### Search Page
- Users can search the Apple Music catalog for music or search their own library for saved content.
- Music results display cover art, titles, and allow users to quickly navigate to albums, artists, or playlists.

### Library Page
- Shows a categorized view of the user's saved content in Apple Music.
  - **Playlists**: A list of user-created or saved playlists.
  - **Albums**: A list of albums the user has added to their library.
  - **Artists**: A list of artists the user follows or has saved.
  - **Genres**: A list of music genres saved by the user.

### Detail Pages
- Each item (album, artist, or playlist) has a dedicated detail page showing more information, such as track lists for albums and playlists, or discographies for artists.
  
### Music Playback
- If the user has an Apple Music subscription, they can play full tracks from the Apple Music catalog directly in the app.
- The app supports basic playback features like play, pause, skip, and volume control.
  
## Libraries & Frameworks Used

- **MusicKit**: To interact with the Apple Music API for fetching catalog data and enabling music playback.
- **SwiftUI**: For building the app’s user interface with a declarative, component-based approach.
  
## Screenshots

### Music Player

https://github.com/user-attachments/assets/3735263d-794a-4bb9-84ba-a9f48b6913fd

### Artist Page

https://github.com/user-attachments/assets/5fa56c01-849c-496f-92af-62f53f6eda37

### Browse Page
<img width="250" src="https://github.com/user-attachments/assets/63004fae-ad5f-482a-8454-82b1c6ee7da8">

### Search Page
<img width="250" src="https://github.com/user-attachments/assets/9eaf9dea-5f6c-44d5-9ac4-afcfd914011d">

### Library Page
<img width="250" src="https://github.com/user-attachments/assets/7c557bcc-3e14-4fd0-ae7d-a3bc711af8a1">

### Album Detail Page
<img width="250" src="https://github.com/user-attachments/assets/e80dca43-7a7a-4134-86a8-834ef674e813">

## Acknowledgements

- Thanks to the [MusicKit Documentation](https://developer.apple.com/documentation/musickit) for the API references and guides.
