class Pgslice < Formula
  desc "Postgres partitioning as easy as pie"
  homepage "https://github.com/ankane/pgslice"
  url "https://github.com/ankane/pgslice/archive/v0.7.0.tar.gz"
  sha256 "9a43932c4e75f83cc7d984ee7d17447bba53dec48f844e9228fbf65f1b9be4dc"
  license "MIT"

  depends_on "libpq"
  depends_on "ruby"

  resource "pg" do
    url "https://rubygems.org/gems/pg-1.5.9.gem"
    sha256 "761efbdf73b66516f0c26fcbe6515dc7500c3f0aa1a1b853feae245433c64fdc"
  end

  resource "thor" do
    url "https://rubygems.org/gems/thor-1.3.2.gem"
    sha256 "eef0293b9e24158ccad7ab383ae83534b7ad4ed99c09f96f1a6b036550abbeda"
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
