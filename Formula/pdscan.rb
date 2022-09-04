class Pdscan < Formula
  desc "Scan your data stores for unencrypted personal data (PII)"
  homepage "https://github.com/ankane/pdscan"
  if OS.linux?
    url "https://github.com/ankane/pdscan/releases/download/v0.1.3/pdscan_0.1.3_Linux_x86_64.zip"
    sha256 "e0e51eff03ea36c685e0791ffd3b7a9ca0b52178637e3c7d91fbb76642da28c4"
  elsif Hardware::CPU.arm?
    url "https://github.com/ankane/pdscan/releases/download/v0.1.3/pdscan_0.1.3_Darwin_arm64.zip"
    sha256 "cb6cb97f84efcb8e9b610332e8199f09a0e3f2f6e2d0127e3d467b64af8e50d2"
  else
    url "https://github.com/ankane/pdscan/releases/download/v0.1.3/pdscan_0.1.3_Darwin_x86_64.zip"
    sha256 "351e52554ad281dbd47b6fd66a30ccdc93256276fdef9b92762d4f00d37ba066"
  end
  version "0.1.3"
  license "MIT"

  def install
    bin.install "pdscan"
  end

  test do
    system "#{bin}/pdscan", "--help"
  end
end
