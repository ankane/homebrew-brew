class Pdscan < Formula
  desc "Scan your data stores for unencrypted personal data (PII)"
  homepage "https://github.com/ankane/pdscan"
  if OS.linux?
    url "https://github.com/ankane/pdscan/releases/download/v0.1.8/pdscan-0.1.8-x86_64-linux.zip"
    sha256 "d2b8b1556353de3cf83f0ab2528e5fe0d2fe17f1d11caf6fb110ec1b2585537f"
  elsif Hardware::CPU.arm?
    url "https://github.com/ankane/pdscan/releases/download/v0.1.8/pdscan-0.1.8-arm64-darwin.zip"
    sha256 "c554359286decac446192cc0490baf56bb8232f60ad660e4e99776220fff225a"
  else
    url "https://github.com/ankane/pdscan/releases/download/v0.1.8/pdscan-0.1.8-x86_64-darwin.zip"
    sha256 "0ebb02043a2be5d9d4bf868940b6981d6ffb27408c3e59a95948d5e129380f24"
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
