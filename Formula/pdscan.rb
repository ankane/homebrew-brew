class Pdscan < Formula
  desc "Scan your data stores for unencrypted personal data (PII)"
  homepage "https://github.com/ankane/pdscan"
  if OS.linux?
    url "https://github.com/ankane/pdscan/releases/download/v0.1.2/pdscan_0.1.2_Linux_x86_64.zip"
    sha256 "32e57362e2ed807edbc3b336b541d8ba70e78cfcf6f146aa576d2ec00a717495"
  elsif Hardware::CPU.arm?
    url "https://github.com/ankane/pdscan/releases/download/v0.1.2/pdscan_0.1.2_Darwin_arm64.zip"
    sha256 "9dad8713e7edf8e0c11b6459eb14c1e176846038d9b2e3084f66d066c354c75e"
  else
    url "https://github.com/ankane/pdscan/releases/download/v0.1.2/pdscan_0.1.2_Darwin_x86_64.zip"
    sha256 "5cf19ec8282243bd268f0980aef51634395e9baf2553e50afda65ace8f33b4da"
  end
  version "0.1.2"
  license "MIT"

  def install
    bin.install "pdscan"
  end

  test do
    system "#{bin}/pdscan", "--help"
  end
end
