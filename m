From: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Subject: Re: [PATCH 1/2] gpio: mvebu: fix blink counter register selection
Date: Tue, 30 May 2017 17:18:53 +0200
Message-ID: <20170530171853.64630ce6@gmail.com>
References: <20170530122848.2803-1-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34628 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750767AbdE3PTA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 May 2017 11:19:00 -0400
In-Reply-To: <20170530122848.2803-1-richard.genoud@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thierry Reding <thierry.reding@gmail.com>

Hi Richard

On Tue, 30 May 2017 14:28:47 +0200
Richard Genoud <richard.genoud@gmail.com> wrote:

> The blink counter A was always selected because 0 was forced in the
> blink select counter register.
> The variable 'set' was obviously there to be used as the register
> value, selecting the B counter when id==1 and A counter when id==0.
> 
> Tested on clearfog-pro (Marvell 88F6828)

As stated in the other thread, testing on clearfog-pro is likely bogus,
still the fix is correct.

Reviewed-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>

Thanks
Ralph

> 
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> ---
>  drivers/gpio/gpio-mvebu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index 19a92efabbef..cdef2c78cb3b 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -747,7 +747,7 @@ static int mvebu_pwm_probe(struct platform_device
> *pdev, set = U32_MAX;
>  	else
>  		return -EINVAL;
> -	writel_relaxed(0,
> mvebu_gpioreg_blink_counter_select(mvchip));
> +	writel_relaxed(set,
> mvebu_gpioreg_blink_counter_select(mvchip)); 
>  	mvpwm = devm_kzalloc(dev, sizeof(struct mvebu_pwm),
> GFP_KERNEL); if (!mvpwm)
