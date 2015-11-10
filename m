From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v4] pwm-backlight: Avoid backlight flicker when probed from DT
Date: Tue, 10 Nov 2015 15:18:10 +0100
Message-ID: <3447562.c3gSANEMio@phil>
References: <1446483356-14338-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:38645 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752100AbbKJOSb (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Tue, 10 Nov 2015 09:18:31 -0500
In-Reply-To: <1446483356-14338-1-git-send-email-p.zabel@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, YH Huang <yh.huang@mediatek.com>, Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Christian Gmeiner <christian.gmeiner@gmail.com>, kernel@pengutronix.de, Lee Jones <lee.jones@linaro.org>, Ajay Kumar <ajaykumar.rs@samsung.com>

Hi Philipp,

Am Montag, 2. November 2015, 17:55:56 schrieb Philipp Zabel:
> If the driver is probed from the device tree, and there is a phandle
> property set on it, and the enable GPIO is already configured as output,
> and the backlight is currently disabled, keep it disabled.
> If all these conditions are met, assume there will be some other driver
> that can enable the backlight at the appropriate time.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>

this patch improves the white screen when booting a veyron chromebook
a lot. I still see a small white flash, but that can probably come from
the WIP edp driver.

Tested-by: Heiko Stuebner <heiko@sntech.de>
