class Pgvector < Formula
  desc "Open-source vector similarity search for Postgres"
  homepage "https://github.com/ankane/pgvector"
  url "https://github.com/ankane/pgvector/archive/v0.1.0.tar.gz"
  sha256 "dec99e47233044585a0f48f4488fa6ebd0706f156a257a9b788a39a065ba9509"
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
