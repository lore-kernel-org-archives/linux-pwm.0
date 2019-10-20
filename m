From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
Subject: Re: pwm_bl on i.MX6Q broken on 5.4-RC1+
Date: Sun, 20 Oct 2019 20:24:28 +0200
Message-ID: <20191020182428.76l3ob4sxblrjr4m@core.my.home>
References: <CAHCN7xJSz+QhOb4vE6b67jh5jnSOHnw79EyX8RW91TqPkD__Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHCN7xJSz+QhOb4vE6b67jh5jnSOHnw79EyX8RW91TqPkD__Lw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, arm-soc <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-pwm@vger.kernel.org

On Wed, Oct 16, 2019 at 02:55:54PM -0500, Adam Ford wrote:
> I have an i.MX6Q with an LCD and PWM controlled backlight.  On 5.4-RC1
> through the current master (16 Oct 2019), the backlight does not come
> on by default.  I can get it come on by manually setting the
> brightness, but any video activity seems to blank the screen again
> until I change the brightness again.

You might want to check PWM driver that's used on your SoC. I had a similar
breakage on Allwinner SoCs, and it was caused by a broken get_state callback.
The problem was there for a long time and it was only exposed by the commit you
bisected to.

regards,
	o.

> I bisected the patch to 01ccf903edd6 ("pwm: Let pwm_get_state() return
> the last implemented state")
> 
> If I revert this patch on 5.4-rc3, the issue goes away.
> 
> I was hoping someone might have a suggestion on how to fix it to play
> nicely with the iMX6Q PWM or revert if no solution can be found.
> 
> thank you,
> 
> adam
