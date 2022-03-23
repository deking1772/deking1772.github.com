Gem::Specification.new do |spec|
  spec.name          = "deking1772-blog"
  spec.version       = "2.0.10"
  spec.authors       = ["deking"]
  spec.email         = ["deking1772@gmail.com"]

  spec.summary       = "앤드류의 개발일지"
  spec.license       = "MIT"
  spec.homepage      = "https://github.com/deking1772/deking1772.github.io"

  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r!^(assets|_layouts|_includes|_sass|LICENSE|README)!i) }

  spec.add_runtime_dependency "github-pages", "~> 209"
end
