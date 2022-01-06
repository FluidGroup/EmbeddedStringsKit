# EmbeddedStringsKit

Representation localized string in code

## Usage

```swift
public struct LocalizedStringsTrait: LocalizedStringsTraitType {

  public static let instance = LocalizedStringsTrait()

  public var defaultLanguage: LocalizedStringsLanguage {
    return ja
  }

  public let ja = LocalizedStringsLanguage(identifier: "ja")
  public let en = LocalizedStringsLanguage(identifier: "en")
}

/**
 Embedding Localized Strings
 */
public typealias Strings = LocalizedStrings<LocalizedStringsTrait>

extension Strings {

  /// Creates an instance of localizable strings
  ///
  /// You may use `{{ name }}` token to interpolate strings.
  ///
  /// - Parameter ja:
  public init(
    ja: StaticString,
    en: StaticString
  ) {

    var instance = Self.makeDraft()
    instance.ja = ja
    instance.en = en
    self = instance

  }
}
```

```swift
let localizedText = Strings(
  ja: "こんにちは {{name}} です。",
  en: "Hello, I'm {{name}}."
  )
  .string(parameters: ["name" : "John"])
```