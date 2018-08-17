class Pgslice < Formula
  desc "Postgres partitioning as easy as pie"
  homepage "https://github.com/ankane/pgslice"
  url "https://github.com/ankane/pgslice/archive/v0.4.3.tar.gz"
  sha256 "b52804afeb5f13b40d09d0678b1d4e78d230337ea74d641639cf139458cefe68"

  depends_on "libpq"
  depends_on "ruby" if MacOS.version <= :sierra

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
    expected = "Set PGSLICE_URL"
    assert_match(expected, out)
  end
end
