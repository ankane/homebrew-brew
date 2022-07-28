class Dexter < Formula
  desc "Automatic indexer for Postgres"
  homepage "https://github.com/ankane/dexter"
  url "https://github.com/ankane/dexter/archive/v0.4.0.tar.gz"
  sha256 "e5bec6c6491500e3ff269c752bb339cd749a1c4f2c6f2c7c35f778c91cf228bb"
  license "MIT"

  depends_on "libpq"

  resource "google-protobuf" do
    url "https://rubygems.org/gems/google-protobuf-3.21.4.gem"
    sha256 "3731263050ffc2b4fb1e3cdde13c34828f2ef057c1bd410e2ffc637b6ea8e795"
  end

  resource "pg" do
    url "https://rubygems.org/gems/pg-1.4.2.gem"
    sha256 "faefc10f8b94b78f62f36923ada3a1412d89dbd4573afd7c91d0d55bf0195ed6"
  end

  resource "pg_query" do
    url "https://rubygems.org/gems/pg_query-2.1.3.gem"
    sha256 "f3dd4b4c88c638eab48e9274f0dd88c584b60f8da58e3008b873192fe1e47001"
  end

  resource "slop" do
    url "https://rubygems.org/gems/slop-4.9.2.gem"
    sha256 "5edcfaa749f3c978a7f8976520c8ec8aa174c3d5a1fcc52f05932eb7e442f2b5"
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
