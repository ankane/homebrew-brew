class Pgvector < Formula
  desc "Open-source vector similarity search for Postgres"
  homepage "https://github.com/ankane/pgvector"
  url "https://github.com/ankane/pgvector/archive/v0.1.6.tar.gz"
  sha256 "f36e0d7fbd7067eb191deb6e4536f75ac4b8b8b4cd95072263b721b98dc4d55e"
  license "PostgreSQL"

  depends_on "postgresql"

  def install
    system "make"

    mkdir "stage"
    system "make", "install", "DESTDIR=#{buildpath}/stage"

    lib.install Dir["stage/**/lib/*"]
  end

  test do
  end
end
