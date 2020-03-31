class Dexter < Formula
  desc "Automatic indexer for Postgres"
  homepage "https://github.com/ankane/dexter"
  url "https://github.com/ankane/dexter/archive/v0.3.6.tar.gz"
  sha256 "f71f00513554af6f1cb5ea281d1b983db6710336bed7bcc6864a4b0a4cd69e06"

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
