import SwiftUI

struct NewsDetailView: View {
    // MARK: - Properties
    let article: NewsArticle
    let imageTransition: Namespace.ID
    @Environment(\.dismiss) private var dismiss

    // MARK: - Body
    var body: some View {
        ZStack {
            Color(hex: "191a1a").ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // Title and Metadata Section
                    VStack(alignment: .leading, spacing: 16) {
                        // Title
                        Text(article.title)
                            .font(.system(size: 28, weight: .regular, design: .serif))
                            .lineLimit(nil)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                        
                        // Source and timestamp
                        HStack(spacing: 8) {
                            // Source icons (placeholder)
                            HStack(spacing: -4) {
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 16, height: 16)
                                Circle()
                                    .fill(Color.green)
                                    .frame(width: 16, height: 16)
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 16, height: 16)
                            }
                            
                            Text("12 Sources")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.white.opacity(0.9))
                            
                            Spacer()
                            
                            HStack(spacing: 4) {
                                Image(systemName: "clock")
                                    .font(.system(size: 12))
                                    .foregroundColor(.white.opacity(0.7))
                                
                                Text("Published 1 hr ago")
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(.white.opacity(0.9))
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 74) // 50px for status bar + 24px spacing to toolbar
                    
                    // Shared Article Image with matched transition
                    VStack(alignment: .leading, spacing: 16) {
                        AsyncImage(url: URL(string: article.imageUrl)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 240)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .clipped()
                                .matchedTransitionDestination(id: article.id, in: imageTransition)
                        } placeholder: {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(hex: article.category.color).opacity(0.6))
                                .frame(height: 240)
                                .overlay(
                                    ProgressView()
                                        .tint(.white)
                                )
                                .matchedTransitionDestination(id: article.id, in: imageTransition)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 24)

                    // Content Section
                    VStack(alignment: .leading, spacing: 20) {
                        // Summary Section
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Summary")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(.white)
                                
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(.white.opacity(0.6))
                                
                                Spacer()
                            }
                            
                            VStack(alignment: .leading, spacing: 12) {
                                HStack(alignment: .top, spacing: 8) {
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 4, height: 4)
                                        .padding(.top, 8)
                                    
                                    Text(article.summary)
                                        .font(.system(size: 15, weight: .regular))
                                        .lineSpacing(4)
                                        .foregroundColor(.white)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                            }
                        }
                        
                        // Full Article Content
                        VStack(alignment: .leading, spacing: 16) {
                            Text(article.content)
                                .font(.system(size: 16, weight: .regular))
                                .lineSpacing(6)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 24)
                    .padding(.bottom, 100) // Extra bottom padding
                }
            }
            
            // Custom Toolbar Overlay
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 17, weight: .medium))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(Color.black.opacity(0.4))
                            .clipShape(Circle())
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                    
                    HStack(spacing: 12) {
                        Image(systemName: "headphones")
                            .font(.system(size: 17, weight: .medium))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(Color.black.opacity(0.4))
                            .clipShape(Circle())
                        
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 17, weight: .medium))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(Color.black.opacity(0.4))
                            .clipShape(Circle())
                        
                        Image(systemName: "ellipsis")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(Color.black.opacity(0.4))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal, 20)
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    @Previewable @State var selectedArticle: NewsArticle? = NewsArticle.sampleArticles.first
    @Previewable @Namespace var previewNamespace

    return NewsDetailView(
        article: NewsArticle.sampleArticles.first!,
        imageTransition: previewNamespace
    )
}
