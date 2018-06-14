class Jetpack < Formula
  desc "Friendly package manager for R"
  homepage "https://github.com/ankane/jetpack"
  url "https://github.com/ankane/jetpack/archive/v0.1.2.tar.gz"
  sha256 "cae0c86216e05517ed23f87bdc7db0a794a74154c5346077cea9987a4e8fd90b"

  depends_on "r"

  def install
    bin.install "bin/jetpack" => "jetpack"
  end

  test do
    system "#{bin}/jetpack", "version"
  end
end
