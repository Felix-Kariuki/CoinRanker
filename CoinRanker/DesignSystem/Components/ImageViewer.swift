//
//  ImageViewe.swift
//  CoinRanker
//
//  Created by Felix kariuki on 25/06/2025.
//

import SwiftUI

struct CircularImageView: View {
    var url: String? = ""
    var size: CGSize = CGSize(width: 50, height: 50)
    var placeholderImage: Image = Image("placeholder")
        .resizable()
    
    var body: some View {
        Group {
                ImageViewer(
                    url: cleanUpUrl(from: url ?? ""),
                    size: size,
                    cornerRadius: 50,
                    placeholderImage: placeholderImage
                )
        }
    }
}


struct ImageViewer<Content: View, Placeholder: View>: View {

    private let url: String?
    private let contentMode: ContentMode
    private let size: CGSize
    private let cornerRadius: CGFloat
    private let placeholderImage: Image
    private let content: (Image) -> Content
    private let placeholder: () -> Placeholder
    
    
    @State private var isLoading: Bool = true
    @State private var loadedImage: UIImage? = nil
    @State private var loadError: Bool = false
    

    init(
        url: String?,
        contentMode: ContentMode = .fill,
        size: CGSize,
        cornerRadius: CGFloat = 0,
        placeholderImage: Image = Image(systemName: "photo"),
        @ViewBuilder content: @escaping (Image) -> Content,
        @ViewBuilder placeholder: @escaping () -> Placeholder
    ) {
        self.url = url
        self.contentMode = contentMode
        self.size = size
        self.cornerRadius = cornerRadius
        self.placeholderImage = placeholderImage
        self.content = content
        self.placeholder = placeholder
    }
    
    var body: some View {
        ZStack {
            if isLoading {
         
                ShimmerView()
                    .frame(width: size.width, height: size.height)
                    .cornerRadius(cornerRadius)
            } else if loadError || loadedImage == nil {

                placeholder()
                    .frame(width: size.width, height: size.height).cornerRadius(cornerRadius)
            } else if let image = loadedImage {

                content(Image(uiImage: image))
                    .frame(width: size.width, height: size.height)
                    .cornerRadius(cornerRadius)
            }
        }
        .frame(width: size.width, height: size.height)
        .onAppear {
            loadImage()
        }
        .onChange(of: url) {
            resetAndLoadImage()
        }
    }
    

    private func resetAndLoadImage() {
        isLoading = true
        loadError = false
        loadedImage = nil
        loadImage()
    }
    
    private func loadImage() {
        guard let urlString = url, let url = URL(string: urlString) else {
            isLoading = false
            loadError = true
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
                
                if let error = error {
                    print("Error loading image: \(error.localizedDescription)")
                    loadError = true
                    return
                }
                
                guard let data = data, let image = UIImage(data: data) else {
                    loadError = true
                    return
                }
                
                loadedImage = image
            }
        }.resume()
    }
}


extension ImageViewer where Content == AnyView, Placeholder == AnyView {
    init(
        url: String?,
        contentMode: ContentMode = .fill,
        size: CGSize,
        cornerRadius: CGFloat = 0,
        placeholderImage: Image = Image(systemName: "photo")
    ) {
        self.init(
            url: url,
            contentMode: contentMode,
            size: size,
            cornerRadius: cornerRadius,
            placeholderImage: placeholderImage,
            content: { image in AnyView(image.resizable().aspectRatio(contentMode: contentMode)) },
            placeholder: { AnyView(placeholderImage.resizable().aspectRatio(contentMode: contentMode)) }
        )
    }
}

// MARK: - Shimmer Effect View
struct ShimmerView: View {
    @State private var shimmering = false
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1)
            
            Color.white.opacity(0.1)
                .mask(
                    Rectangle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.clear, Color.white.opacity(0.5), Color.clear]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .rotationEffect(.degrees(70))
                        .offset(x: shimmering ? 400 : -400)
                )
        }
        .onAppear {
            withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                shimmering = true
            }
        }
    }
}

func cleanUpUrl(from urlString: String) -> String {
    if urlString.hasSuffix(".svg") {
        return urlString.replacingOccurrences(of: ".svg", with: ".png")
    }
    return urlString
}


#Preview {
    VStack(spacing: 20) {
        
        // wrong url
        CircularImageView(url: "https://picsum.,,photos/300")
        
        // svg
        CircularImageView(url: "https://cdn.coinranking.com/bOabBYkcX/bitcoin_btc.svg")
        
        // png
        CircularImageView(url: "https://cdn.coinranking.com/pgJ21zFKK/WBT_250x250px.png")
    
        

        ImageViewer(
            url: "https://picsum.photos/200",
            size: CGSize(width: 200, height: 200),
            cornerRadius: 10
        )
        
        // Circle image with custom placeholder
        ImageViewer(
            url: "https://picsum.photos/300",
            size: CGSize(width: 100, height: 100),
            cornerRadius: 50,
            placeholderImage: Image(systemName: "person.fill")
        )
        
        // Custom configuration
        ImageViewer<AnyView, AnyView>(
            url: "https://example.com/invalid-url",
            contentMode: .fit,
            size: CGSize(width: 150, height: 150),
            cornerRadius: 20,
            content: { image in
                AnyView(
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0.8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.blue, lineWidth: 3)
                        )
                )
            },
            placeholder: {
                AnyView(
                    Image(systemName: "exclamationmark.triangle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(30)
                        .foregroundColor(.orange)
                )
            }
        )
        
    }
    .padding()
}
