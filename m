From: Adam Ford <aford173@gmail.com>
Subject: pwm_bl on i.MX6Q broken on 5.4-RC1+
Date: Wed, 16 Oct 2019 14:55:54 -0500
Message-ID: <CAHCN7xJSz+QhOb4vE6b67jh5jnSOHnw79EyX8RW91TqPkD__Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>, arm-soc <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-pwm@vger.kernel.org

I have an i.MX6Q with an LCD and PWM controlled backlight.  On 5.4-RC1
through the current master (16 Oct 2019), the backlight does not come
on by default.  I can get it come on by manually setting the
brightness, but any video activity seems to blank the screen again
until I change the brightness again.

I bisected the patch to 01ccf903edd6 ("pwm: Let pwm_get_state() return
the last implemented state")

If I revert this patch on 5.4-rc3, the issue goes away.

I was hoping someone might have a suggestion on how to fix it to play
nicely with the iMX6Q PWM or revert if no solution can be found.

thank you,

adam
