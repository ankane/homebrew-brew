class Pdscan < Formula
  desc "Scan your data stores for unencrypted personal data (PII)"
  homepage "https://github.com/ankane/pdscan"
  url "https://github.com/ankane/pdscan/releases/download/v0.1.1/pdscan_0.1.1_Darwin_x86_64.zip"
  sha256 "5c33f4f39a2cfb93779f70a3d1296deb61572c6266d5c401fb5879bed672461b"
  version "0.1.1"
  license "MIT"

  def install
    bin.install "pdscan"
  end

  test do
    system "#{bin}/pdscan", "--help"
  end
end
