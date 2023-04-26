class Pgslice < Formula
  desc "Postgres partitioning as easy as pie"
  homepage "https://github.com/ankane/pgslice"
  url "https://github.com/ankane/pgslice/archive/v0.6.1.tar.gz"
  sha256 "8f662df9828fc89a7e10c2c6516d612c44dbf81a574bf5664ce1c36ae5dacce5"
  license "MIT"

  depends_on "libpq"
  depends_on "ruby"

  resource "pg" do
    url "https://rubygems.org/gems/pg-1.5.2.gem"
    sha256 "34b5ce89dcf627549695e877368c09b3f27cfa9378ec7a6e9472ec348d2b4ae2"
  end

  resource "thor" do
    url "https://rubygems.org/gems/thor-1.2.1.gem"
    sha256 "b1752153dc9c6b8d3fcaa665e9e1a00a3e73f28da5e238b81c404502e539d446"
  end

  def install
    ENV["GEM_HOME"] = libexec
    ENV["PG_CONFIG"] = Formula["libpq"].opt_bin/"pg_config"

    resources.each do |r|
      r.fetch
      system "gem", "install", r.cached_download, "--ignore-dependencies",
             "--no-document", "--install-dir", libexec
    end

    system "gem", "build", "pgslice.gemspec"
    system "gem", "install", "--ignore-dependencies", "pgslice-#{version}.gem"

    bin.install libexec/"bin/pgslice"
    bin.env_script_all_files(libexec/"bin", GEM_HOME: ENV["GEM_HOME"])
  end

  test do
    out = pipe_output("#{bin}/pgslice prep users created_at day 2>&1")
    assert_match "Set PGSLICE_URL", out
  end
end
