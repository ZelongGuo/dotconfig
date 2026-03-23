## My tmux config

you should place the file in `~`, or `ln -s ~/.config/tmux/.tmux.conf ~/.tmux.conf`

let `prefix` be `c-a`


**change statue bar:**

If you want to change the botton bar state, you can check the `./tmux-powerline/themes/default.sh` and modify it.

![statue](https://img-blog.csdnimg.cn/20200923150050560.png)


### Troubleshooting

1. The icons of tmux-powerline couldn't be shown (or couldn't be shown properly).
   - Firstly, you should check the **font setting** in **Iterm2**. You should choose **nerd font** or **powerline font**. Usually **nerd font** is O.K., because nerd font is the superset (>=) of powerline font.
   - If **font setting** is OK, check is the **non-ascii** symbols could be shown properly in **ranger** or not, if everything is OK, then go the third step.
   - Open tumx with `tmux -u`, that means writing **UTF-8** output to the terminal no matter the environment variable of `LC_ALL`, `LC_CTYPE`, or `LANG` that is set. Then you are supposed to see everything has been getting to the right track. However, it is not forever, you should check the **UTF-8** setting in **Iterm2** and make sure the **font**, ***region/country*** (under Profile -> Terminal -> Environment) with **utf-8**. 



