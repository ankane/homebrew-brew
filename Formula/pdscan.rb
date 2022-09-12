class Pdscan < Formula
  desc "Scan your data stores for unencrypted personal data (PII)"
  homepage "https://github.com/ankane/pdscan"
  if OS.linux?
    url "https://github.com/ankane/pdscan/releases/download/v0.1.5/pdscan_0.1.5_Linux_x86_64.zip"
    sha256 "63b0b4d471342744c6fb39dd27c9edf8eb1d068281bcc7bb7e8e616c30ef00c5"
  elsif Hardware::CPU.arm?
    url "https://github.com/ankane/pdscan/releases/download/v0.1.5/pdscan_0.1.5_Darwin_arm64.zip"
    sha256 "4210e127596094be65ac7074383fc3ab80ae24378f65374ce47b46e20b7a79a3"
  else
    url "https://github.com/ankane/pdscan/releases/download/v0.1.5/pdscan_0.1.5_Darwin_x86_64.zip"
    sha256 "369adec2b384d1bed69b15c6391b055be34b20a6f95233caff577d6ecf5ed6bd"
  end
  version "0.1.5"
  license "MIT"

  def install
    bin.install "pdscan"
  end

  test do
    (testpath/"emails.txt").write <<~EOS
      test@example.org
    EOS
    output = shell_output("#{bin}/pdscan file://#{testpath}/emails.txt")
    assert_match "found emails", output
  end
end
