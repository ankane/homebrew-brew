class Rcf < Formula
  desc "Command-line interface for Random Cut Forest anomaly detection"
  homepage "https://github.com/ankane/rcf-cli"
  if OS.linux?
    url "https://github.com/ankane/rcf-cli/releases/download/v0.1.0/rcf-cli-0.1.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "f7603f22a15a35aaf5c43966e3be12481c48bf9a127f18a7f4748f7ca0792585"
  elsif Hardware::CPU.arm?
    url "https://github.com/ankane/rcf-cli/releases/download/v0.1.0/rcf-cli-0.1.0-aarch64-apple-darwin.tar.gz"
    sha256 "330cc475ffa2586ea7764f45cc340be50a6a99475161f84052d2cfd80bec4bd2"
  else
    url "https://github.com/ankane/rcf-cli/releases/download/v0.1.0/rcf-cli-0.1.0-x86_64-apple-darwin.tar.gz"
    sha256 "ef1b07668647e7357403d8fddf39c9be4f9730d630ceb160f994d759b70b4326"
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
