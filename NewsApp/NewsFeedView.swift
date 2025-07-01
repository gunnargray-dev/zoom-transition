import SwiftUI

// MARK: - Constants
struct Constants {
    static let borderOffsetPlus = Color.white.opacity(0.1)
}

struct NewsFeedView: View {
    // MARK: - Properties
    @State private var articles = NewsArticle.sampleArticles
    @Namespace private var transitionNamespace

    private let columns = [
        GridItem(.flexible(), spacing: 0)
    ]

    // MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "191a1a").ignoresSafeArea()

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(articles) { article in
                            NavigationLink {
                                NewsDetailView(article: article)
                                    .navigationTransition(.zoom(sourceID: article.id, in: transitionNamespace))
                            } label: {
                                NewsCardView(article: article)
                                    .matchedTransitionSource(id: article.id, in: transitionNamespace)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                }
            }
        }
        .navigationTitle("News Feed")
        .navigationBarTitleDisplayMode(.large)
        .preferredColorScheme(.dark)
    }
}

// MARK: - News Card View
struct NewsCardView: View {
    // MARK: - Properties
    let article: NewsArticle

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Responsive Image
            AsyncImage(url: URL(string: article.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
            } placeholder: {
                Rectangle()
                    .fill(article.accentColor.opacity(0.3))
                    .frame(height: 200)
                    .overlay(
                        ProgressView()
                            .tint(.white)
                    )
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, 12)
            .padding(.top, 12)
            
            // Content area with fixed height to prevent jumping
            VStack(alignment: .leading, spacing: 12) {
                // Title
                Text(article.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // Bottom row with sources and icons
                HStack {
                    HStack(spacing: 4) {
                        // Source indicator circles
                        HStack(spacing: -4) {
                            Circle()
                                .fill(Color.white.opacity(0.4))
                                .frame(width: 16, height: 16)
                            Circle()
                                .fill(Color.white.opacity(0.4))
                                .frame(width: 16, height: 16)
                            Circle()
                                .fill(Color.white.opacity(0.4))
                                .frame(width: 16, height: 16)
                        }
                        
                        Text("13 sources")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    
                    Spacer()
                    
                    // Action icons
                    HStack(spacing: 16) {
                        Image(systemName: "heart")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                        
                        Image(systemName: "ellipsis")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .frame(height: 100, alignment: .top)
        }
        .background(
            LinearGradient(
                stops: [
                    Gradient.Stop(color: article.accentColor.opacity(0), location: 0.00),
                    Gradient.Stop(color: article.accentColor, location: 1.00),
                ],
                startPoint: UnitPoint(x: 0.5, y: 0.4),
                endPoint: UnitPoint(x: 0.02, y: 0.01)
            )
        )
        .background(Color(red: 0.14, green: 0.15, blue: 0.15))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .inset(by: 0.5)
                .stroke(Constants.borderOffsetPlus, lineWidth: 1)
        )
    }
}

#Preview {
    NewsFeedView()
}
