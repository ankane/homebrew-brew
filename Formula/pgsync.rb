class Pgsync < Formula
  desc "Sync Postgres data between databases"
  homepage "https://github.com/ankane/pgsync"
  url "https://github.com/ankane/pgsync/archive/v0.5.2.tar.gz"
  sha256 "fb324de20527f2059226d216089c2ef2e1f20c0c1cda0402a145ba3476520324"

  depends_on "libpq"

  resource "parallel" do
    url "https://rubygems.org/gems/parallel-1.19.1.gem"
    sha256 "c27ee2925978e8100f49063fd60f625522a6e96b08541ac26e7f2a72d594518a"
  end

  resource "pg" do
    url "https://rubygems.org/gems/pg-1.2.3.gem"
    sha256 "f2e71e101eb7fc297222fa9a277a89a9686729a8dfa416d46408e696b5cfae8e"
  end

  resource "slop" do
    url "https://rubygems.org/gems/slop-4.8.0.gem"
    sha256 "fae9fbfd4aea2470e47f42322d60ba547051027eb70816e1d01f36f0aa4df456"
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
