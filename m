From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 3/6] pwm: omap-dmtimer: Fix pwm enabling sequence
Date: Fri, 6 Mar 2020 10:04:22 -0800
Message-ID: <20200306180422.GI37466@atomide.com>
References: <20200228095651.32464-1-lokeshvutla@ti.com>
 <20200228095651.32464-4-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:59188 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgCFSEZ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 6 Mar 2020 13:04:25 -0500
Content-Disposition: inline
In-Reply-To: <20200228095651.32464-4-lokeshvutla@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>

* Lokesh Vutla <lokeshvutla@ti.com> [200228 09:58]:
> To configure DM timer in pwm mode the following needs to be set in
> OMAP_TIMER_CTRL_REG using set_pwm callback:
> - Set toggle mode on PORTIMERPWM output pin
> - Set trigger on overflow and match on PORTIMERPWM output pin.
> - Set auto reload
> 
> This is a one time configuration and needs to be set before the start of
> the dm timer. But the current driver tries to set the same configuration
> for every period/duty cycle update, which is not needed. So move the pwm
> setup before enabling timer and do not update it in pwm_omap_dmtimer_config.

Still works for me:

Tested-by: Tony Lindgren <tony@atomide.com>
