class Pgsync < Formula
  desc "Sync Postgres data between databases"
  homepage "https://github.com/ankane/pgsync"
  url "https://github.com/ankane/pgsync/archive/v0.7.0.tar.gz"
  sha256 "8c0b38294882756e3116ef6bd4a0cfc90ed38b0d2e217a3fdb3dcedb5e000751"
  license "MIT"

  depends_on "libpq"

  resource "parallel" do
    url "https://rubygems.org/gems/parallel-1.21.0.gem"
    sha256 "e4a92d75cf9d0e3d50f396f5180f827dcb985f98436d4b170e7a0b864ebd6ec2"
  end

  resource "pg" do
    url "https://rubygems.org/gems/pg-1.3.4.gem"
    sha256 "abb23723463fdc8c877f42679b840e81518ee26b472b5ac4fd3156fad51c0c24"
  end

  resource "slop" do
    url "https://rubygems.org/gems/slop-4.9.1.gem"
    sha256 "498de9c170ab15573a69aca92cc6199122be319e108de0f74a41cb26abdceb18"
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
