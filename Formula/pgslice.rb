class Pgslice < Formula
  desc "Postgres partitioning as easy as pie"
  homepage "https://github.com/ankane/pgslice"
  url "https://github.com/ankane/pgslice/archive/v0.4.2.tar.gz"
  sha256 "e0f0bcc8bcd0e883b8bd37965f4528e6239b58afaa416cd549db96b1d3f06936"

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
    system "#{bin}/pgslice", "--version"
  end
end
