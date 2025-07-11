class Disco < Formula
  desc "Generate recommendations from CSV files"
  homepage "https://github.com/ankane/disco-cli"
  if OS.linux?
    url "https://github.com/ankane/disco-cli/releases/download/v0.1.2/disco-cli-0.1.2-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "51c3532d4b6de74966ce2d2bb8c33b4ffdaf81b5f219b7bc444f4b1e56880ec5"
  elsif Hardware::CPU.arm?
    url "https://github.com/ankane/disco-cli/releases/download/v0.1.2/disco-cli-0.1.2-aarch64-apple-darwin.tar.gz"
    sha256 "6970c511a5e1743113e9dc81f0510e569e281758cdd1cba77140e7aba81f7b37"
  else
    url "https://github.com/ankane/disco-cli/releases/download/v0.1.2/disco-cli-0.1.2-x86_64-apple-darwin.tar.gz"
    sha256 "74dd7eb0c777b9267b73c5d172b7366d5b9707118595ad717e8f1552888b5031"
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
    assert_path_exists testpath/"output.csv"
  end
end
