From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 5/6] pwm: omap-dmtimer: Do not disable pwm before
 changing period/duty_cycle
Date: Fri, 6 Mar 2020 10:17:20 -0800
Message-ID: <20200306181720.GK37466@atomide.com>
References: <20200228095651.32464-1-lokeshvutla@ti.com>
 <20200228095651.32464-6-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:59218 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbgCFSRY (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 6 Mar 2020 13:17:24 -0500
Content-Disposition: inline
In-Reply-To: <20200228095651.32464-6-lokeshvutla@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>

* Lokesh Vutla <lokeshvutla@ti.com> [200228 09:58]:
> Only the Timer control register(TCLR) cannot be updated when the timer
> is running. Registers like Counter register(TCRR), loader register(TLDR),
> match register(TMAR) can be updated when the counter is running. Since
> TCLR is not updated in pwm_omap_dmtimer_config(), do not stop the
> timer for period/duty_cycle update.

Still works for me with "pwm: omap-dmtimer: Fix pwm disabling sequence"
patch left out:

Tested-by: Tony Lindgren <tony@atomide.com>
