class Vector < Formula
  desc "An unobtrusive vector implementation in C"
  homepage "https://github.com/ktchen14/vector/"
  url "https://github.com/ktchen14/vector/releases/download/v0.0.2/vector-0.0.2.tar.xz"
  sha256 "4a2a066070d6e599f19cdd41b91714745933b1f7e4fe73d64ec63e42fba0417f"
  license "LGPL-3.0"

  def install
    system "./configure", *std_configure_args, "--disable-silent-rules"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <assert.h>
      #include <vector.h>

      int main() {
        vector_t(size_t) vector = vector_create();

        for (size_t i = 0; i < 20; i++)
          vector = vector_append(vector, &i);

        for (size_t i = 0; i < vector_length(vector); i++)
          assert(vector[i] == i);
        assert(vector_length(vector) == 20);

        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lvector", "-o", "test"
    system "./test"
  end
end
