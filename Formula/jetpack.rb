class Jetpack < Formula
  desc "Friendly package manager for R"
  homepage "https://github.com/ankane/jetpack"
  url "https://github.com/ankane/jetpack/archive/v0.1.3.tar.gz"
  sha256 "15973caf2bf722baa21a44091cb3b2a40504a316560a2b7b4da14bfc67ec4a96"

  depends_on "r"

  def install
    bin.install "bin/jetpack" => "jetpack"
  end

  test do
    system "#{bin}/jetpack", "version"
  end
end
