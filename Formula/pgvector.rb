class Pgvector < Formula
  desc "Open-source vector similarity search for Postgres"
  homepage "https://github.com/ankane/pgvector"
  url "https://github.com/ankane/pgvector/archive/v0.1.4.tar.gz"
  sha256 "a654232b55d52a76fe28c49ac221d1606aafa58caa94c6727768ab1789b60f22"
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
