class Jetpack < Formula
  desc "Friendly package manager for R"
  homepage "https://github.com/ankane/jetpack"
  url "https://github.com/ankane/jetpack/archive/v0.1.1.tar.gz"
  sha256 "8747df17007b6a51cfb63a95d4530fa18833cb6b4281caabb0e1ef823e2dae96"

  depends_on "r"

  def install
    bin.install "R/jetpack.R" => "jetpack"
  end

  test do
    system "#{bin}/jetpack", "version"
  end
end
