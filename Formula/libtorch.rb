class Libtorch < Formula
  desc "Tensors and dynamic neural networks"
  homepage "https://pytorch.org/"
  url "https://download.pytorch.org/libtorch/cpu/libtorch-macos-1.3.1.zip"
  sha256 "eda550df98414e4f90a854c2220da354fe50692a8e55a53e999d36dbae4cd506"

  def install
    lib.install Dir["lib/{libc10,libtorch}.dylib"]
    include.install Dir["include/{ATen,c10,torch}"]
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <torch/torch.h>
      #include <iostream>

      int main() {
        torch::Tensor tensor = torch::rand({2, 3});
        std::cout << tensor << std::endl;
      }
    EOS
    system ENV.cxx, "-std=c++11", "-L#{lib}", "-ltorch", "-lc10",
      "-I#{include}/torch/csrc/api/include", "test.cpp", "-o", "test"
    system "./test"
  end
end
