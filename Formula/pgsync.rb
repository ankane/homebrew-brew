class Pgsync < Formula
  desc "Sync Postgres data between databases"
  homepage "https://github.com/ankane/pgsync"
  url "https://github.com/ankane/pgsync.git",
      :tag => "v0.4.0",
      :revision => "c7a4dc6a06f6577e7d7266d1f5ed69019ddf5a87"

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
    system "#{bin}/pgsync", "--setup"
  end
end
