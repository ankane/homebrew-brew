class Pgsync < Formula
  desc "Sync Postgres data between databases"
  homepage "https://github.com/ankane/pgsync"
  url "https://github.com/ankane/pgsync.git",
      :tag => "v0.5.2",
      :revision => "707abec8b13d26aa6d4807b8e3a2072f5b3e8907"

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
