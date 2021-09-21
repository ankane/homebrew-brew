class Dexter < Formula
  desc "Automatic indexer for Postgres"
  homepage "https://github.com/ankane/dexter"
  url "https://github.com/ankane/dexter/archive/v0.3.10.tar.gz"
  sha256 "2228f84d9a853e92c12e993a102e0c5b76b09bb08bca21e7cca9f434e7c633e7"
  license "MIT"

  depends_on "libpq"

  resource "pg" do
    url "https://rubygems.org/gems/pg-1.2.3.gem"
    sha256 "f2e71e101eb7fc297222fa9a277a89a9686729a8dfa416d46408e696b5cfae8e"
  end

  resource "pg_query" do
    url "https://rubygems.org/gems/pg_query-1.3.0.gem"
    sha256 "0e1be8d88a8c0521b81f84d43efb8349ef1330861d4a353015b535018a1f34c5"
  end

  resource "slop" do
    url "https://rubygems.org/gems/slop-4.9.1.gem"
    sha256 "498de9c170ab15573a69aca92cc6199122be319e108de0f74a41cb26abdceb18"
  end

  def install
    ENV["GEM_HOME"] = libexec
    ENV["PG_CONFIG"] = Formula["libpq"].opt_bin/"pg_config"

    resources.each do |r|
      r.fetch
      system "gem", "install", r.cached_download, "--ignore-dependencies",
             "--no-document", "--install-dir", libexec
    end

    system "gem", "build", "pgdexter.gemspec"
    system "gem", "install", "--ignore-dependencies", "pgdexter-#{version}.gem"

    bin.install libexec/"bin/dexter"
    bin.env_script_all_files(libexec/"bin", :GEM_HOME => ENV["GEM_HOME"])
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dexter --version")
  end
end
