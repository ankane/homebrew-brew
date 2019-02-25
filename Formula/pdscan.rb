class Pdscan < Formula
  desc "Scan your data stores for unencrypted personal data (PII)"
  homepage "https://github.com/ankane/pdscan"
  url "https://github.com/ankane/pdscan/releases/download/v0.1.0/pdscan_0.1.0_Darwin_x86_64.zip"
  sha256 "33d22a80f25372d5c4e31d7687e5c7e94c455609b50253199a1218d00e233a3b"

  def install
    bin.install "pdscan"
  end

  test do
    system "#{bin}/pdscan", "--help"
  end
end
