From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH RFC 2/6] gpio: mvebu: honour EPROBE_DEFER for
 devm_clk_get()
Date: Sun, 29 Mar 2020 15:16:59 +0200
Message-ID: <20200329131659.4hbshjst4ccvje2n@pengutronix.de>
References: <20200329104549.GX25745@shell.armlinux.org.uk>
 <E1jIVU9-0005h4-QU@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E1jIVU9-0005h4-QU-eh5Bv4kxaXIk46pC+1QYvQNdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Gregory Clement <gregory.clement-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Sun, Mar 29, 2020 at 11:48:09AM +0100, Russell King wrote:
> Honour deferred probing for devm_clk_get() so that we can get the clock
> for PWM.
> 
> Signed-off-by: Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
> ---
>  drivers/gpio/gpio-mvebu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index fa5641615db6..ee13b11c5298 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -1132,6 +1132,9 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
>  	}
>  
>  	mvchip->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (mvchip->clk == ERR_PTR(-EPROBE_DEFER))
> +		return -EPROBE_DEFER;
> +
>  	/* Not all SoCs require a clock.*/
>  	if (!IS_ERR(mvchip->clk))
>  		clk_prepare_enable(mvchip->clk);

I'd say the following is the right thing to do here:

	mvchip->clk = devm_clk_get_optional(...);
	if (IS_ERR(mvchip->clk))
		return ...

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
