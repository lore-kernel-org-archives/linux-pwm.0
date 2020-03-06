From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 6/6] clocksource: timer-ti-dm: Enable autoreload in
 set_pwm
Date: Fri, 6 Mar 2020 09:18:17 -0800
Message-ID: <20200306171817.GE37466@atomide.com>
References: <20200305082715.15861-1-lokeshvutla@ti.com>
 <20200305082715.15861-7-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:59136 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbgCFRSU (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 6 Mar 2020 12:18:20 -0500
Content-Disposition: inline
In-Reply-To: <20200305082715.15861-7-lokeshvutla@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>

* Lokesh Vutla <lokeshvutla@ti.com> [200305 08:29]:
> dm timer ops set_load() api allows to configure the load value and to
> set the auto reload feature. But auto reload feature is independent of
> load value and should be part of configuring pwm. This way pwm can be
> disabled by disabling auto reload feature using set_pwm() so that the
> current pwm cycle will be completed. Else pwm disabling causes the
> cycle to be stopped abruptly.

Acked-by: Tony Lindgren <tony@atomide.com>
