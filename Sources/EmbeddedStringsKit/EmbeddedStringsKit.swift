import Foundation

extension String {
  fileprivate init(
    template: StaticString,
    args: [String: CustomStringConvertible]
  ) {
    var text = template.description

    for arg in args {
      do {
        let format = "{{ \(arg.key) }}"
        text = text.replacingOccurrences(of: format, with: arg.value.description)
      }
      do {
        let format = "{{\(arg.key)}}"
        text = text.replacingOccurrences(of: format, with: arg.value.description)
      }
      do {
        let format = "{\(arg.key)}"
        text = text.replacingOccurrences(of: format, with: arg.value.description)
      }
      do {
        let format = "{ \(arg.key) }"
        text = text.replacingOccurrences(of: format, with: arg.value.description)
      }
    }

    self = text
  }
}

public struct LocalizedStringsLanguage: Hashable {

  public let identifier: String

  public init(
    identifier: String
  ) {
    self.identifier = identifier
  }

  public static let ja = Self.init(identifier: "ja")
  public static let en = Self.init(identifier: "en")

}

public struct StringsResolver<Trait: LocalizedStringsTraitType> {

  private let _resolve: ([LocalizedStringsLanguage: StaticString]) -> StaticString

  public init(
    _ resolve: @escaping ([LocalizedStringsLanguage: StaticString]) -> StaticString
  ) {
    self._resolve = resolve
  }

  func resolve(storage: [LocalizedStringsLanguage: StaticString]) -> StaticString {
    _resolve(storage)
  }

  public static func makeDefault(
    enforcedLanguage: LocalizedStringsLanguage? = nil
  ) -> StringsResolver<Trait> {
    .init { storage in

      let allLanguages = Locale.preferredLanguages.map(Locale.init(identifier:))

      guard let firstLanguage = allLanguages.first else {
        fatalError()
      }

      if let enforcedLanguage = enforcedLanguage {

        return storage.first { $0.key.identifier == enforcedLanguage.identifier }?.value
          ?? storage.first { $0.key.identifier == firstLanguage.languageCode }?.value
          ?? storage.first { $0.key.identifier == Trait.instance.defaultLanguage.identifier }?.value
          ?? storage.first?.value ?? "_l10n_not_available_"
      } else {

        return storage.first { $0.key.identifier == firstLanguage.languageCode }?.value
          ?? storage.first { $0.key.identifier == Trait.instance.defaultLanguage.identifier }?.value
          ?? storage.first?.value ?? "_l10n_not_available_"
      }

    }
  }
}

public protocol LocalizedStringsTraitType {
  static var instance: Self { get }

  var resolver: StringsResolver<Self> { get }

  var defaultLanguage: LocalizedStringsLanguage { get }
}

@dynamicMemberLookup
public struct LocalizedStrings<Trait: LocalizedStringsTraitType> {

  public var storage: [LocalizedStringsLanguage: StaticString]

  public static func makeDraft() -> Self {
    .init()
  }

  init() {
    self.storage = [:]
  }

  public subscript(dynamicMember keyPath: KeyPath<Trait, LocalizedStringsLanguage>) -> StaticString?
  {
    get {
      let key = Trait.instance[keyPath: keyPath]
      return storage[key]
    }
    mutating set {
      let key = Trait.instance[keyPath: keyPath]
      storage[key] = newValue
    }
  }

  public func string(parameters: [String: CustomStringConvertible] = [:]) -> String {

    String(template: rawString(), args: parameters)

  }

  public func rawString() -> StaticString {

    Trait.instance.resolver.resolve(storage: storage)

  }

}
