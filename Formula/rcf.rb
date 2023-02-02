class Rcf < Formula
  desc "Command-line interface for Random Cut Forest anomaly detection"
  homepage "https://github.com/ankane/rcf-cli"
  if OS.linux?
    url "https://github.com/ankane/rcf-cli/releases/download/v0.1.1/rcf-cli-0.1.1-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "82123f1fb4f7ea56fd4edb997a61606ea8c6fb052ccbc41cc422a65da9f2d9be"
  elsif Hardware::CPU.arm?
    url "https://github.com/ankane/rcf-cli/releases/download/v0.1.1/rcf-cli-0.1.1-aarch64-apple-darwin.tar.gz"
    sha256 "e3f4f2a0f4c87053eff53acd86f02745f52ec1aec13afee024ab2fe569d49d17"
  else
    url "https://github.com/ankane/rcf-cli/releases/download/v0.1.1/rcf-cli-0.1.1-x86_64-apple-darwin.tar.gz"
    sha256 "fe6fbbd4e3a77d87fb963db2a3fc2ea721c4a44b3aa4533e8fa9495bd2d32976"
  end
  license "Apache-2.0"

  def install
    bin.install "rcf"
    pkgshare.install "example-data"
    prefix.install Dir["*"]
  end

  test do
    cp pkgshare/"example-data/input.csv", testpath
    pipe_output("#{bin}/rcf < input.csv > output.csv")
    assert_predicate testpath/"output.csv", :exist?
  end
end
