class Dexter < Formula
  desc "Automatic indexer for Postgres"
  homepage "https://github.com/ankane/dexter"
  url "https://github.com/ankane/dexter/archive/v0.4.2.tar.gz"
  sha256 "915d3fc262bbb918e25ba4fdda441f89cd8b375ad647020609ed8bc4d270e8ea"
  license "MIT"

  depends_on "libpq"

  resource "google-protobuf" do
    url "https://rubygems.org/gems/google-protobuf-3.21.12.gem"
    sha256 "4b09bb7e3168cda689efebcd3373304e124b14aabf776fbf1f0a7615259c8fb5"
  end

  resource "pg" do
    url "https://rubygems.org/gems/pg-1.4.5.gem"
    sha256 "c139bd34907e7bbe3291a9b5e651bcf00de1f8a99a3148c064bc2d1b10b5a6f1"
  end

  resource "pg_query" do
    url "https://rubygems.org/gems/pg_query-2.2.1.gem"
    sha256 "6086972bbf4eab86d8425b35f14ca8b6fe41e4341423582801c1ec86ff5f8cea"
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
