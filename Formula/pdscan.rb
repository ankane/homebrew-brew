class Pdscan < Formula
  desc "Scan your data stores for unencrypted personal data (PII)"
  homepage "https://github.com/ankane/pdscan"
  if OS.linux?
    url "https://github.com/ankane/pdscan/releases/download/v0.1.4/pdscan_0.1.4_Linux_x86_64.zip"
    sha256 "eda2a424c69ccc98248035565acd11a09cdb1dc144d6e0ef34405c967b9001da"
  elsif Hardware::CPU.arm?
    url "https://github.com/ankane/pdscan/releases/download/v0.1.4/pdscan_0.1.4_Darwin_arm64.zip"
    sha256 "24c95b0006608934b1f0e08f6c3b1ad44c45f2b753208b147f51498dd7d7694c"
  else
    url "https://github.com/ankane/pdscan/releases/download/v0.1.4/pdscan_0.1.4_Darwin_x86_64.zip"
    sha256 "083fd30f9f1e46ce5555491ff98097f80ab88371f9d0378fc5eca20715681314"
  end
  version "0.1.4"
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
