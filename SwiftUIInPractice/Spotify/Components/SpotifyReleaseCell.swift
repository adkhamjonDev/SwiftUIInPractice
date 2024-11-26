//
//  SpotifyReleaseCell.swift
//  SwiftUIInPractice
//
//  Created by Adkhamjon Rakhimov on 26/11/24.
//

import SwiftUI

struct SpotifyReleaseCell: View {
    
    var imageName: String = Constants.randomImage
    var headline: String? = "New release from"
    var subheadline: String? = "Some playlist"
    var title: String? = "Title"
    var subtitle: String? = "Single - title"
    var onAddToPlaylistPressed: (() -> Void)? = nil
    var onPlayPressed: (() -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 8) {
                ImageLoaderView(imageUrl: imageName)
                    .frame(width: 50,height: 50)
                    .clipShape(Circle())
                
                VStack(spacing: 2) {
                    if let headline {
                        Text(headline)
                            .foregroundStyle(.spotifylightGray)
                            .font(.callout)
                    }
                    if let subheadline {
                        Text(subheadline)
                            .foregroundStyle(.spotifyWhite)
                            .font(.title2)
                            .fontWeight(.medium)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack{
                ImageLoaderView(imageUrl: imageName)
                    .frame(width: 140,height: 140)
                
                VStack(alignment: .leading,spacing: 32) {
                    VStack(alignment: .leading,spacing: 2) {
                        if let title {
                            Text(title)
                                .fontWeight(.semibold)
                                .foregroundStyle(.spotifyWhite)
                        }
                        if let subtitle {
                            Text(subtitle)
                                .font(.callout)
                                .foregroundStyle(.spotifylightGray)
                                .lineLimit(1)
                        }
                    }
                    .font(.callout)
                    
                    HStack(spacing: 0){
                        Image(systemName: "plus.circle")
                            .foregroundStyle(.spotifylightGray)
                            .font(.title3)
                            .padding(4)
                            .onTapGesture {
                                onAddToPlaylistPressed?()
                            }
                            .offset(x: -4)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                        Image(systemName: "play.circle.fill")
                            .foregroundStyle(.spotifylightGray)
                            .font(.title)
                            .onTapGesture {
                                
                            }
                    }
                }
                .padding(.trailing, 16)

            }
            .themeColors(isSelected: false)
            .cornerRadius(8)
            .onTapGesture {
                onPlayPressed?()
            }
            
        }
        
        
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        SpotifyReleaseCell(onAddToPlaylistPressed: {
            
        })
            .padding()
    }
}
