From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v3 02/11] pwm: imx: remove ipg clock
Date: Tue, 01 Nov 2016 10:26:44 +0100
Message-ID: <1477992404.2475.40.camel@pengutronix.de>
References: <1477984230-18071-1-git-send-email-l.majewski@majess.pl>
         <1477984230-18071-3-git-send-email-l.majewski@majess.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46214 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1167785AbcKAJ0r (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Nov 2016 05:26:47 -0400
In-Reply-To: <1477984230-18071-3-git-send-email-l.majewski@majess.pl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lukasz Majewski <l.majewski@majess.pl>
Cc: Thierry Reding <thierry.reding@gmail.com>, Stefan Agner <stefan@agner.ch>, Sascha Hauer <s.hauer@pengutronix.de>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, kernel@pengutronix.de

Am Dienstag, den 01.11.2016, 08:10 +0100 schrieb Lukasz Majewski:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> The use of the ipg clock was introduced with commit 7b27c160c681
> ("pwm: i.MX: fix clock lookup").
> In the commit message it was claimed that the ipg clock is enabled for
> register accesses. This is true for the ->config() callback, but not
> for the ->set_enable() callback. Given that the ipg clock is not
> consistently enabled for all register accesses we can assume that either
> it is not required at all or that the current code does not work.
> Remove the ipg clock code for now so that it's no longer in the way of
> refactoring the driver.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>

I don't remember the details, but since I had only worked with i.MX53
and i.MX6 at the time, and Sascha now verified that the i.MX53 PWM
registers can in fact be accessed with the pwmX_ipg_clk bits gated, I
can only assume that this patch is the result of a misinterpretation of
the i.MX53 technical reference manual: Contrary to the i.MX6 TRM it does
not mention the ungated peripheral access clock (ipg_clk_s) at all, but
calls the gated ipg_clk "block interface clock" in Table 18-3.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
