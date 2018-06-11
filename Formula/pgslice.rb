class Pgslice < Formula
  desc "Postgres partitioning as easy as pie"
  homepage "https://github.com/ankane/pgslice"
  url "https://github.com/ankane/pgslice.git",
      :tag => "v0.4.1",
      :revision => "223e2dd7cd5903fa6d817b3597a0a4027e86f8a3"

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
    system "#{bin}/pgslice", "--version"
  end
end
