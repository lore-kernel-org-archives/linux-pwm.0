From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v3 2/2] backlight: pwm_bl: Check the pwm state for
 initial backlight power state
Date: Tue, 01 Nov 2016 14:11:04 +0100
Message-ID: <1478005864.2475.85.camel@pengutronix.de>
References: <20161101125933.11168-1-peter.ujfalusi@ti.com>
         <20161101125933.11168-3-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:33874 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1169092AbcKANLH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Nov 2016 09:11:07 -0400
In-Reply-To: <20161101125933.11168-3-peter.ujfalusi@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: thierry.reding@gmail.com, lee.jones@linaro.org, tomi.valkeinen@ti.com, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Am Dienstag, den 01.11.2016, 14:59 +0200 schrieb Peter Ujfalusi:
> If the pwm is not enabled the backlight initially should not be enabled
> either if we have booted with DT and there is a phandle pointing to the
> backlight node.
> 
> The patch extends the checks to decide if we should keep the backlight off
> initially.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
