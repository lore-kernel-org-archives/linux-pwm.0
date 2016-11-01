From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 03/10] pwm: imx: Rewrite imx_pwm_*_v1 code to
 facilitate switch to atomic pwm operation
Date: Tue, 1 Nov 2016 08:17:43 +0100
Message-ID: <20161101071743.ef3nhdhaquhbgtlo@pengutronix.de>
References: <1477549785-4972-1-git-send-email-l.majewski@majess.pl>
 <1477549785-4972-4-git-send-email-l.majewski@majess.pl>
 <20161027094005.2da3b7d4@bbrezillon>
 <20161031055904.av45k535c26gjonz@pengutronix.de>
 <20161031092937.im5epytgorcd5fbm@pengutronix.de>
 <20161101065723.7751a55e@jawa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:36582 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1034089AbcKAHRs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Nov 2016 03:17:48 -0400
Content-Disposition: inline
In-Reply-To: <20161101065723.7751a55e@jawa>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lukasz Majewski <l.majewski@majess.pl>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Philipp Zabel <pza@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>

On Tue, Nov 01, 2016 at 06:57:23AM +0100, Lukasz Majewski wrote:
> Hi Sascha,
> 
> > The current assumption as discussed by Philipp and me is that the ipg
> > clk is only needed when the pwm output is driven by the ipg clk
> > (MX3_PWMCR[16:17] = MX3_PWMCR_CLKSRC_IPG)
> 
> At least on my setup (i.MX6q) the ipg clock (ipg_clk) don't need to be
> explicitly enabled in the ->apply() callback (in the pwm-imx.c) when
> MX3_PWMCR_CLKSRC_IPG (0x01 - ipg_clk) is selected as the PWM source.

No. If you look in the device tree you'll see that there is no special
gateable ipg clock for the PWM. Instead the SoC ipg clock is registered
for the PWM which is not gateable.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
