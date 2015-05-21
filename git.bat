git init
git add .
git commit -a -m "Initial commit"
cd .emacs.d

cd mode
git submodule add https://github.com/company-mode/company-mode.git
git submodule add https://github.com/rust-lang/rust-mode.git

git submodule add https://github.com/haskell/haskell-mode.git
git submodule add git://jblevins.org/git/markdown-mode.git
cd ..
cd auto-complete
git submodule add https://github.com/auto-complete/auto-complete.git
git submodule add https://github.com/brianjcj/auto-complete-clang.git
git submodule add https://github.com/auto-complete/fuzzy-el.git
git submodule add https://github.com/auto-complete/popup-el.git
git submodule add https://github.com/capitaomorte/yasnippet.git
cd ..

cd project

git submodule add https://github.com/ecb-home/ecb.git
git commit -a -m "submodule add success"

git remote add origin https://github.com/hellmonky/configuration.git

git push -u origin master