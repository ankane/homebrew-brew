class Librcf < Formula
  desc "Random Cut Forest anomaly detection for C/C++"
  homepage "https://github.com/ankane/librcf"
  if OS.linux?
    url "https://github.com/ankane/librcf/releases/download/v0.2.0/librcf-0.2.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "df88398e8dd950fbc503b382b280823713ca53931561e25b6d2f1c868bd37811"
  elsif Hardware::CPU.arm?
    url "https://github.com/ankane/librcf/releases/download/v0.2.0/librcf-0.2.0-aarch64-apple-darwin.tar.gz"
    sha256 "01fcb7b1330792223a5c7272ebe25a2ada2b081908331defe88242410ca5cddb"
  else
    url "https://github.com/ankane/librcf/releases/download/v0.2.0/librcf-0.2.0-x86_64-apple-darwin.tar.gz"
    sha256 "bfd2240cd40026791a6d9c44262f23a0a7439576c95d1d08b6b697a048aa16e9"
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
