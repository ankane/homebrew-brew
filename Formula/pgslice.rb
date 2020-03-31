class Pgslice < Formula
  desc "Postgres partitioning as easy as pie"
  homepage "https://github.com/ankane/pgslice"
  url "https://github.com/ankane/pgslice/archive/v0.4.5.tar.gz"
  sha256 "da34793f93f39544cc384a90bc7f4f38c233e924c75881d4a3ef1186c952d1b2"

  depends_on "libpq"

  def install
    ENV["ARCHFLAGS"] = "-arch x86_64"
    ENV["PG_CONFIG"] = Formula["libpq"].opt_bin/"pg_config"
    ENV["GEM_HOME"] = libexec
    system "gem", "build", "pgslice.gemspec"
    system "gem", "install", "pgslice-#{version}.gem"
    bin.install libexec/"bin/pgslice"
    bin.env_script_all_files(libexec/"bin", :GEM_HOME => ENV["GEM_HOME"])
  end

  test do
    out = pipe_output("#{bin}/pgslice prep users created_at day 2>&1")
    assert_match "Set PGSLICE_URL", out
  end
end
