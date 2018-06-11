class Jetpack < Formula
  desc "Friendly package manager for R"
  homepage "https://github.com/ankane/jetpack"
  url "https://github.com/ankane/jetpack/archive/v0.1.0.tar.gz"
  sha256 "680b3b30abc98f571501f0b6c902510b020a55841bcd882bb315bedfc8fe0d19"

  depends_on "r"

  def install
    bin.install "jetpack"
  end

  test do
    system "#{bin}/jetpack", "version"
  end
end
