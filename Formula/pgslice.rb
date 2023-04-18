class Pgslice < Formula
  desc "Postgres partitioning as easy as pie"
  homepage "https://github.com/ankane/pgslice"
  url "https://github.com/ankane/pgslice/archive/v0.5.0.tar.gz"
  sha256 "25be11b5a5f3c0ea69e9f7093cde7abef1d889774a0b57e3859e624cd92fa6bf"
  license "MIT"

  depends_on "libpq"
  depends_on "ruby"

  resource "pg" do
    url "https://rubygems.org/gems/pg-1.4.5.gem"
    sha256 "c139bd34907e7bbe3291a9b5e651bcf00de1f8a99a3148c064bc2d1b10b5a6f1"
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
