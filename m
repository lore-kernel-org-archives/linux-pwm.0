From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 1/2] gpio: mvebu: fix blink counter register selection
Date: Tue, 30 May 2017 15:01:33 +0200
Message-ID: <877f0yv6qa.fsf@free-electrons.com>
References: <20170530122848.2803-1-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170530122848.2803-1-richard.genoud@gmail.com> (Richard
        Genoud's message of "Tue, 30 May 2017 14:28:47 +0200")
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Ralph Sennhauser <ralph.sennhauser@gmail.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Hi Richard,
 
 On mar., mai 30 2017, Richard Genoud <richard.genoud@gmail.com> wrote:

> The blink counter A was always selected because 0 was forced in the
> blink select counter register.
> The variable 'set' was obviously there to be used as the register value,
> selecting the B counter when id==1 and A counter when id==0.
>
> Tested on clearfog-pro (Marvell 88F6828)
>
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>

Looks good for me:

Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

I thinks this one should go to v4.12-rc as it is a fix.

As I modified the same part of the code in my series, I think I will
have to rebase my series on top of this patch as soon as Linus Walleij
will have accepted it.

Thanks,

Gregory


> ---
>  drivers/gpio/gpio-mvebu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index 19a92efabbef..cdef2c78cb3b 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -747,7 +747,7 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
>  		set = U32_MAX;
>  	else
>  		return -EINVAL;
> -	writel_relaxed(0, mvebu_gpioreg_blink_counter_select(mvchip));
> +	writel_relaxed(set, mvebu_gpioreg_blink_counter_select(mvchip));
>  
>  	mvpwm = devm_kzalloc(dev, sizeof(struct mvebu_pwm), GFP_KERNEL);
>  	if (!mvpwm)

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
