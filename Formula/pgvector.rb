class Pgvector < Formula
  desc "Open-source vector similarity search for Postgres"
  homepage "https://github.com/ankane/pgvector"
  url "https://github.com/ankane/pgvector/archive/v0.2.1.tar.gz"
  sha256 "f5d7d038f826498fb4908d9dca66c2e7c75ac6350f5af9eb63f47dead244f6a8"
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
