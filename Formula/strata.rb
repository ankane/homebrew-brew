class Strata < Formula
  include Language::Python::Virtualenv

  desc "Easy way to ship Stan models"
  homepage "https://github.com/ankane/strata"
  url "https://github.com/ankane/strata/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "b16802ddc8d32d954a7652086aba9e7e2d229f8edbb0b234b26edcbf3dbd8498"
  license "BSD-3-Clause"

  depends_on "python@3.13"

  def install
    virtualenv_install_with_resources
    pkgshare.install "examples"
  end

  test do
    cp_r pkgshare/"examples/.", testpath
    system bin/"strata", "bernoulli.stan"
    system "dist/bin/bernoulli", "sample", "data", "file=bernoulli.data.json"
  end
end
