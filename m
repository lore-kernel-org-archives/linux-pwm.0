From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH] ARM: dts: imx6qdl: Adjust the brightness setting for
 LVDS panel
Date: Tue, 27 Jan 2015 16:21:57 +0100
Message-ID: <1422372117.3751.58.camel@pengutronix.de>
References: <1421749355-23050-1-git-send-email-r63905@freescale.com>
	 <20150120113837.GC2766@dragon> <1421941084.3084.45.camel@pengutronix.de>
	 <BLUPR03MB4059C6493E55DB26E8308E9F8350@BLUPR03MB405.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48343 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbbA0PWD (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 27 Jan 2015 10:22:03 -0500
In-Reply-To: <BLUPR03MB4059C6493E55DB26E8308E9F8350@BLUPR03MB405.namprd03.prod.outlook.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: "Robby.Cai@freescale.com" <Robby.Cai@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Eric Nelson <eric.nelson@boundarydevices.com>, Tim Harvey <tharvey@gateworks.com>, "jg1.han@samsung.com" <jg1.han@samsung.com>, Troy Kisky <troy.kisky@boundarydevices.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Am Montag, den 26.01.2015, 14:44 +0000 schrieb Robby.Cai@freescale.com:
> > I notice that the intervals are changed from exponential to linear.
> > Is this really wanted here?
> > I expect that the new settings result in huge steps in perceived
> > brightness at low levels and a nearly imperceptible change at the last
> > step.
> > 
> > regards
> > Philipp
> 
> 
> No particular reason here. I understand your concern but seems there's no obvious rule.
> How about add some interpolation, such as <0 52 64 96 128 160 192 224 255>
> or even more, <0 52 64 80 96 112 128 144 160 176 192 208 224 240 255>

I just wanted to point out the possible issue. Maybe somebody with the
actual panel could sit down and experiment and come up with some
visually pleasing steps.

regards
Philipp

