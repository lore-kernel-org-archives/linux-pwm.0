From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2] pwm-backlight: fix the panel power sequence
Date: Tue, 03 Nov 2015 12:08:44 +0100
Message-ID: <1446548924.3373.3.camel@pengutronix.de>
References: <1444987060-48202-1-git-send-email-yh.huang@mediatek.com>
	 <1444988219.3541.3.camel@pengutronix.de>
	 <1445526750.27586.8.camel@mtksdaap41>
	 <1446133259.3274.52.camel@pengutronix.de>
	 <1446190900.17558.16.camel@mtksdaap41>
	 <1446201271.3334.22.camel@pengutronix.de>
	 <1446538299.2449.8.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:53626 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbbKCLIt (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 3 Nov 2015 06:08:49 -0500
In-Reply-To: <1446538299.2449.8.camel@mtksdaap41>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: YH Huang <yh.huang@mediatek.com>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org

Hi YH,

Am Dienstag, den 03.11.2015, 16:11 +0800 schrieb YH Huang:
> > The reasoning is that devices where there is no phandle link pointing to
> > the backlight (for example from a simple-panel node), we should keep the
> > current default behaviour (enable during probe).
> 
> I have a little problem for the current default behaviour.
> Should we enable during probe?

Here I mean enabling the backlight (at the end of the probe function),
not enabling the GPIO already when requesting it.

> Before this patch ( http://patchwork.ozlabs.org/patch/324690/ ),
> we disable "enable-gpio" in the probe function.

While before this patch the GPIO would be initialized in the disabled
state, the call to backlight_update_status at the end of the probe
function would still enable the backlight afterwards.

regards
Philipp
