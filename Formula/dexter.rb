class Dexter < Formula
  desc "Automatic indexer for Postgres"
  homepage "https://github.com/ankane/dexter"
  url "https://github.com/ankane/dexter/archive/v0.4.1.tar.gz"
  sha256 "0fc0efda7b30477bb3a8eff80f86a4ea3742fae0e1fab6eeba351184d2fda44c"
  license "MIT"

  depends_on "libpq"

  resource "google-protobuf" do
    url "https://rubygems.org/gems/google-protobuf-3.21.4.gem"
    sha256 "3731263050ffc2b4fb1e3cdde13c34828f2ef057c1bd410e2ffc637b6ea8e795"
  end

  resource "pg" do
    url "https://rubygems.org/gems/pg-1.4.4.gem"
    sha256 "a3877f06e3548a01ffdeb1c1c8cc751db6e759c0020b133a54cbdb0e71fa4525"
  end

  resource "pg_query" do
    url "https://rubygems.org/gems/pg_query-2.1.4.gem"
    sha256 "48f1363f88cf9d86fa11d76d1b0f839ca3723b8bd397b7cbc4b578e1ca82d0bb"
  end

  resource "slop" do
    url "https://rubygems.org/gems/slop-4.9.3.gem"
    sha256 "6e26dfdb549f45d75f5f843f4c1b6267f34b6604ca8303086946f97ff275e933"
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
    bin.env_script_all_files(libexec/"bin", GEM_HOME: ENV["GEM_HOME"])
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dexter --version")
  end
end
