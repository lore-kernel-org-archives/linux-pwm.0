From: YH Huang <yh.huang@mediatek.com>
Subject: Re: [PATCH v2] pwm-backlight: fix the panel power sequence
Date: Fri, 6 Nov 2015 16:31:30 +0800
Message-ID: <1446798690.6203.3.camel@mtksdaap41>
References: <1444987060-48202-1-git-send-email-yh.huang@mediatek.com>
	 <1444988219.3541.3.camel@pengutronix.de>
	 <1445526750.27586.8.camel@mtksdaap41>
	 <1446133259.3274.52.camel@pengutronix.de>
	 <1446190900.17558.16.camel@mtksdaap41>
	 <1446201271.3334.22.camel@pengutronix.de>
	 <1446538299.2449.8.camel@mtksdaap41>
	 <1446548924.3373.3.camel@pengutronix.de>
	 <1446601656.15340.11.camel@mtksdaap41>
	 <1446716430.3894.12.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:59229 "EHLO
	mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1032817AbbKFIbr (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Nov 2015 03:31:47 -0500
In-Reply-To: <1446716430.3894.12.camel@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org

On Thu, 2015-11-05 at 10:40 +0100, Philipp Zabel wrote:
> > 
> > Based on this, could we disable it initially and update in the
> > backlight_update_status function?
> > 
> > Like this,
> > 
> > if (pb->enable_gpio) {
> > 	if (phandle &&
> > 	    gpiod_get_direction(pb->enable_gpio) == GPIOF_DIR_OUT &&
> > 	    gpiod_get_value(pb->enable_gpio) == 1)
> > 		gpiod_direction_output(pb->enable_gpio, 1);
> 
> The gpiod_direction_output call is a no-op, since the direction is
> already output and the value is already 1.
> Also, I propose to set initial blanking to FB_BLANK_POWERDOWN in this
> case, and wait for the panel driver to enable the backlight at the
> appropriate time.

Thanks your kindly reply.
Your patch looks good to me.

Regards,
YH Huang
