public import Renderer

extension Renderer.Document.Action {

    public enum Break: Sendable {
        case line
        case thematic
        case page
    }
}
