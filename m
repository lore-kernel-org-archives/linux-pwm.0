From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/4] pwm: omap-dmtimer: Fix pwm enabling sequence
Date: Mon, 24 Feb 2020 09:49:56 +0100
Message-ID: <20200224084956.wwsnf2y24ragg3vf@pengutronix.de>
References: <20200224052135.17278-1-lokeshvutla@ti.com>
 <20200224052135.17278-3-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200224052135.17278-3-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-pwm@vger.kernel.org

On Mon, Feb 24, 2020 at 10:51:33AM +0530, Lokesh Vutla wrote:
> To configure DM timer is pwm mode the following needs to be set in
> OMAP_TIMER_CTRL_REG using set_pwm callback:
> - Set toggle mode on PORTIMERPWM output pin
> - Set trigger on overflow and match on PORTIMERPWM output pin.
> - Set auto reload
> 
> This is a one time configuration and needs to be set before the start of
> the dm timer. But the current driver tries to set the same configuration
> for every period/duty cycle update, which is not needed. So move the pwm
> setup before enabling timer and do not update it in pwm_omap_dmtimer_config.

Is this change kind of moot with the conversion to .apply in the next
patch?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
