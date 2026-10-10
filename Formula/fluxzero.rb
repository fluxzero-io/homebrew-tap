class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.19.6/flux-macos-arm64"
      sha256 "ba502a808073c2c5718271672711e7aae12c3405401796010c75fb2b8c7cdb07"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.19.6/flux-macos-amd64"
      sha256 "f79c4666aaa381b09a59a0fd6083e4ae49ea723d7d516bd05e3ba62093ba1602"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.19.6/flux-linux-amd64"
      sha256 "ee0b8d9f73b12bf5bc6d8e97375c5e300b90d842afd2ba7a00e7563eb208c22b"
    end
  end

  def install
    binary = if OS.mac?
      Hardware::CPU.arm? ? "flux-macos-arm64" : "flux-macos-amd64"
    else
      "flux-linux-amd64"
    end

    bin.install binary => "fz"
    bin.install_symlink "fz" => "fluxzero"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/fz version")
    assert_equal "fz", File.basename(File.readlink(bin/"fluxzero"))
  end
end
