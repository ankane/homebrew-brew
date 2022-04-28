class Strata < Formula
  include Language::Python::Virtualenv

  desc "Easy way to ship Stan models"
  homepage "https://github.com/ankane/strata"
  url "https://github.com/ankane/strata/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "199bd7694285cf61a3c7e34c907ae8b277f95b1d2e90949c6c031b52d80657f0"
  license "BSD-3-Clause"

  depends_on "python@3.10"

  def install
    virtualenv_install_with_resources
    pkgshare.install "examples"
  end

  def test
    cp_r pkgshare/"examples/.", testpath
    system bin/"strata", "bernoulli.stan"
    system "dist/bin/bernoulli", "sample", "data", "file=bernoulli.data.json"
  end
end
