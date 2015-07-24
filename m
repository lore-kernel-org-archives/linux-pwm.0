From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v6 0/3] Add MediaTek display PWM driver
Date: Fri, 24 Jul 2015 10:42:05 +0200
Message-ID: <2181696.fQcvS98Cqx@ubix>
References: <1437380237-28961-1-git-send-email-yh.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:38361 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754463AbbGXImM (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Jul 2015 04:42:12 -0400
In-Reply-To: <1437380237-28961-1-git-send-email-yh.huang@mediatek.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: YH Huang <yh.huang@mediatek.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, yingjoe.chen@mediatek.com

On Monday, July 20, 2015 04:17:14 PM YH Huang wrote:
> This patch series add the use of display PWM driver, documentation
> and device tree for Mediatek SoCs. The driver is used to support
> the backlight of the panel. This is based on v4.2-rc1.
> 
> The clock definitions (CLK_MM_DISP_PWM*) are added by James Liao's patch:
> clk: mediatek: Add subsystem clocks of MT8173
> 
> Change in v6:
> 1. Enable clocks in the pwm_enable function
> 2. Remove suspend/resume code since pwm-backlight driver has done the same
> things 3. Revise some code to make it easier to read
> 

Can you please provide the whole change log for all versions the next time.
It's easier this way to understand the evolution of the series.

Thanks,
Matthias
