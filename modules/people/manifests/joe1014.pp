class people::joe1014 {
  # 自分の環境で欲しいresourceをincludeする
  include iterm2::stable
  include macvim_kaoriya
  include chrome

  $home     = "/Users/${::luser}"
  $src      = "${home}/src"
  $dotfiles = "${src}/dotfiles"

  # ~/src/dotfilesにGitHub上のjoe1014/dotfilesリポジトリを
  # git-cloneする。そのとき~/srcディレクトリがなければいけない。
  repository { $dotfiles:
    source  => "joe1014/dotfiles",
    require => File[$src];

    "${home}/.vim/bundle/neobundle.vim":
    source  => "Shougo/neobundle.vim";
  }
  # git-cloneしたらインストールする
  exec { "sh ${dotfiles}/install.sh":
    cwd => $dotfiles,
    creates => "${home}/.zshrc",
    require => Repository[$dotfiles],
  }
  package {
    'Kobito':
      source   => "http://kobito.qiita.com/download/Kobito_v1.8.7.zip",
      provider => compressed_app;
    'KeyRemap4MacBook':
      source   => "https://pqrs.org/macosx/keyremap4macbook/files/KeyRemap4MacBook-9.2.0.dmg",
      provider => pkgdmg;
    'SimpleCap':
      source   => "http://xcatsan.com/simplecap/download/SimpleCap-1.2.1.zip",
      provider => compressed_app;
  }

}
