class Fluxzero < Formula
  desc "Develop, test, and manage Fluxzero applications"
  homepage "https://fluxzero.io"
  license "EUPL-1.2"

  on_macos do
    on_arm do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.13/flux-macos-arm64"
      sha256 "318ad5ce55469519e536d6729c18cc479ad6697e613eb605afb8f2ea4daf8651"
    end

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.13/flux-macos-amd64"
      sha256 "307e7abd6eca9dffaf0109904bb88f5e5b59add68aaf095ceae2e776897a30cc"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    on_intel do
      url "https://github.com/fluxzero-io/fluxzero-cli/releases/download/1.21.13/flux-linux-amd64"
      sha256 "4c51e5f15c85d36f5c1acda40bab52adbe5c1cede0961a6cc7e7728f893ec02f"
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
