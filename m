From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: The PWM is broken at RK3288
Date: Tue, 25 Oct 2016 14:58:11 +0200
Message-ID: <25477004.WQlyuGeDoO@diego>
References: <e2f9b965-e025-e260-48a2-b6968f96e11b@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:42973 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932241AbcJYM6X (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 25 Oct 2016 08:58:23 -0400
In-Reply-To: <e2f9b965-e025-e260-48a2-b6968f96e11b@rock-chips.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Randy Li <randy.li@rock-chips.com>
Cc: linux-pwm@vger.kernel.org, thierry.reding@gmail.com, linux-rockchip@lists.infradead.org, "ayaka@soulik.info" <ayaka@soulik.info>, contact@paulk.fr

Hi Randy,

Am Dienstag, 25. Oktober 2016, 20:47:49 schrieb Randy Li:
>    Recently, paulk told me that he meet a problem with PWM backlight at
> rk3288, I do a test at EVB board a few minutes age, it is true. The
> kernel 4.4 would work fine. So the pwm driver at next-20161020 maybe
> broken. It is too late, so I have no time to confirm whether the PWM1
> would have the same problem.
>    I would look into it in the other day and see whether I could do
> something for that.

just yesterday I booted a 4.9-rc2 on my rk3288-veyron-pinky Chromebook and the 
display (backlight supplied by the pwm) was still working correctly. I haven't 
tested any next-kernels yet though, so maybe something broke there.


Heiko
