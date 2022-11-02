class Disco < Formula
  desc "Generate recommendations from CSV files"
  homepage "https://github.com/ankane/disco-cli"
  if Hardware::CPU.arm?
    url "https://github.com/ankane/disco-cli/releases/download/v0.1.0/disco-0.1.0-aarch64-apple-darwin.tar.gz"
    sha256 "0b7976ebd8087c4dcd79aded66e9b327c955fb641b55a01f48c9cd7165cf1676"
  else
    url "https://github.com/ankane/disco-cli/releases/download/v0.1.0/disco-0.1.0-x86_64-apple-darwin.tar.gz"
    sha256 "7459a9531b3c2e62f464fe2f551c4fcb22b3f5275e1081a332e11fcd0b2fb1b1"
  end
  license "MIT"

  def install
    bin.install "disco"
    prefix.install Dir["*"]
  end

  test do
  end
end
