# swift-renderer-document

Use this package when a document is built from views, as SwiftUI builds an interface, and each backend (HTML, PDF, SVG, a test recording) must receive the same stream of calls from it. Write a view as a `Renderer.Document.View` with a `body` built by `@Renderer.Document.Builder`, or with its own `_render` for a leaf, and render it into a `Renderer.Document.Context`, which turns it into push, pop, text and break calls on the backend's closures. `Renderer.Document.Semantic` names what a block or inline element is, and `Renderer.Document.Style` how it looks, so a backend can map both. The operation a value writes itself with is swift-renderer's `Renderer.Protocol`; this package is the document machine above it. In tests, `Renderer.Document.Recording` of the `Renderer Document Test Support` product records the call stream.

## Laws

- `Renderer.Document.Context.render(_:)` emits in source order: builder statements, `Swift.Array` and `Renderer.Document._Tuple` elements, then `Renderer.Document.Pair` with `first` before `second`. `Renderer.Document.Conditional` emits only the chosen branch, and a `nil` optional emits nothing. `Renderer.Document.Group` and `Renderer.Document.Empty` add no events of their own.
- `Renderer.Document.Context.open(push:pop:)` emits the push immediately. It emits the matching pop after all content the view schedules after it, and before the next sibling renders.
