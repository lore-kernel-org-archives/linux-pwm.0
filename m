From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/6] pwm: omap-dmtimer: Drop unused header file
Date: Fri, 6 Mar 2020 10:03:29 -0800
Message-ID: <20200306180329.GG37466@atomide.com>
References: <20200228095651.32464-1-lokeshvutla@ti.com>
 <20200228095651.32464-2-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200228095651.32464-2-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>
List-Id: linux-pwm@vger.kernel.org

* Lokesh Vutla <lokeshvutla@ti.com> [200228 09:58]:
> pwm_omap_dmtimer.h is used only:
> - to typedef struct omap_dm_timer to pwm_omap_dmtimer
> - for macro PWM_OMAP_DMTIMER_TRIGGER_OVERFLOW_AND_COMPARE
> Rest of the file is pretty mush unsed. So reuse omap_dm_timer
> and OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE in pwm-omap-dmtimer.c
> and delete the header file.

Acked-by: Tony Lindgren <tony@atomide.com>
