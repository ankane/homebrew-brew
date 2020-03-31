class Pgsync < Formula
  desc "Sync Postgres data between databases"
  homepage "https://github.com/ankane/pgsync"
  url "https://github.com/ankane/pgsync/archive/v0.5.2.tar.gz"
  sha256 "fb324de20527f2059226d216089c2ef2e1f20c0c1cda0402a145ba3476520324"

  depends_on "libpq"

  def install
    ENV["ARCHFLAGS"] = "-arch x86_64"
    ENV["PG_CONFIG"] = Formula["libpq"].opt_bin/"pg_config"
    ENV["GEM_HOME"] = libexec
    system "gem", "build", "pgsync.gemspec"
    system "gem", "install", "pgsync-#{version}.gem"
    bin.install libexec/"bin/pgsync"
    bin.env_script_all_files(libexec/"bin", :GEM_HOME => ENV["GEM_HOME"])
  end

  test do
    system "#{bin}/pgsync", "--init"
    assert File.exist?(".pgsync.yml")
  end
end
