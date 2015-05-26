# emacs.d
>emacs configuration for general and windows
>***by hellmonky***

## 前言
自己之前根据网上的教程安装配置过emacs，然后用几下就不了了之了，原因有三个：
>1.windows平台下提供的IDE支持很丰富和强大，例如VS对C++的支持已经很好了，更何况对C#的支持，所以相比之下emacs复杂的配置和使用对自己的吸引不大；
>2.emacs的配置说明混乱，因为emacs是GUN的明星产品，而且由来已久，整个架构还是有不足指出，例如对插件的管理等，所以辛苦配置的东西不一定能用也是关键；
>3.自己的畏惧心理，当初自己看到emacs之后感觉不会用，并且被别人推荐说是最强的编辑器，所以心理有畏惧状况，并且在配置的时候不懂ELisp也是自己导致心理障碍的原因。

再次安装emacs的出发点：
通过长时间的编程学习和实践，现在对于程序编写有了更清晰的认识，知道了使用工具的帮助虽然可以快速的编程，但是速度快并不能代表效率高，很多函数或者程序流程如果自己无法掌握，那么也就无法开发出良好的程序了，所以说开发程序的核心还是在于人，那么一个可以广泛支持的编辑器是非常有必要了；然后需要设置emacs中的外部可执行文件命令来调用clang； >emacs可以识别两种命令： >>(1) PAHT： 无论在什么系统下，将某个可执行文件的目录加入PATH环境变量，就可以在命令行下使用这个命令，无论这个命令放在哪里。所以，emacs启动时的PATH变量，
并且通过学习scheme教程SICP加深了自己对lisp系列语言的认识，这个也为emacs的内置elisp语言有了一个认识，可以通过配置代码知道了设置的流程。
所以综上两个原因，决定再次学习并且重新配置一个自己使用的emacs来再次尝试一下。

##（1）windows下emacs的安装：
emacs是Linux下的优秀编辑器，没有windows的原生支持，所以需要使用预编译的安装文件或者自己手动使用mingw从源代码编译为可执行文件。
目前windows下可以用的版本有：
>（1）[X86的官方编译版本](https://ftp.gnu.org/gnu/emacs/windows/)；
>>（2）一个中国人维护的[X64编译版本](http://emacsbinw64.sourceforge.net/)。

这两个版本，官方编译版本比较老而且只有32位程序，个人维护的版本比较新但是稳定性不确定。

>当然自己根据chris在其个人[主页](http://chriszheng.science/)上给出了的[编译教程](http://chriszheng.science/2015/03/19/Chinese-version-of-Emacs-building-guideline/)来进行编译安装，从emacs的[github托管](https://github.com/emacs-mirror/emacs)下载最新的源代码完成编译。



##（2）windows下的基本执行环境配置：
在windows下的环境变量中添加：
```shell
HOME:当前emacs的配置路径
```
emacs会读入这个环境变量指定的路径来载入默认配置文件。
>注意：这种方法非常不好，因为windows下还有其他程序依赖于HOME环境变量，这样的设置会将其他程序的文件也放在emacs的配置文件夹下。

打开bin路径下的runemacs.exe就会自动加载emacs并且启动，在options下修改任意一个配置，然后save就会在HOME设置的路径下产生：
```shell
.emacs
.emacs.d
```
其中的.emacs就是默认配置文件，主要用来载入其中的elisp代码对emacs进行配置，也是我们主要进行配置的文件；.emacs.d文件夹主要用来存放插件的脚本，主要用来保存第三方插件代码。

##（3）emacs核心
emacs使用ELisp编程来完成功能扩展，按照wiki上的介绍：

	Emacs本质是一个用Elisp构建的插件框架、通过热替换的机制在运行时动态的修改和扩展自己。

所以emacs也被称为伪装成为编辑器的操作系统，官方自带的ELisp手册就是权威指导，最好能够根据当前的emacs版本支持的elisp解释器版本来确定语法，然后在这个基础上对当前出现的问题有一个正确的处理。

可以通过学习elisp来自己实现一些基本功能扩展，从而达到定制的效果。

在emacs的24版本中，nil和0的区别还没有看到官方说明，部分插件只能选取其中的一个支持。

>第三方库就是别人已经完成的elisp代码包，用于对emacs原有功能的增强和补充。emacs提供了基本的编辑器支持，并且内置了elisp解释器和基本编辑功能接口，所以可以通过第三方插件来不断的开发emacs可以支持的内容。
下面列举出一些被广泛使用的插件来帮助自己定制适合自己使用的emacs。

##（4）使用24版本之后内置的“市场”elpa，安装插件
emacs24更新的最大亮点就是内建ELPA支持,之前的版本是需要自己下载安装的。ELPA是一个emacs的插件包管理系统,可以帮你下载相应的插件，并添加相应的load-path等。
使用M+x打开命令，输入：
```shell
package-initialize
```
就会在默认目录下生成elpa文件夹，然后输入：
```shell
package-install 名称
```
就会自动安装对应名称的插件和其依赖包。

>现在用安装haskell mode为例，打开emacs，然后输入：
```shell
M-x package-initialize
```
首先初始化变量package-archives，否则elpa因为该变量为空报错
```shell
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))
```
然后按照[wiki](https://github.com/haskell/haskell-mode)的说明，在.emacs文件中添加相关的来源：
```shell
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
```
在emacs中使用
```shell
M-x package-refresh-contents
```
刷新当前的库内容，然后使用
```shell
M-x package-install
```
进入安装模式，输入：
```shell
haskell-mode
```
完成安装。要使用haskell mode还需要进一步在.emacs文件中引入安装的haskell mode包
```shell
(add-to-list 'load-path  "~/.emacs.d/elpa/haskell-mode-20150519.904")
```
然后按照[官方给出的配置](https://github.com/haskell/haskell-mode/wiki/Haskell-Interactive-Mode-Setup)设置如下：
```shell
;;支持tab缩进模式
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)
(require 'haskell-interactive-mode)
(require 'haskell-process)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(custom-set-variables
  '(haskell-process-suggest-remove-import-lines t)
  '(haskell-process-auto-import-loaded-modules t)
  '(haskell-process-log t))
(define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
(define-key haskell-mode-map (kbd "C-`") 'haskell-interactive-bring)
(define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
(define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
(define-key haskell-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
(define-key haskell-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
(define-key haskell-mode-map (kbd "C-c c") 'haskell-process-cabal)
(define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)
(define-key haskell-cabal-mode-map (kbd "C-`") 'haskell-interactive-bring)
(define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
(define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
(define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)
;;最重要的是选择ghci作为交互界面，使用cabal-repl无法对简单的hs文件交互
(custom-set-variables
  '(haskell-process-type 'ghci))
```
>>当然还可以直接从github同步源代码，然后添加上述的基本设置就可以了。


##（5）手动安装第三方插件
与上述内置的elpa支持类似，我们也可以手动安装插件并且配置，本文的后续配置也主要采用这种方式完成。好处在于可以按照自己的需求下载对应的版本和定制路径，缺点是版本依赖需要自己注意。
>题外话：配置emacs就像手动写IDE一样繁琐，但是也体现了开放和定制的特点。
>最高境界可能就是自己使用elisp完成所有插件能完成的功能吧

**在下面的所有配置中，emacs默认的路径为HOME设定的路径，用~表示。**

### <1>主题和字体支持
>所有主题相关的插件统一放置在HOME目录下的color-theme子文件夹下

#### 1. 主题和颜色插件color-theme
[color-theme](http://www.nongnu.org/color-theme/)是emacs下最为出名的插件，因为一个好的编辑器一定要能定制主题显示，color-theme就是主题管理和颜色主题的优秀插件。从[官方下载地址](http://download.savannah.gnu.org/releases/color-theme/)可以看到最新为6.6.0版本，也很久没有更新了。

主题显示中很多人都首选[solarized](http://ethanschoonover.com/solarized)主题。github上[sellout](https://github.com/sellout/emacs-color-theme-solarized)上放出了自己的定制版本，可以下载使用。
主题下载之后需要进行定制
```shell
;;首先将主题路径加载
(add-to-list 'custom-theme-load-path "~/.emacs.d/color-theme/emacs-color-theme-solarized/")
;;然后启动主题
(load-theme 'solarized t)
;;设置全局主题为dark系列，并且让设置生效
(set-frame-parameter nil 'background-mode 'dark)
(set-terminal-parameter nil 'background-mode 'dark)
(enable-theme 'solarized)
(add-hook 'after-make-frame-functions
          (lambda (frame)
            (set-frame-parameter frame
                                 'background-mode
                                 (if (display-graphic-p frame) 'light 'dark))
            (enable-theme 'solarized)))
```

#### 2. 字体显示设置：
因为主题设置完毕之后字体显示还是很重要的，在[这个网页](http://zhuoqiang.me/torture-emacs.html)上，作者还给出了自己的[设置方案](https://bitbucket.org/zhuoqiang/emacs_configuration/overview)，拿来主义先用上：
>可能存在的[修正情况](http://baohaojun.github.io/perfect-emacs-chinese-font.html)

```shell
;;首先，我们要能判断某个字体在系统中是否存在：
(defun qiang-font-existsp (font)
  (if (null (x-list-fonts font))
      nil
    t))
;;其次，要到用户预定义的字体列表中找出首个存在的字体：
(defvar font-list '("Microsoft Yahei" "文泉驿等宽微米黑" "黑体" "新宋体" "宋体"))
(require 'cl) ;; find-if is in common list package
(find-if #'qiang-font-existsp font-list)
;;还要有个辅助函数，用来产生带上字体大小信息的字体描述文本：
(defun qiang-make-font-string (font-name font-size)
  (if (and (stringp font-size)
           (equal ":" (string (elt font-size 0))))
      (format "%s%s" font-name font-size)
    (format "%s %s" font-name font-size)))
;;自动设置字体函数
(defun qiang-set-font (english-fonts
                       english-font-size
                       chinese-fonts
                       &optional chinese-font-size)

  "english-font-size could be set to \":pixelsize=18\" or a integer.
If set/leave chinese-font-size to nil, it will follow english-font-size"
  (require 'cl) ; for find if
  (let ((en-font (qiang-make-font-string
                  (find-if #'qiang-font-existsp english-fonts)
                  english-font-size))
        (zh-font (font-spec :family (find-if #'qiang-font-existsp chinese-fonts)
                            :size chinese-font-size)))

    ;; Set the default English font
    ;;
    ;; The following 2 method cannot make the font settig work in new frames.
    ;; (set-default-font "Consolas:pixelsize=18")
    ;; (add-to-list 'default-frame-alist '(font . "Consolas:pixelsize=18"))
    ;; We have to use set-face-attribute
    (message "Set English Font to %s" en-font)
    (set-face-attribute 'default nil :font en-font)

    ;; Set Chinese font
    ;; Do not use 'unicode charset, it will cause the English font setting invalid
    (message "Set Chinese Font to %s" zh-font)
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font (frame-parameter nil 'font)
                        charset zh-font))))
;;然后调用字体自动设置函数来实现字体加载
(qiang-set-font
 '("Consolas" "Monaco" "DejaVu Sans Mono" "Monospace" "Courier New") ":pixelsize=18"
 '("Microsoft Yahei" "文泉驿等宽微米黑" "黑体" "新宋体" "宋体"))
;;最后还要增加鼠标滑轮调整字体大小的方式
;; For Linux
(global-set-key (kbd "<C-mouse-4>") 'text-scale-increase)
(global-set-key (kbd "<C-mouse-5>") 'text-scale-decrease)
;; For Windows
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)
```

### <2>自动补全和项目支持相关插件：
>所有主题相关的插件统一放置在HOME目录下的auto-complete子文件夹下

自动补全一直是IDE和一般编辑器的最大差异，良好的补全可以提高开发人员的效率，让人关注于代码的构建本身，而不是记忆基本的函数。
>当然良好的开发人员裸写程序是最基本的要求

#### 1. auto-complete插件：
著名的自动补全插件，现在被托管在[github](https://github.com/auto-complete)上。当前的插件被分为三个子项目：
>[auto-complete](https://github.com/auto-complete/auto-complete)
[fuzzy-el](https://github.com/auto-complete/fuzzy-el)
[popup-el](https://github.com/auto-complete/popup-el)

这三个子项目分别开发，在使用的时候需要将这三个项目都下载然后配置使用。
配置内容如下：
```shell
;;将路径添加到emacs的默认配置文件.emacs中：
(add-to-list 'load-path "path-to-download-folder/fuzzy-el")
(add-to-list 'load-path "path-to-download-folder/popup-el")
(add-to-list 'load-path "path-to-download-folder/auto-complete")
;;接着添加auto-complete默认的字典来完成补全：
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories
             "path-to-download-folder/auto-complete/dict")
(ac-config-default)
```

#### 2. yasnippet
yasnippet is A template system for Emacs。是一个代码片段补全工具，可以用来补全大段的常用的代码片段。现在维护在[github](https://github.com/capitaomorte/yasnippet)上。
相关的设置如下：
```shell
;;添加加载路径，并且打开配置
(add-to-list 'load-path "~/.emacs.d/auto-complete/yasnippet")
(require 'yasnippet)
(yas-global-mode t)
;;然后将yasnippet和auto-complete结合起来完成自动补全过程
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")
```

#### 3. 使用clang补全C++
>主要参考了[这篇文章](http://blog.csdn.net/winterttr/article/category/1081035)来进行设置。

ctags，etags，cscope和cedet都是通过对源代码进行预处理，分析出其包含的代码信息。这种静态分析代码然后补全的方法在代码或者头文件频繁变更的情况下，是非常让人头痛的事情。但是LLVM的前端clang可以通过动态扫面头文件和当前输入的信息来提供补全信息。

1. 首先需要[官方网站](http://llvm.org/releases/download.html)下载并且安装对应的clang程序，将安装之后的bin下的clang.exe和clang++.exe文件提取出来；
2. 然后需要设置emacs中的外部可执行文件命令来调用clang；
>emacs可以识别两种命令：
>>(1) PAHT：
无论在什么系统下，将某个可执行文件的目录加入PATH环境变量，就可以在命令行下使用这个命令，无论这个命令放在哪里。所以，emacs启动时的PATH变量，是emacs中寻找外部命令的一个因素；
>>(2) exec-path：
exec-path是用来帮助emacs寻找可以++**直接**++使用的外部程序。所谓直接，表明是作为一个子进程存在的程序。这个子进程可以继承PATH环境变量，从而让子进程也可以找到对应的程序的执行路径。
>>>举个例子来说，如果你你指设置grep的执行路径给exec-path，你会发现，M-x grep执行不正确。那是因为，grep是通过一个sh子进程去执行的，所以，正确的办法是，更新PATH环境变量。

3. 知道了以上emacs需要的变量之后使用程序对这两个变量进行绑定设置：
```shell
(defun extra_bin (path)
  "prepand the path to the emacs intenral `exec-path' and \"PATH\" env variable.
Return the updated `exec-path'"
  (setenv "PATH" (concat (expand-file-name path)
                         path-separator
                         (getenv "PATH")))
  (setq exec-path
        (cons (expand-file-name path)
              exec-path)))
```
4. 然后使用函数来设置多个变量：
```shell
(mapc #'extra_bin
      (reverse
       '("~/extra_bin/unix-utils-bin"
         "~/extra_bin/etc"
         "~/extra_bin/PuTTY"
         "~/extra_bin/clang"
         )))
```
5. 接着，使用建立在auto-complete基础上的[auto-complete-clang](https://github.com/brianjcj/auto-complete-clang)代码包来使用clang作为补全的辅助程序，从github上pull下最新的代码，进行配置如下：
```shell
;;
(add-to-list 'load-path "path-to-download-folder/auto-complete-clang")
;;并且设置补全快捷键为CTRL+ENTER：
(define-key ac-mode-map  [(control return)] 'auto-complete)
;;继续设置auto-complete-clang：
;;加载clang
(require 'auto-complete-clang)
;; 自定义函数，开启auto-complete的clang扩展
(defun clang-cc-mode-setup ()
  (make-local-variable 'ac-auto-start)
  ;;这儿如果使用自动补全会很浪费CPU资源
  (setq ac-auto-start nil) ;;设置ac-sources作为自动补全的来源，其中包含了clang和yasnippet这两个
  (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources)))
;; 添加c-mode和c++-mode的hook到自定义函数上
(add-hook 'c-mode-hook 'clang-cc-mode-setup)
(add-hook 'c++-mode-hook 'clang-cc-mode-setup)
;; 最重要的是将系统的头文件路径也交给clang，从而可以动态处理
(setq ac-clang-flags	(list
	"-IC:/Program Files (x86)/Microsoft Visual Studio 12.0/VC/include"
	"-IC:/MinGW/lib/gcc/mingw32/4.6.1/include"
	"-IC:/MinGW/lib/gcc/mingw32/4.6.1/include/c++"
	"-IC:/MinGW/lib/gcc/mingw32/4.6.1/include/c++/mingw32"
	"-D__MSVCRT__="))
```
当然这种写法性要求使用-I来说明这是一个头文件目录，那么也可以像[这样处理](http://blog.csdn.net/cherylnatsu/article/details/7670445)来自动添加这个-I说明：
```shell
(setq ac-clang-flags
        (mapcar(lambda (item)(concat "-I" item))
               (split-string
                "
 /usr/include/c++/4.4
 /usr/include/c++/4.4/i486-linux-gnu
 /usr/include/c++/4.4/backward
 /usr/local/include
 /usr/lib/gcc/i486-linux-gnu/4.4.5/include
 /usr/lib/gcc/i486-linux-gnu/4.4.5/include-fixed
 /usr/include/i486-linux-gnu
 /usr/include
"))
```
clang就是通过ac-clang-flags这个变量中的设置，来正确找到所有的系统头文件的。这儿将所有的头文件放在列表中提供给clang使用。完成以上所有步骤之后就可以重启emacs来体验自动补全了。


#### 4. 使用sr-speedbar作为轻量级的文件管理
每次进入shell查看当前文件夹的结构是非常麻烦的事情，所以使用[sr-speedbar](http://www.emacswiki.org/emacs/sr-speedbar.el)来显示制定目录的结构。然后根据这个[教程](http://www.cnblogs.com/cobbliu/p/3390965.html)进行设置：
```shell
(add-to-list 'load-path "~/.emacs.d/project/sr-speedbar")
(require 'sr-speedbar)
(setq sr-speedbar-right-side nil)
(setq sr-speedbar-width 18)
(setq dframe-update-speed t)
(global-set-key (kbd "<f5>")
	(lambda()
          (interactive)
          (sr-speedbar-toggle)))
```
可以方便的将speedbar和主窗口集成在一起。上面的自定义的函数完成F5按键的绑定，可以通过这个按键自动调出文件导航窗口。


#### 5. 联合安装ecb和cedet

ECB, A code browser for Emacs被托管在github的[ecb页面](https://github.com/alexott/ecb)下，并且已经很久没有更新了。在emacs版本低于23的时候需要配合cedet使用，由于emacs24版本之后cedet已经内置，所以不用再次安装了。
然后按照如下脚本进行配置就好了：
```shell
;;安装ecb
(add-to-list 'load-path "~/.emacs.d/project/ecb/")
;;加载ecb
(require 'ecb)
```
成功激活后Emacs窗口会被切成左右两半。左边的几个窗口依次显示：目录，当前目录下的文件，当前文件中的函数/全局变量等定义，文件浏览历史。如果打开了一个源文件后函数定义窗口里面是空的，有可能是因为这个项目过大cedet尚未完成对它的分析，闲置一段时间后就能看到文件里的定义。
ECB提供了方便在这些窗口间切换的快捷键：
```shell
切换到目录窗口 Ctrl-c . g d
切换到文件窗口 Ctrl-c . g s
切换到函数/方法窗口 Ctrl-c . g m
切换到历史窗口 Ctrl-c . g h
切换到上一个编辑窗口 Ctrl-c . g l
更详细的帮助信息Ctrl-C . h
```
通过上述快捷键就可以方便的不同的窗口切换了，方便对整个工程的管理。
但是默认的ecb布局和设置还是有些不方便，整个左侧都是窗口这样很密集，不容易看，所以按照[网页](http://truongtx.me/2013/03/10/ecb-emacs-code-browser/)给出的方式进行布局定制，并且选择其中的[leftright2](http://ecb.sourceforge.net/docs/Changing-the-ECB-layout.html)样式：
```shell
;;取消蛋痛的开始提示
(setq ecb-tip-of-the-day 0)
(setq ecb-help-info-start-file 0)
;;然后对ecb的布局进行处理
;;(setq ecb-layout-name "leftright2")
(setq ecb-layout-name "leftright2"
	  ecb-layout-window-sizes
	  '(("leftright2"
		 (ecb-directories-buffer-name 0.12 . 0.6428571428571429)
		 (ecb-sources-buffer-name 0.12 . 0.3392857142857143)
		 (ecb-methods-buffer-name 0.12 . 0.6428571428571429)
		 (ecb-history-buffer-name 0.12 . 0.3392857142857143))))
;;然后总是显示当前的文件树关系
(setq ecb-show-sources-in-directories-buffer 'always)
;;然后显示编译结果
(setq ecb-compile-window-height 12)
;;自动启动ecb
;;(setq ecb-auto-activate t)
;;;自定义一键开关，ctrl+f1 快速打开ecb窗口的函数
(defun my-ecb-active-or-deactive ()
	(interactive)
	(if ecb-minor-mode
		(ecb-deactivate)
		(ecb-activate)))
(global-set-key (kbd "<C-f1>") 'my-ecb-active-or-deactive)
```
完成这些设置之后就可以方便的使用ecb进行项目管理了。

##（6）使用git管理子模块和当前的配置文件
使用git对当前的版本进行管理是非常方便的事情，不借助与外部GUI，使用git shell来管理当前已经完成的配置，切换到当前配置文件夹下，按照如下命令进行初始化和提交：
1. 初始化操作：
```shell
git init
git add .
git commit -a -m "Initial commit"
```
2. 添加子模块，将依赖的其他git版本添加到当前git管理中，否则无法正确的加入到工程中：
```shell
;;进入配置文件夹下
cd .emacs.d
;;（1）添加配色模式
;;cd color-theme
git submodule add https://github.com/sellout/emacs-color-theme-solarized.git
cd ..
;;（2）切换到自动补全子目录
cd auto-complete
git submodule add https://github.com/auto-complete/auto-complete.git
git submodule add https://github.com/brianjcj/auto-complete-clang.git
git submodule add https://github.com/auto-complete/fuzzy-el.git
git submodule add https://github.com/auto-complete/popup-el.git
git submodule add https://github.com/capitaomorte/yasnippet.git
cd ..
;;（3）切换到mode子目录，添加模式支持，如果后续有其他模式添加也会放在这个文件夹下
cd mode
git submodule add https://github.com/company-mode/company-mode.git
git submodule add https://github.com/rust-lang/rust-mode.git
cd ..
```
完成上述子模块添加之后再次提交到主版本中：
```shell
;;提交修改
git commit -a -m "submodule add success"
```
在github下新建configuration项目，然后对整个工程远程提交：
```shell
git remote add origin https://github.com/hellmonky/configuration.git
git push -u origin master
```
经过上述基本git操作就将本地的配置文件同步到自己的github项目主页了。

##（7）更多插件相关的基本安装和配置
>更多的配置细节还是参考.emacs中的内容，以其中的内容为准。
>文档更新速度慢于该文件的更新。





