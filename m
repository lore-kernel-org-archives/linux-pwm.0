From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 03/10] pwm: imx: Rewrite imx_pwm_*_v1 code to
 facilitate switch to atomic pwm operation
Date: Tue, 1 Nov 2016 09:59:35 +0100
Message-ID: <20161101085935.4fitl2u6hkt63ro6@pengutronix.de>
References: <1477549785-4972-1-git-send-email-l.majewski@majess.pl>
 <1477549785-4972-4-git-send-email-l.majewski@majess.pl>
 <20161027094005.2da3b7d4@bbrezillon>
 <20161031055904.av45k535c26gjonz@pengutronix.de>
 <20161031092937.im5epytgorcd5fbm@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:36897 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1168138AbcKAI7l (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Nov 2016 04:59:41 -0400
Content-Disposition: inline
In-Reply-To: <20161031092937.im5epytgorcd5fbm@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Philipp Zabel <pza@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>

On Mon, Oct 31, 2016 at 10:29:37AM +0100, Sascha Hauer wrote:
> > accesses. This is true for the ->config() callback, but not for the
> > ->set_enable() callback. Given that the ipg clock is not consistently
> > enabled for all register accesses we can assume that either it is not
> > required at all or that the current code does not work.
> > Remove the ipg clock code for now so that it's no longer in the way of
> > refactoring the driver.
> 
> For reference:
> 
> I verified on i.MX53 and i.MX25 that the ipg clock provided to the pwm
> driver is not needed when accessing registers. I would have to verify
> that on i.MX27 aswell, but I do not have a board handy at the moment.

Also on i.MX27 disabling the PWMs ipg_clk does not disable register
accesses.

Sascha

> 
> The current assumption as discussed by Philipp and me is that the ipg
> clk is only needed when the pwm output is driven by the ipg clk
> (MX3_PWMCR[16:17] = MX3_PWMCR_CLKSRC_IPG)
> 
> Sascha
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
