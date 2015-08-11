From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH v3 4/4] misc: atmel_tclib: get and use slow clock
Date: Tue, 11 Aug 2015 17:27:24 +0200
Message-ID: <20150811152724.GR3411@piout.net>
References: <1439285884-16051-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1439285884-16051-5-git-send-email-alexandre.belloni@free-electrons.com>
 <55C9FB5D.7030607@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:36432 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965062AbbHKP10 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Aug 2015 11:27:26 -0400
Content-Disposition: inline
In-Reply-To: <55C9FB5D.7030607@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org

On 11/08/2015 at 15:40:45 +0200, Daniel Lezcano wrote :
> On 08/11/2015 11:38 AM, Alexandre Belloni wrote:
> >From: Boris Brezillon <boris.brezillon@free-electrons.com>
> >
> >Commit dca1a4b5ff6e ("clk: at91: keep slow clk enabled to prevent system
> >hang") added a workaround for the slow clock as it is not properly handled
> >by its users.
> >
> >Get and use the slow clock as it is necessary for the timer counters.
> >
> >Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> >Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> >Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >---
> >Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> >Cc: Thomas Gleixner <tglx@linutronix.de>
> >Cc: Thierry Reding <thierry.reding@gmail.com>
> >Cc: linux-pwm@vger.kernel.org
> >
> >  drivers/clocksource/tcb_clksrc.c |  8 ++++++++
> >  drivers/misc/atmel_tclib.c       |  4 ++++
> >  drivers/pwm/pwm-atmel-tcb.c      | 23 ++++++++++++++++-------
> >  include/linux/atmel_tc.h         |  1 +
> >  4 files changed, 29 insertions(+), 7 deletions(-)
> >
> >diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
> >index b9b7277173c2..969ba03633b0 100644
> >--- a/drivers/clocksource/tcb_clksrc.c
> >+++ b/drivers/clocksource/tcb_clksrc.c
> >@@ -188,6 +188,13 @@ static int __init setup_clkevents(struct atmel_tc *tc, int clk32k_divisor_idx)
> >  	ret = clk_prepare_enable(t2_clk);
> >  	if (ret)
> >  		return ret;
> >+
> >+	ret = clk_prepare_enable(tc->slow_clk);
> >+	if (ret) {
> >+		clk_disable_unprepare(t2_clk);
> >+		return ret;
> >+	}
> >+
> >  	clk_disable(t2_clk);
> 
> Do you need t2_clk to be enabled in order to enable tc->slow_clk ?

No, I'll move clk_prepare_enable for tc->slow_clk before t2_clk.

> >+
> >+err_free_tc:
> >+	atmel_tc_free(tc);
> >+
> >+	return err;
> 
> What about clk_unprepare_disable(tc->slow_clk) ?
> 

Indeed, I trusted Boris a bit too much ;)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
