public import Renderer

extension Renderer.Document.Semantic {

    public enum Inline: Sendable {
        case emphasis
        case strong
        case code
    }
}
