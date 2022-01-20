Pod::Spec.new do |spec|
  spec.name = "EmbeddedStringsKit"
  spec.version = "0.1.0"
  spec.summary = "A tiny library to manage localizable string in the code."
  spec.description = <<-DESC
  A tiny library to manage localizable string in the code
                   DESC

  spec.homepage = "https://github.com/muukii/EmbeddedStringsKit"
  spec.license = "MIT"
  spec.author = { "Muukii" => "muukii.app@gmail.com" }
  spec.social_media_url = "https://twitter.com/muukii_app"

  spec.ios.deployment_target = "12.0"
  # spec.osx.deployment_target = "10.7"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"

  spec.source = { :git => "https://github.com/muukii/EmbeddedStringsKit.git", :tag => "#{spec.version}" }
  spec.framework = "Foundation"
  spec.requires_arc = true
  spec.swift_versions = ["5.3", "5.4", "5.5"]

  spec.source_files = "Sources/EmbeddedStringsKit/**/*.swift"

end
