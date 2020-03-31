class Dexter < Formula
  desc "Automatic indexer for Postgres"
  homepage "https://github.com/ankane/dexter"
  url "https://github.com/ankane/dexter/archive/v0.3.5.tar.gz"
  sha256 "d31d2d4b5e15aff02f9c4ecd7e5367aa5aeb1d4608b209bd02981a0249e82af1"

  depends_on "libpq"

  def install
    ENV["ARCHFLAGS"] = "-arch x86_64"
    ENV["PG_CONFIG"] = Formula["libpq"].opt_bin/"pg_config"
    ENV["GEM_HOME"] = libexec
    system "gem", "build", "pgdexter.gemspec"
    system "gem", "install", "pgdexter-#{version}.gem"
    bin.install libexec/"bin/dexter"
    bin.env_script_all_files(libexec/"bin", :GEM_HOME => ENV["GEM_HOME"])
  end

  test do
    system "#{bin}/dexter", "--version"
  end
end
