class Dexter < Formula
  desc "Automatic indexer for Postgres"
  homepage "https://github.com/ankane/dexter"
  url "https://github.com/ankane/dexter.git",
      :tag => "v0.3.5",
      :revision => "3932e84fae9404520b2c45b9eaa06d5674322822"

  depends_on "libpq"
  depends_on "ruby" if MacOS.version <= :sierra

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
