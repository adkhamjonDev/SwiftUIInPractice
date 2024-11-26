//
//  SpotifyHomeView.swift
//  SwiftUIInPractice
//
//  Created by Adkhamjon Rakhimov on 25/11/24.
//

import SwiftUI
import SwiftfulUI

struct SpotifyHomeView: View {
    
    @State private var currentUser: User? = nil
    @State private var selectedCategory: SpotifyCategory? = nil
    @State private var products: [Product] = []
    @State private var productRows: [ProductRow] = []

    
    var body: some View {
        ZStack{
            
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView{
                LazyVStack(spacing: 1,pinnedViews: [.sectionHeaders]) {
                    Section {
                        
                        VStack(spacing: 16){
                            recentSection
                                .padding(.horizontal,16)
                            if let product = products.first{
                                newReleaseSection(product: product)
                                    .padding(.horizontal,16)
                            }
                            productRowSections
                            
                            
                        }
                    } header: {
                        header
                    }
                }
                .padding(.horizontal,8)
            }
            .scrollIndicators(.hidden)
            .clipped()
            
        }
        .task {
            await getData()
        }
        .toolbar(.hidden,for: .navigationBar)
    }
    private func getData() async {
        do {
            currentUser = try await DatabaseHelper().getUsers().first
            products = try await Array(DatabaseHelper().getProducts().prefix(8))
            
            var rows: [ProductRow] = []
            let allBrands = Set(products.map({$0.brand}))
            
            for brand in allBrands {
                //let products = self.products.filter( { $0.brand == brand } )
                rows.append(ProductRow(title: brand?.capitalized ?? "", products: products))
            }
            productRows = rows
            
        } catch  {
            print("\(error.localizedDescription)")
        }
    }
}

#Preview {
    SpotifyHomeView()
}

extension SpotifyHomeView{
    private var header: some View {
        HStack(spacing: 0.0){
            ZStack {
                if let user = currentUser {
                    ImageLoaderView(imageUrl: user.image)
                        
                        .background(.spotifyWhite)
                        .clipShape(.circle)
                        .onTapGesture {
                            
                        }
                }
            }
            .frame(width: 35,height: 35)
            ScrollView(.horizontal) {
                HStack(spacing: 8.0){
                    ForEach(SpotifyCategory.allCases, id: \.self) { category in
                        SpotifyCategoryCell(
                            title: category.rawValue.capitalized ,
                            isSelected: category == selectedCategory
                        )
//                        .onTapGesture {
//                            selectedCategory = category
//                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.vertical,24)
        .padding(.leading,8)
        .background(.spotifyBlack)
    }
    
    private var recentSection: some View {
        NonLazyVGrid(
            columns: 2,
            alignment: .center,
            spacing: 10,
            items: products
        )
        { product in
            if let product {
                SpotifyRecentCell(
                    imageName: product.firstImage,
                    title: product.title
                )
            }
        }
    }
    
    private func newReleaseSection(product:Product) -> some View {
            SpotifyReleaseCell(
                imageName: product.firstImage,
                headline: product.brand,
                subheadline: product.category,
                title: product.title,
                subtitle: product.description,
                onAddToPlaylistPressed: {
                    
                },
                onPlayPressed: {
                    
                }
            )
        
    }
    
    private var productRowSections: some View {
        ForEach(productRows) { row in
            VStack(spacing: 8) {
                Text(row.title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.spotifyWhite)
                    .frame(maxWidth: .infinity, alignment: .leading )
                    .padding(.horizontal,16)
                
                ScrollView(.horizontal){
                    HStack(alignment:.top,spacing: 16) {
                        ForEach(row.products){ product in
                            ImageTitleRowCell(
                                imageSize: 120,
                                imageName: product.firstImage,
                                title: product.title
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}
