class Dexter < Formula
  desc "Automatic indexer for Postgres"
  homepage "https://github.com/ankane/dexter"
  url "https://github.com/ankane/dexter/archive/v0.3.6.tar.gz"
  sha256 "f71f00513554af6f1cb5ea281d1b983db6710336bed7bcc6864a4b0a4cd69e06"

  depends_on "libpq"

  resource "pg" do
    url "https://rubygems.org/gems/pg-1.2.3.gem"
    sha256 "f2e71e101eb7fc297222fa9a277a89a9686729a8dfa416d46408e696b5cfae8e"
  end

  resource "pg_query" do
    url "https://rubygems.org/gems/pg_query-1.0.1.gem"
    sha256 "1b90ce1aa86b520c8912a501209617f25b79173c3653de56df4faf3b1cfdd9b1"
  end

  resource "slop" do
    url "https://rubygems.org/gems/slop-4.8.0.gem"
    sha256 "fae9fbfd4aea2470e47f42322d60ba547051027eb70816e1d01f36f0aa4df456"
  end

  def install
    ENV["ARCHFLAGS"] = "-arch x86_64"
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
