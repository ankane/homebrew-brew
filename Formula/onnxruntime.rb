class Onnxruntime < Formula
  desc "Cross-platform, high performance scoring engine for ML models"
  homepage "https://github.com/microsoft/onnxruntime"

  url "https://github.com/microsoft/onnxruntime/releases/download/v0.5.0/onnxruntime-osx-x64-0.5.0.tgz"
  sha256 "53993616d0928c746707f7c17d77b2c118d2404dfffb508d3fa2b20eaa7903fb"

  bottle :unneeded

  def install
    lib.install Dir["lib/*"]
    include.install Dir["include/*"]
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <onnxruntime_c_api.h>
      #include <stdio.h>
      int main()
      {
        printf("%s\\n", OrtGetVersionString());
        return 0;
      }
    EOS
    system ENV.cc, "-I#{include}", "-L#{lib}", "-lonnxruntime",
           testpath/"test.c", "-o", testpath/"test"
    assert_equal version, shell_output("./test").strip
  end
end
