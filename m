From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCHv2 4/4] clocksource: tcb_clksrc: unprepare clock in case
 of failure
Date: Wed, 03 Sep 2014 11:49:15 +0200
Message-ID: <5406E41B.1040406@linaro.org>
References: <1409329003-17252-1-git-send-email-g.portay@overkiz.com> <1409329003-17252-5-git-send-email-g.portay@overkiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:44308 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588AbaICJtT (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 3 Sep 2014 05:49:19 -0400
Received: by mail-wi0-f169.google.com with SMTP id n3so5550311wiv.2
        for <linux-pwm@vger.kernel.org>; Wed, 03 Sep 2014 02:49:18 -0700 (PDT)
In-Reply-To: <1409329003-17252-5-git-send-email-g.portay@overkiz.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <g.portay@overkiz.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Thomas Gleixner <tglx@linutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

On 08/29/2014 06:16 PM, Ga=C3=ABl PORTAY wrote:
> The clock is not unprepared in case of the request IRQ fails.
>
> Also update to request_irq.
>
> Signed-off-by: Ga=C3=ABl PORTAY <g.portay@overkiz.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   drivers/clocksource/tcb_clksrc.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/t=
cb_clksrc.c
> index f922e81..8bdbc45 100644
> --- a/drivers/clocksource/tcb_clksrc.c
> +++ b/drivers/clocksource/tcb_clksrc.c
> @@ -178,12 +178,6 @@ static irqreturn_t ch2_irq(int irq, void *handle=
)
>   	return IRQ_NONE;
>   }
>
> -static struct irqaction tc_irqaction =3D {
> -	.name		=3D "tc_clkevt",
> -	.flags		=3D IRQF_TIMER,
> -	.handler	=3D ch2_irq,
> -};
> -
>   static int __init setup_clkevents(struct atmel_tc *tc, int clk32k_d=
ivisor_idx)
>   {
>   	int ret;
> @@ -198,15 +192,16 @@ static int __init setup_clkevents(struct atmel_=
tc *tc, int clk32k_divisor_idx)
>
>   	clkevt.regs =3D tc->regs;
>   	clkevt.clk =3D t2_clk;
> -	tc_irqaction.dev_id =3D &clkevt;
>
>   	timer_clock =3D clk32k_divisor_idx;
>
>   	clkevt.clkevt.cpumask =3D cpumask_of(0);
>
> -	ret =3D setup_irq(irq, &tc_irqaction);
> -	if (ret)
> +	ret =3D request_irq(irq, ch2_irq, IRQF_TIMER, "tc_clkevt", &clkevt)=
;
> +	if (ret) {
> +		clk_disable_unprepare(t2_clk);
>   		return ret;
> +	}
>
>   	clockevents_config_and_register(&clkevt.clkevt, 32768, 1, 0xffff);
>
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

