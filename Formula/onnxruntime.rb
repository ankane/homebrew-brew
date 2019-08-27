class Onnxruntime < Formula
  desc "Cross-platform, high performance scoring engine for ML models"
  homepage "https://github.com/microsoft/onnxruntime"

  url "https://github.com/microsoft/onnxruntime/releases/download/v0.5.0/onnxruntime-osx-x64-0.5.0.tgz"
  sha256 "53993616d0928c746707f7c17d77b2c118d2404dfffb508d3fa2b20eaa7903fb"

  def install
    lib.install "lib/libonnxruntime.#{version}.dylib" => "libonnxruntime.dylib"
  end

  test do
    system "true"
  end
end
