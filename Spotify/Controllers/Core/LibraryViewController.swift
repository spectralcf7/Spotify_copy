//
//  LibraryViewController.swift
//  Spotify
//
//  Created by Mihnea Amihailesei on 23.04.2024.
//

import UIKit

class LibraryViewController: UIViewController {
    
    private let playlistsVC = LibraryPlaylistsViewController()
    private let albumsVC = LibraryAlbumsViewController()
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    private let toggleView = LibraryToggleView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        scrollView.delegate = self
        view.addSubview(scrollView)
        view.addSubview(toggleView)
        toggleView.delegate = self
        scrollView.contentSize = CGSize(width: view.width * 2, height: scrollView.height)
        addChildren()
        updateBarButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = CGRect(x: 0, y: view.safeAreaInsets.top + 55, width: view.width, height: view.height - view.safeAreaInsets.top - additionalSafeAreaInsets.bottom - 55)
        toggleView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: 200, height: 55)
    }
    
    private func updateBarButtons() {
        switch toggleView.state {
        case .playlist:
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        case .album:
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    @objc private func didTapAdd() {
        playlistsVC.showCreatePlaylistAlert()
    }
    
    private func addChildren() {
        addChild(playlistsVC)
        
        // Add playlistsVC's view into the scroll view
        scrollView.addSubview(playlistsVC.view)
        
        // Set its frame
        playlistsVC.view.frame = CGRect(x: 0, y: 0, width: scrollView.width, height: scrollView.height)
        
        playlistsVC.didMove(toParent: self)
        
        addChild(albumsVC)
        
        // Add albumsVC's view into the scroll view
        scrollView.addSubview(albumsVC.view)
        
        // Set its frame
        albumsVC.view.frame = CGRect(x: view.width, y: 0, width: scrollView.width, height: scrollView.height)
        
        albumsVC.didMove(toParent: self)
    }
}

extension LibraryViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x >= view.width - 100 {
            toggleView.update(for: .album)
            updateBarButtons()
        }
        else {
            toggleView.update(for: .playlist)
            updateBarButtons()
        }
    }
}

extension LibraryViewController: LibraryToggleViewDelegate {
    func libraryToggleViewDidTapPlaylists(_ toggleView: LibraryToggleView) {
        scrollView.setContentOffset(.zero, animated: true)
        updateBarButtons()
    }
    
    func libraryToggleViewDidTapAlbums(_ toggleView: LibraryToggleView) {
        scrollView.setContentOffset(CGPoint(x: view.width, y: 0), animated: true)
        updateBarButtons()
    }
}

