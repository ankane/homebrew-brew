class Morph < Formula
  desc "Privacy-preserving, in-memory, key-value store"
  homepage "https://github.com/ankane/morph"
  url "https://github.com/ankane/morph/archive/v0.1.0.tar.gz"
  sha256 "e3eba8c522350a0bb2149c0c5172ee669bf0b640a0ce1c22fe0bf7b279c680da"
  license "Apache-2.0"
  head "https://github.com/ankane/morph.git"

  depends_on "cmake" => :build
  depends_on "helib"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make"
      system "make", "install"
    end
  end

  test do
    system bin/"morph-cli", "keygen"

    fork do
      exec bin/"morph-server"
    end
    sleep 1

    system bin/"morph-cli", "set", "hello", "world"
    assert_match "world", shell_output("#{bin}/morph-cli get hello")
  end
end
