class Samtools < Formula
  desc "Tools for manipulating next-generation sequencing data"
  homepage "https://www.htslib.org/"
  url "https://github.com/samtools/samtools/releases/download/1.11/samtools-1.11.tar.bz2"
  sha256 "e283cebd6c1c49f0cf8a3ca4fa56e1d651496b4d2e42f80ab75991a9ece4e5b6"
  license "MIT"

  bottle do
    cellar :any
    sha256 "53c31e536e1f0a98e2dba30eddb61a782bf14b45ebf12e56973788f3427c1bac" => :catalina
    sha256 "18abf7b1a130579066fa055116589cfc7ca4d20842408d7038470ebd612e8a85" => :mojave
    sha256 "b9be0c12847087c47e0a1d9776d77795d35f98ed3373963564453de15c40437a" => :high_sierra
  end

  depends_on "htslib"

  uses_from_macos "ncurses"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--with-htslib=#{Formula["htslib"].opt_prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.fasta").write <<~EOS
      >U00096.2:1-70
      AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC
    EOS
    system bin/"samtools", "faidx", "test.fasta"
    assert_equal "U00096.2:1-70\t70\t15\t70\t71\n", (testpath/"test.fasta.fai").read
  end
end
