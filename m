From: YH Huang <yh.huang@mediatek.com>
Subject: Re: [PATCH v2] pwm-backlight: fix the panel power sequence
Date: Wed, 4 Nov 2015 09:47:36 +0800
Message-ID: <1446601656.15340.11.camel@mtksdaap41>
References: <1444987060-48202-1-git-send-email-yh.huang@mediatek.com>
	 <1444988219.3541.3.camel@pengutronix.de>
	 <1445526750.27586.8.camel@mtksdaap41>
	 <1446133259.3274.52.camel@pengutronix.de>
	 <1446190900.17558.16.camel@mtksdaap41>
	 <1446201271.3334.22.camel@pengutronix.de>
	 <1446538299.2449.8.camel@mtksdaap41>
	 <1446548924.3373.3.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:46863 "EHLO
	mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932169AbbKDBrl (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 3 Nov 2015 20:47:41 -0500
In-Reply-To: <1446548924.3373.3.camel@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org

On Tue, 2015-11-03 at 12:08 +0100, Philipp Zabel wrote:
> Hi YH,
> 
> Am Dienstag, den 03.11.2015, 16:11 +0800 schrieb YH Huang:
> > > The reasoning is that devices where there is no phandle link pointing to
> > > the backlight (for example from a simple-panel node), we should keep the
> > > current default behaviour (enable during probe).
> > 
> > I have a little problem for the current default behaviour.
> > Should we enable during probe?
> 
> Here I mean enabling the backlight (at the end of the probe function),
> not enabling the GPIO already when requesting it.
> 
> > Before this patch ( http://patchwork.ozlabs.org/patch/324690/ ),
> > we disable "enable-gpio" in the probe function.
> 
> While before this patch the GPIO would be initialized in the disabled
> state, the call to backlight_update_status at the end of the probe
> function would still enable the backlight afterwards.

Based on this, could we disable it initially and update in the
backlight_update_status function?

Like this,

if (pb->enable_gpio) {
	if (phandle &&
	    gpiod_get_direction(pb->enable_gpio) == GPIOF_DIR_OUT &&
	    gpiod_get_value(pb->enable_gpio) == 1)
		gpiod_direction_output(pb->enable_gpio, 1);
	else
		gpiod_direction_output(pb->enable_gpio, 0);
}

And then update with props.brightness in backlight_update_status.
I am not sure, maybe I miss something.

Regards,
YH Huang
