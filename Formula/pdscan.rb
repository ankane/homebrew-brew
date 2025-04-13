class Pdscan < Formula
  desc "Scan your data stores for unencrypted personal data (PII)"
  homepage "https://github.com/ankane/pdscan"
  if OS.linux?
    url "https://github.com/ankane/pdscan/releases/download/v0.1.9/pdscan-0.1.9-x86_64-linux.zip"
    sha256 "1ef8095681991a55c53efccb9ed33462e1aadfaf020f12d35a255061b30fc8bf"
  elsif Hardware::CPU.arm?
    url "https://github.com/ankane/pdscan/releases/download/v0.1.9/pdscan-0.1.9-arm64-darwin.zip"
    sha256 "3673f49b76f3a4d40aa6722cdfc650415c463fd670b7d92a63acfd64a5c318aa"
  else
    url "https://github.com/ankane/pdscan/releases/download/v0.1.9/pdscan-0.1.9-x86_64-darwin.zip"
    sha256 "eb7e623cfabb734664796f9707a0103239a1833be8c1fa543e30193f7c519cb0"
  end
  license "MIT"

  def install
    bin.install "pdscan"
    prefix.install Dir["*"]
  end

  test do
    (testpath/"emails.txt").write <<~EOS
      test@example.org
    EOS
    output = shell_output("#{bin}/pdscan file://#{testpath}/emails.txt")
    assert_match "found emails", output
  end
end
