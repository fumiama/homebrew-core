class Udptunnel < Formula
  desc "Tunnel UDP packets over a TCP connection"
  # The original webpage (and download) is still available at the original
  # site, but currently www.cs.columbia.edu returns a 404 error if you
  # try to fetch them over https instead of http
  homepage "http://www1.cs.columbia.edu/~lennox/udptunnel/"
  url "https://pkg.freebsd.org/ports-distfiles/udptunnel-1.1.tar.gz"
  mirror "https://sources.voidlinux.org/udptunnel-1.1/udptunnel-1.1.tar.gz"
  sha256 "45c0e12045735bc55734076ebbdc7622c746d1fe4e6f7267fa122e2421754670"
  license "BSD-3-Clause"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "d90e8491c09fa77d47d0dc1eae46ec206382a3dff72a4cb6473d88fc155d8a9d"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "d00e56cd2e956452a8529f53ffdec24393bedbd3b0ecec22d24051fc12ca80a2"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "7f926b82af867d217a020a55be4f21de045b846aa5e3ca584a09629d4529a5c8"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "1cd9168b47649ced46a6bc58b90d8bb9cf6031fe3f839101743ca5b6dda3efbf"
    sha256 cellar: :any_skip_relocation, sonoma:         "52153a3000c3b2ac9aee259a0196d46aa72d3421da89a1b4d43c6bc608b21722"
    sha256 cellar: :any_skip_relocation, ventura:        "21017d293a334d6248140bf92afa95465c36c2db8cab3098d8e0021c4e25e837"
    sha256 cellar: :any_skip_relocation, monterey:       "25b3c9254ca0a49a807e1bbf4547191c796e55a0cf9c8575653660611ca4189d"
    sha256 cellar: :any_skip_relocation, big_sur:        "bfb564a4529a508338776cc02b0b4fcd63ceead924db45ef73f4c41c79f96908"
    sha256 cellar: :any_skip_relocation, catalina:       "de4e78f6f0ff861478dae683d1a6c09ae38e9a9e7ec8780a90a9b849df422089"
    sha256 cellar: :any_skip_relocation, mojave:         "46dca7ebedab0825acffeafa11b6090676993a5b7b4a53591db51cc7b856e048"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8011c8ad2ef6699b3b100f259cd8e6db4ae8a799721635b06ae2a259c084c9b5"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  on_linux do
    depends_on "libnsl"
  end

  def install
    # Fix compile with newer Clang
    ENV.append_to_cflags "-Wno-implicit-function-declaration" if DevelopmentTools.clang_build_version >= 1200

    system "autoreconf", "--verbose", "--install", "--force"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
    doc.install "udptunnel.html"
  end

  test do
    system "#{bin}/udptunnel -h; true"
  end
end
