//
//  SearchResult.swift
//  Spotify
//
//  Created by Mihnea Amihailesei on 18.05.2024.
//

import Foundation

enum SearchResult {
    case artist(model: Artist)
    case album(model: Album)
    case track(model: AudioTrack)
    case playlist(model: Playlist)
}
