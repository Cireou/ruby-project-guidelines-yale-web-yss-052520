
[1mFrom:[0m /home/jonathan/dev/flatiron/Module1/Project1/bin/setting_page.rb @ line 19 SettingPage.run:

     [1;34m6[0m: [32mdef[0m [1;36mself[0m.[1;34mrun[0m()
     [1;34m7[0m:     user = [1;34;4mUser[0m.find([1;34;4mRunner[0m.user.id)
     [1;34m8[0m:     choices = [[31m[1;31m"[0m[31mView Settings[1;31m"[0m[31m[0m, [31m[1;31m"[0m[31mChange Settings[1;31m"[0m[31m[0m, [31m[1;31m"[0m[31mDelete Account[1;31m"[0m[31m[0m, [31m[1;31m"[0m[31mGo Back[1;31m"[0m[31m[0m]
     [1;34m9[0m:     selection = [36m@@prompt[0m.select([31m[1;31m"[0m[31mWhat would you like to do?[1;31m"[0m[31m[0m, choices)
    [1;34m10[0m:     [1;34m# binding.pry[0m
    [1;34m11[0m:     system([31m[1;31m"[0m[31mclear[1;31m"[0m[31m[0m)
    [1;34m12[0m:     [32mwhile[0m [1;36mtrue[0m
    [1;34m13[0m:         [32mcase[0m selection
    [1;34m14[0m:         [32mwhen[0m choices[[1;34m0[0m]
    [1;34m15[0m:             display_settings()
    [1;34m16[0m:         [32mwhen[0m choices[[1;34m1[0m]
    [1;34m17[0m:             change_settings()
    [1;34m18[0m:         [32mwhen[0m choices[[1;34m2[0m]
 => [1;34m19[0m:             binding.pry
    [1;34m20[0m:             [32mreturn[0m delete_account()
    [1;34m21[0m:         [32mwhen[0m choices[[1;34m3[0m]
    [1;34m22[0m:             [32mreturn[0m [1;36mfalse[0m 
    [1;34m23[0m:         [32mend[0m
    [1;34m24[0m:         system([31m[1;31m"[0m[31mclear[1;31m"[0m[31m[0m)
    [1;34m25[0m:         selection = [36m@@prompt[0m.select([31m[1;31m"[0m[31mWhat would you like to do?[1;31m"[0m[31m[0m, choices)
    [1;34m26[0m:     [32mend[0m
    [1;34m27[0m: [32mend[0m

