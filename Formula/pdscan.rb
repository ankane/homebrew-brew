class Pdscan < Formula
  desc "Scan your data stores for unencrypted personal data (PII)"
  homepage "https://github.com/ankane/pdscan"
  if OS.linux?
    url "https://github.com/ankane/pdscan/releases/download/v0.1.7/pdscan-0.1.7-x86_64-linux.zip"
    sha256 "068dd45cb1ac4654145070e6937a1d869381b7476227a3224bd613d56baff2a4"
  elsif Hardware::CPU.arm?
    url "https://github.com/ankane/pdscan/releases/download/v0.1.7/pdscan-0.1.7-arm64-darwin.zip"
    sha256 "ca9aa25856b66ab62cf6744609a2ba15219fe6b035d9dc973c257334fe06848d"
  else
    url "https://github.com/ankane/pdscan/releases/download/v0.1.7/pdscan-0.1.7-x86_64-darwin.zip"
    sha256 "f04e4a38a5860fd398af257fe4673edcd35a10748a6905d4806ebee9c705dfa1"
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
