class Dexter < Formula
  desc "Automatic indexer for Postgres"
  homepage "https://github.com/ankane/dexter"
  url "https://github.com/ankane/dexter/archive/v0.3.7.tar.gz"
  sha256 "ce880ac9ecc442057f69a42d15a9e869029d3c3e2b4b26f8016295b18768df57"
  license "MIT"

  depends_on "libpq"

  resource "pg" do
    url "https://rubygems.org/gems/pg-1.2.3.gem"
    sha256 "f2e71e101eb7fc297222fa9a277a89a9686729a8dfa416d46408e696b5cfae8e"
  end

  resource "pg_query" do
    url "https://rubygems.org/gems/pg_query-1.2.0.gem"
    sha256 "a10a84abc09a7486bc0693664013e4395301914aafc330792bdbd4adec373a5d"
  end

  resource "slop" do
    url "https://rubygems.org/gems/slop-4.8.2.gem"
    sha256 "a3d5be3ad304b9dbd00b7c18a0a067b09ff6fd28485d4c6b05adb294d1eea115"
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
