﻿$LIST = @"
      :::::::::  :::::::::   ::::::::       :::    :::  ::::::::  :::::::::: :::::::::               
      :+:    :+: :+:    :+: :+:    :+:      :+:    :+: :+:    :+: :+:        :+:    :+:              
      +:+    +:+ +:+    +:+ +:+    +:+      +:+    +:+ +:+        +:+        +:+    +:+              
      +#++:++#+  +#++:++#+  +#+    +:+      +#+    +:+ +#++:++#++ +#++:++#   +#++:++#:               
      +#+    +#+ +#+        +#+    +#+      +#+    +#+        +#+ +#+        +#+    +#+              
      #+#    #+# #+#        #+#    #+#      #+#    #+# #+#    #+# #+#        #+#    #+#              
      #########  ###         ########        ########   ########  ########## ###    ###              
::::    ::::  ::::::::::: ::::::::  :::::::::      ::: ::::::::::: ::::::::::: ::::::::  ::::    ::: 
+:+:+: :+:+:+     :+:    :+:    :+: :+:    :+:   :+: :+:   :+:         :+:    :+:    :+: :+:+:   :+: 
+:+ +:+:+ +:+     +:+    +:+        +:+    +:+  +:+   +:+  +:+         +:+    +:+    +:+ :+:+:+  +:+ 
+#+  +:+  +#+     +#+    :#:        +#++:++#:  +#++:++#++: +#+         +#+    +#+    +:+ +#+ +:+ +#+ 
+#+       +#+     +#+    +#+   +#+# +#+    +#+ +#+     +#+ +#+         +#+    +#+    +#+ +#+  +#+#+# 
#+#       #+#     #+#    #+#    #+# #+#    #+# #+#     #+# #+#         #+#    #+#    #+# #+#   #+#+# 
###       ### ########### ########  ###    ### ###     ### ###     ########### ########  ###    #### 
"@

$list = @"
    ██████╗ ██████╗  ██████╗     ██╗   ██╗███████╗███████╗██████╗     
    ██╔══██╗██╔══██╗██╔═══██╗    ██║   ██║██╔════╝██╔════╝██╔══██╗    
    ██████╔╝██████╔╝██║   ██║    ██║   ██║███████╗█████╗  ██████╔╝    
    ██╔══██╗██╔═══╝ ██║   ██║    ██║   ██║╚════██║██╔══╝  ██╔══██╗    
    ██████╔╝██║     ╚██████╔╝    ╚██████╔╝███████║███████╗██║  ██║    
    ╚═════╝ ╚═╝      ╚═════╝      ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝    
                                                                      
███╗   ███╗██╗ ██████╗ ██████╗  █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
████╗ ████║██║██╔════╝ ██╔══██╗██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
██╔████╔██║██║██║  ███╗██████╔╝███████║   ██║   ██║██║   ██║██╔██╗ ██║
██║╚██╔╝██║██║██║   ██║██╔══██╗██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
██║ ╚═╝ ██║██║╚██████╔╝██║  ██║██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
╚═╝     ╚═╝╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
                                                                      
"@



foreach ($line in $list -split "`n")
{
    foreach ($char in $line.tochararray())
    {
        #switch ($([int]$char))
        #{
        #    '#' {Write-host -fore darkCyan $char -NoNewline}
        #    '+' {Write-host -fore DarkGreen $char -NoNewline}
        #    ':' {Write-host -fore green $char -NoNewline}
        #    Default {Write-host $char -NoNewline}
        #}

        if ($([int]$char) -le 9580 -and  $([int]$char) -ge 9552)
        {
            Write-host -fore cyan $char -NoNewline
        }
        else
        {
            write-host -fore red $char -NoNewline
        }
    }
    write-host ""
}


###
# Finding character values

1..1000 |get-random -count 10| % {write-host $("{0}{1}" -f $_.Tostring().padright(5), $([char][int]$_))}
[int][char]'╚'
9000..10000 | % {write-host $("{0}{1}" -f $_.Tostring().padright(5), $([char][int]$_))}