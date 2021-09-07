class Pgvector < Formula
  desc "Open-source vector similarity search for Postgres"
  homepage "https://github.com/ankane/pgvector"
  url "https://github.com/ankane/pgvector/archive/v0.1.8.tar.gz"
  sha256 "6dffe5d773c3946bee05464e3aaedbf93b9ce6b8d0ae00e559d342cdd57741b8"
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
