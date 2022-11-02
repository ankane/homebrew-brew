class Librcf < Formula
  desc "Random Cut Forest anomaly detection for C/C++"
  homepage "https://github.com/ankane/librcf"
  if OS.linux?
    url "https://github.com/ankane/librcf/releases/download/v0.1.0/librcf-0.1.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "8183afdc540c969cd30706a2b8d263fe2b843e0c4f7bab546547ac00b5897bb1"
  elsif Hardware::CPU.arm?
    url "https://github.com/ankane/librcf/releases/download/v0.1.0/librcf-0.1.0-aarch64-apple-darwin.tar.gz"
    sha256 "a992eaaca2e3039d743ba6d7379ae2fe8fe4d2fef7010f25334c41a22cd247a5"
  else
    url "https://github.com/ankane/librcf/releases/download/v0.1.0/librcf-0.1.0-x86_64-apple-darwin.tar.gz"
    sha256 "f48b030f8c6a86aa8fd4f9edb85cab2e9d87ad763adb9a589ae7a0a4895f76f0"
  end
  license "MIT"

  def install
    pkgshare.install "example"
    prefix.install Dir["*"]
  end

  test do
    cp pkgshare/"example/main.c", testpath
    system ENV.cc, "main.c", "-L#{lib}", "-lrcf", "-o", "test"
    system "./test"
  end
end
