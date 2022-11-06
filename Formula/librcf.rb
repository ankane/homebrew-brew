class Librcf < Formula
  desc "Random Cut Forest anomaly detection for C/C++"
  homepage "https://github.com/ankane/librcf"
  if OS.linux?
    url "https://github.com/ankane/librcf/releases/download/v0.1.1/librcf-0.1.1-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "66fc7c806be465e750e16eeb8392c6345082696b13145f84bb1f702a882f950f"
  elsif Hardware::CPU.arm?
    url "https://github.com/ankane/librcf/releases/download/v0.1.1/librcf-0.1.1-aarch64-apple-darwin.tar.gz"
    sha256 "ae7adfd05a0f81c07b50d87f546dc542ba12acf2407d39e466e576c953e77523"
  else
    url "https://github.com/ankane/librcf/releases/download/v0.1.1/librcf-0.1.1-x86_64-apple-darwin.tar.gz"
    sha256 "a41e04a3cb7074001f741abe37697e1e278364cf81e450188c68bd3ecdebe89c"
  end
  license "Apache-2.0"

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
