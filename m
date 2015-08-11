From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 4/4] misc: atmel_tclib: get and use slow clock
Date: Tue, 11 Aug 2015 15:40:45 +0200
Message-ID: <55C9FB5D.7030607@linaro.org>
References: <1439285884-16051-1-git-send-email-alexandre.belloni@free-electrons.com> <1439285884-16051-5-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:36105 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbbHKNku (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Aug 2015 09:40:50 -0400
Received: by wicja10 with SMTP id ja10so75717714wic.1
        for <linux-pwm@vger.kernel.org>; Tue, 11 Aug 2015 06:40:49 -0700 (PDT)
In-Reply-To: <1439285884-16051-5-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org

On 08/11/2015 11:38 AM, Alexandre Belloni wrote:
> From: Boris Brezillon <boris.brezillon@free-electrons.com>
>
> Commit dca1a4b5ff6e ("clk: at91: keep slow clk enabled to prevent sys=
tem
> hang") added a workaround for the slow clock as it is not properly ha=
ndled
> by its users.
>
> Get and use the slow clock as it is necessary for the timer counters.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.co=
m>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: linux-pwm@vger.kernel.org
>
>   drivers/clocksource/tcb_clksrc.c |  8 ++++++++
>   drivers/misc/atmel_tclib.c       |  4 ++++
>   drivers/pwm/pwm-atmel-tcb.c      | 23 ++++++++++++++++-------
>   include/linux/atmel_tc.h         |  1 +
>   4 files changed, 29 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/t=
cb_clksrc.c
> index b9b7277173c2..969ba03633b0 100644
> --- a/drivers/clocksource/tcb_clksrc.c
> +++ b/drivers/clocksource/tcb_clksrc.c
> @@ -188,6 +188,13 @@ static int __init setup_clkevents(struct atmel_t=
c *tc, int clk32k_divisor_idx)
>   	ret =3D clk_prepare_enable(t2_clk);
>   	if (ret)
>   		return ret;
> +
> +	ret =3D clk_prepare_enable(tc->slow_clk);
> +	if (ret) {
> +		clk_disable_unprepare(t2_clk);
> +		return ret;
> +	}
> +
>   	clk_disable(t2_clk);

Do you need t2_clk to be enabled in order to enable tc->slow_clk ?

>   	clkevt.regs =3D tc->regs;
> @@ -200,6 +207,7 @@ static int __init setup_clkevents(struct atmel_tc=
 *tc, int clk32k_divisor_idx)
>   	ret =3D request_irq(irq, ch2_irq, IRQF_TIMER, "tc_clkevt", &clkevt=
);
>   	if (ret) {
>   		clk_unprepare(t2_clk);
> +		clk_disable_unprepare(tc->slow_clk);
>   		return ret;
>   	}
>
> diff --git a/drivers/misc/atmel_tclib.c b/drivers/misc/atmel_tclib.c
> index 0ca05c3ec8d6..ac24a4bd63f7 100644
> --- a/drivers/misc/atmel_tclib.c
> +++ b/drivers/misc/atmel_tclib.c

[ ... ]

> @@ -387,9 +387,9 @@ static int atmel_tcb_pwm_probe(struct platform_de=
vice *pdev)
>
>   	tcbpwm =3D devm_kzalloc(&pdev->dev, sizeof(*tcbpwm), GFP_KERNEL);
>   	if (tcbpwm =3D=3D NULL) {
> -		atmel_tc_free(tc);
> +		err =3D -ENOMEM;
>   		dev_err(&pdev->dev, "failed to allocate memory\n");
> -		return -ENOMEM;
> +		goto err_free_tc;
>   	}
>
>   	tcbpwm->chip.dev =3D &pdev->dev;
> @@ -400,17 +400,24 @@ static int atmel_tcb_pwm_probe(struct platform_=
device *pdev)
>   	tcbpwm->chip.npwm =3D NPWM;
>   	tcbpwm->tc =3D tc;
>
> +	err =3D clk_prepare_enable(tc->slow_clk);
> +	if (err)
> +		goto err_free_tc;
> +
>   	spin_lock_init(&tcbpwm->lock);
>
>   	err =3D pwmchip_add(&tcbpwm->chip);
> -	if (err < 0) {
> -		atmel_tc_free(tc);
> -		return err;
> -	}
> +	if (err < 0)
> +		goto err_free_tc;
>
>   	platform_set_drvdata(pdev, tcbpwm);
>
>   	return 0;
> +
> +err_free_tc:
> +	atmel_tc_free(tc);
> +
> +	return err;

What about clk_unprepare_disable(tc->slow_clk) ?

>   }
>

[ ... ]


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
