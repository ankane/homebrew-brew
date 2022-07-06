class Pgsync < Formula
  desc "Sync Postgres data between databases"
  homepage "https://github.com/ankane/pgsync"
  url "https://github.com/ankane/pgsync/archive/v0.7.1.tar.gz"
  sha256 "e1c0077f5ea450ed29bc310c054e6f67553ab3f54b216472fd71931d3a6bc43b"
  license "MIT"

  depends_on "libpq"

  resource "parallel" do
    url "https://rubygems.org/gems/parallel-1.22.1.gem"
    sha256 "ebdf1f0c51f182df38522f70ba770214940bef998cdb6e00f36492b29699761f"
  end

  resource "pg" do
    url "https://rubygems.org/gems/pg-1.4.1.gem"
    sha256 "386bbffad223cce1dda903dad2c59268e41f3d183792506671ae526011ff0487"
  end

  resource "slop" do
    url "https://rubygems.org/gems/slop-4.9.2.gem"
    sha256 "5edcfaa749f3c978a7f8976520c8ec8aa174c3d5a1fcc52f05932eb7e442f2b5"
  end

  resource "tty-cursor" do
    url "https://rubygems.org/gems/tty-cursor-0.7.1.gem"
    sha256 "79534185e6a777888d88628b14b6a1fdf5154a603f285f80b1753e1908e0bf48"
  end

  resource "tty-spinner" do
    url "https://rubygems.org/gems/tty-spinner-0.9.3.gem"
    sha256 "0e036f047b4ffb61f2aa45f5a770ec00b4d04130531558a94bfc5b192b570542"
  end

  def install
    ENV["GEM_HOME"] = libexec
    ENV["PG_CONFIG"] = Formula["libpq"].opt_bin/"pg_config"

    resources.each do |r|
      r.fetch
      system "gem", "install", r.cached_download, "--ignore-dependencies",
             "--no-document", "--install-dir", libexec
    end

    system "gem", "build", "pgsync.gemspec"
    system "gem", "install", "--ignore-dependencies", "pgsync-#{version}.gem"

    bin.install libexec/"bin/pgsync"
    bin.env_script_all_files(libexec/"bin", :GEM_HOME => ENV["GEM_HOME"])
  end

  test do
    system "#{bin}/pgsync", "--init"
    assert_predicate testpath/".pgsync.yml", :exist?
  end
end
