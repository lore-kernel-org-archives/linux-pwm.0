From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 5/6] clocksource: timer-ti-dm: Add support to get pwm
 current status
Date: Fri, 6 Mar 2020 09:08:08 -0800
Message-ID: <20200306170808.GD37466@atomide.com>
References: <20200305082715.15861-1-lokeshvutla@ti.com>
 <20200305082715.15861-6-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:59122 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgCFRIL (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 6 Mar 2020 12:08:11 -0500
Content-Disposition: inline
In-Reply-To: <20200305082715.15861-6-lokeshvutla@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>

* Lokesh Vutla <lokeshvutla@ti.com> [200305 08:29]:
> omap_dm_timer_ops provide support to configure the pwm but there is no
> support to get the current status. For configuring pwm it is advised to
> check the current hw status instead of relying on pwm framework. So
> implement a new timer ops to get the current status of pwm.

Acked-by: Tony Lindgen <tony@atomide.com>
