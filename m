From: YH Huang <yh.huang@mediatek.com>
Subject: Re: [PATCH v6 0/3] Add MediaTek display PWM driver
Date: Mon, 3 Aug 2015 14:21:32 +0800
Message-ID: <1438582892.19953.4.camel@mtksdaap41>
References: <1437380237-28961-1-git-send-email-yh.huang@mediatek.com>
	 <2181696.fQcvS98Cqx@ubix> <1437729058.11386.4.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:54089 "EHLO
	mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752086AbbHCGgl (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 3 Aug 2015 02:36:41 -0400
In-Reply-To: <1437729058.11386.4.camel@mtksdaap41>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, yingjoe.chen@mediatek.com

On Fri, 2015-07-24 at 17:10 +0800, YH Huang wrote:
> On Fri, 2015-07-24 at 10:42 +0200, Matthias Brugger wrote:
> > On Monday, July 20, 2015 04:17:14 PM YH Huang wrote:
> > > This patch series add the use of display PWM driver, documentation
> > > and device tree for Mediatek SoCs. The driver is used to support
> > > the backlight of the panel. This is based on v4.2-rc1.
> > > 
> > > The clock definitions (CLK_MM_DISP_PWM*) are added by James Liao's patch:
> > > clk: mediatek: Add subsystem clocks of MT8173
> > > 
> > > Change in v6:
> > > 1. Enable clocks in the pwm_enable function
> > > 2. Remove suspend/resume code since pwm-backlight driver has done the same
> > > things 3. Revise some code to make it easier to read
> > > 
> > 
> > Can you please provide the whole change log for all versions the next time.
> > It's easier this way to understand the evolution of the series.
> 
> Change in v6:
> 1. Enable clocks in the pwm_enable function.
> 2. Remove suspend/resume code since pwm-backlight driver has done the
> same things.
> 3. Revise some code to make it easier to read.
> 
> Change in v5:
> 1. Configure PWM output via pinctrl.
> 2. Fix the parameter name in dtsi.
> 
> Change in v4:
> 1. Codebase is on v4.2-rc1.
> 2. Add the PWM node in dtsi.
> 3. Change the dependency in Kconfig.
> 4. Rewrite some code for readability.
> 
> Change in v3:
> 1. Add suspend/resume function.
> 2. Fix the formula for high_width calculation.
> 3. Rewrite some code to make it easier to read.
> 4. Add more information in the commit message.
> 
> Change in v2:
> 1. Rewrite descriptions for driver in kconfig to make it much clear.
> 2. Rename the driver from "pwm-mediatek-disp" to "pwm-mtk-disp".
> 3. Disable clocks in the error path.
> 4. Change the shift values in decimal instead of hex.
> 5. Rename and add some variables or function name for consistency and
> readability.
> 6. Drop unnecessary parentheses, spaces, variables and add newlines to
> make the code easiler to read.
> 
> Thanks for your suggestion.

Hi Thierry,

Do you have any suggestions?
Maybe we could apply the patch?

Regards,
YH Huang
