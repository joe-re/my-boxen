class people::joe1014 {
  # 自分の環境で欲しいresourceをincludeする
  include iterm2::stable

  $home     = "/Users/${::luser}"
  $src      = "${home}/src"
  $dotfiles = "${src}/dotfiles"

  # ~/src/dotfilesにGitHub上のjoe1014/dotfilesリポジトリを
  # git-cloneする。そのとき~/srcディレクトリがなければいけない。
  repository { $dotfiles:
    source  => "joe1014/dotfiles",
    require => File[$src]
  }
  # git-cloneしたらインストールする
  exec { "sh ${dotfiles}/install.sh":
    cwd => $dotfiles,
    creates => "${home}/.zshrc",
    require => Repository[$dotfiles],
  }
  package {
    'Kobito':
      source   => "http://kobito.qiita.com/download/Kobito_v1.2.0.zip",
      provider => compressed_app;
  }

}
