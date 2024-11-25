//
//  ImageLoaderView.swift
//  SwiftUIInPractice
//
//  Created by Adkhamjon Rakhimov on 25/11/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoaderView: View {
    
    var imageUrl  = Constants.randomImage
    var resizingMode:ContentMode = .fill
    
    
    
    var body: some View {
        Rectangle()
            .opacity(0.001)
            .overlay {
                WebImage(url: URL(string: imageUrl))
                    .resizable()
                    .indicator(.activity)
                    .aspectRatio(contentMode: resizingMode)
                    .allowsHitTesting(false)
            }
            .clipped()
        
    }
}

#Preview {
    ImageLoaderView()
        .cornerRadius(30)
        .padding(40)
        .padding(.vertical,60)
    
}
