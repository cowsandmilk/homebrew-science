class Libccd < Formula
  homepage "http://libccd.danfis.cz"
  url "https://github.com/danfis/libccd/archive/v2.0.tar.gz"
  sha256 "1b4997e361c79262cf1fe5e1a3bf0789c9447d60b8ae2c1f945693ad574f9471"
  head "https://github.com/danfis/libccd.git"
  revision 1

  bottle do
    cellar :any
    sha256 "7999af74157e062e80303402040c478a3d3079eff2bbec84e8571e5dd8b173b5" => :yosemite
    sha256 "7e298d160eb7dfdeb5cc4d551773c46313b05bc9abf33117b984b4eda23a1441" => :mavericks
    sha256 "7a4f9d8fcdf13d2ae3bf8abb88413d5ed2cb3686d230c7fb5aa6c32689a58ba1" => :mountain_lion
  end

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<-EOS.undent
      #include <ccd/vec3.h>
      int main() {
        ccdVec3PointSegmentDist2(
          ccd_vec3_origin, ccd_vec3_origin,
          ccd_vec3_origin, NULL);
        return 0;
      }
    EOS
    system ENV.cc, "-o", "test", "test.c", "-L#{lib}", "-lccd"
    system "./test"
  end
end
