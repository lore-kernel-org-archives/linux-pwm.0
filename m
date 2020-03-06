From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 0/6] clocksource: timer-ti-dm: Prepare for dynamic pwm
 period updates
Date: Fri, 6 Mar 2020 09:19:17 -0800
Message-ID: <20200306171917.GF37466@atomide.com>
References: <20200305082715.15861-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200305082715.15861-1-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-pwm@vger.kernel.org

* Lokesh Vutla <lokeshvutla@ti.com> [200305 08:29]:
> This series fixes dm_timer_ops used for enabling the pwm and enables
> cpu_pm notifier for context save and restore. This acts as a preparatory
> series for enabling dynamic period updates for pwm omap dm timer driver.
> 
> Changes since v2:
> - Incorporated changes from Tony

I just gave this series another try here and it still works
for me just fine and is good to go as far as I'm concerned.

Thanks for doing this.

Regards,

Tony
