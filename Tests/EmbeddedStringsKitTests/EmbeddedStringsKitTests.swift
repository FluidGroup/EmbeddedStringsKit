import XCTest

@testable import EmbeddedStringsKit

final class EmbeddedStringsKitTests: XCTestCase {
  func testExample() throws {

  }
}

import EmbeddedStringsKit

struct LocalizedStringsTrait: LocalizedStringsTraitType {

  let resolver: StringsResolver<LocalizedStringsTrait> = .makeDefault()

  public static let instance = LocalizedStringsTrait()

  public var defaultLanguage: LocalizedStringsLanguage {
    return ja
  }

  public let ja = LocalizedStringsLanguage.ja
  public let en = LocalizedStringsLanguage.en
}

/**
 Embedding Localized Strings
 */
typealias Strings = LocalizedStrings<LocalizedStringsTrait>

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

