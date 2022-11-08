class Disco < Formula
  desc "Generate recommendations from CSV files"
  homepage "https://github.com/ankane/disco-cli"
  if OS.linux?
    url "https://github.com/ankane/disco-cli/releases/download/v0.1.1/disco-cli-0.1.1-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "9e8d16ff1ce0664cd09d22e535a56a444ae96dbfad771161d27b31651767cd4a"
  elsif Hardware::CPU.arm?
    url "https://github.com/ankane/disco-cli/releases/download/v0.1.1/disco-cli-0.1.1-aarch64-apple-darwin.tar.gz"
    sha256 "9f8f1faf6292df020fd25b7f6f652e4e44aa508bc638c8d0bedbc3c60948cdb0"
  else
    url "https://github.com/ankane/disco-cli/releases/download/v0.1.1/disco-cli-0.1.1-x86_64-apple-darwin.tar.gz"
    sha256 "2d32367b2a7193a2f66ae1af4dc988aa3f005aa81db107e3cc0babf27b25a652"
  end
  license "MIT"

  def install
    bin.install "disco"
    prefix.install Dir["*"]
  end

  test do
    (testpath/"data.csv").write <<~EOS
      user_id,item_id,rating
      1,post1,5
      1,post2,3.5
      2,post1,4
    EOS

    system bin/"disco", "user-recs", "data.csv", "output.csv"
    assert_predicate testpath/"output.csv", :exist?
  end
end
