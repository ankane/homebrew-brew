class Morph < Formula
  desc "Privacy-preserving, in-memory, key-value store"
  homepage "https://github.com/ankane/morph"
  url "https://github.com/ankane/morph/archive/v0.1.1.tar.gz"
  sha256 "e250e144b56097f503e59a8f2028baf8177c209e370c94246500590ddc8fa935"
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
    pkgshare.install "examples"
  end

  test do
    system bin/"morph-cli", "keygen"

    port = free_port
    fork do
      exec bin/"morph-server", "-p", port.to_s
    end
    sleep 1

    system bin/"morph-cli", "-p", port.to_s, "set", "hello", "world"
    assert_match "world", shell_output("#{bin}/morph-cli -p #{port} get hello")

    cp pkgshare/"examples/hello.cpp", testpath
    system ENV.cxx, "-std=c++17", "hello.cpp",
                    "-L#{lib}", "-lmorph",
                    "-L#{Formula["ntl"].opt_lib}", "-lhelib",
                    "-L#{Formula["helib"].opt_lib}", "-lntl",
                    "-o", "hello"
    # port not included
    # assert_match "world", shell_output("./hello")
  end
end
