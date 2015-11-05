From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2] pwm-backlight: fix the panel power sequence
Date: Thu, 05 Nov 2015 10:40:30 +0100
Message-ID: <1446716430.3894.12.camel@pengutronix.de>
References: <1444987060-48202-1-git-send-email-yh.huang@mediatek.com>
	 <1444988219.3541.3.camel@pengutronix.de>
	 <1445526750.27586.8.camel@mtksdaap41>
	 <1446133259.3274.52.camel@pengutronix.de>
	 <1446190900.17558.16.camel@mtksdaap41>
	 <1446201271.3334.22.camel@pengutronix.de>
	 <1446538299.2449.8.camel@mtksdaap41>
	 <1446548924.3373.3.camel@pengutronix.de>
	 <1446601656.15340.11.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:55221 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030886AbbKEJke (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Nov 2015 04:40:34 -0500
In-Reply-To: <1446601656.15340.11.camel@mtksdaap41>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: YH Huang <yh.huang@mediatek.com>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org

Am Mittwoch, den 04.11.2015, 09:47 +0800 schrieb YH Huang:
> On Tue, 2015-11-03 at 12:08 +0100, Philipp Zabel wrote:
> > Hi YH,
> > 
> > Am Dienstag, den 03.11.2015, 16:11 +0800 schrieb YH Huang:
> > > > The reasoning is that devices where there is no phandle link pointing to
> > > > the backlight (for example from a simple-panel node), we should keep the
> > > > current default behaviour (enable during probe).
> > > 
> > > I have a little problem for the current default behaviour.
> > > Should we enable during probe?
> > 
> > Here I mean enabling the backlight (at the end of the probe function),
> > not enabling the GPIO already when requesting it.
> > 
> > > Before this patch ( http://patchwork.ozlabs.org/patch/324690/ ),
> > > we disable "enable-gpio" in the probe function.
> > 
> > While before this patch the GPIO would be initialized in the disabled
> > state, the call to backlight_update_status at the end of the probe
> > function would still enable the backlight afterwards.
> 
> Based on this, could we disable it initially and update in the
> backlight_update_status function?
> 
> Like this,
> 
> if (pb->enable_gpio) {
> 	if (phandle &&
> 	    gpiod_get_direction(pb->enable_gpio) == GPIOF_DIR_OUT &&
> 	    gpiod_get_value(pb->enable_gpio) == 1)
> 		gpiod_direction_output(pb->enable_gpio, 1);

The gpiod_direction_output call is a no-op, since the direction is
already output and the value is already 1.
Also, I propose to set initial blanking to FB_BLANK_POWERDOWN in this
case, and wait for the panel driver to enable the backlight at the
appropriate time.

regards
Philipp
