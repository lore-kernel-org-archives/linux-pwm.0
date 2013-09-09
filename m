Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2] pwm: pxa: add device tree support to pwm driver
Date: Mon, 9 Sep 2013 17:56:42 +0200
References: <1378669218-10944-1-git-send-email-mikedunn@newsguy.com> <201309090249.47407.marex@denx.de> <522DEB3F.7090509@newsguy.com>
In-Reply-To: <522DEB3F.7090509@newsguy.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201309091756.42315.marex@denx.de>
List-ID: <linux-pwm.vger.kernel.org>
To: Mike Dunn <mikedunn@newsguy.com>
Cc: linux-pwm@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chao Xie <chao.xie@marvell.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Dear Mike Dunn,

[...]

> >> +static struct of_device_id pwm_of_match[] = {
> >> +	{ .compatible = "marvell,pxa250-pwm", .data = &pwm_id_table[0]},
> > 
> > Surely, data can be NULL, no ?
> 
> It could, in which case pxa_pwm_get_id_dt() would explicitly return
> &pwm_id_table[0] instead of the .data element of the of_device_id.  Not
> sure which way is better and why.  That dumb platform_device_id table is
> causing all kinds of nuisance :)

Is the pwm_id_table needed at all anymore?

> > [...]
> > 
> >> @@ -145,6 +199,8 @@ static int pwm_probe(struct platform_device *pdev)
> >> 
> >>  	pwm->chip.ops = &pxa_pwm_ops;
> >>  	pwm->chip.base = -1;
> >>  	pwm->chip.npwm = (id->driver_data & HAS_SECONDARY_PWM) ? 2 : 1;
> >> 
> >> +	pwm->chip.of_xlate = of_pwm_xlate_with_flags;
> >> +	pwm->chip.of_pwm_n_cells = 3;
> > 
> > Are these two settings needed ?
> 
> Yes.  See drivers/pwm/core.c:of_pwmchip_add(), where they are set to
> default values of of_pwm_simple_xlate and 2 if left uninitialized.

OK

Best regards,
Marek Vasut
