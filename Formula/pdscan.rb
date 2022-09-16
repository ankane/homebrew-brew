class Pdscan < Formula
  desc "Scan your data stores for unencrypted personal data (PII)"
  homepage "https://github.com/ankane/pdscan"
  if OS.linux?
    url "https://github.com/ankane/pdscan/releases/download/v0.1.6/pdscan_0.1.6_Linux_x86_64.zip"
    sha256 "5fd6b014c71076d62afcff9ada6092be02a62769dc9c080eff31167ce2bc4a15"
  elsif Hardware::CPU.arm?
    url "https://github.com/ankane/pdscan/releases/download/v0.1.6/pdscan_0.1.6_Darwin_arm64.zip"
    sha256 "2c28229baa23e146c77e16a0a8010f3942b9319932b5e6e2ce7b7af08edd5594"
  else
    url "https://github.com/ankane/pdscan/releases/download/v0.1.6/pdscan_0.1.6_Darwin_x86_64.zip"
    sha256 "689518085a9164ac130f1a30a25b5d32cccc267bf952f399b3daf8f0d46bec86"
  end
  version "0.1.6"
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
