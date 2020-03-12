From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 1/5] pwm: omap-dmtimer: Drop unused header file
Date: Thu, 12 Mar 2020 07:35:39 +0100
Message-ID: <20200312063539.5urgly7scgupqqwi@pengutronix.de>
References: <20200312042210.17344-1-lokeshvutla@ti.com>
 <20200312042210.17344-2-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200312042210.17344-2-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>
List-Id: linux-pwm@vger.kernel.org

On Thu, Mar 12, 2020 at 09:52:06AM +0530, Lokesh Vutla wrote:
> pwm_omap_dmtimer.h is used only:
> - to typedef struct omap_dm_timer to pwm_omap_dmtimer
> - for macro PWM_OMAP_DMTIMER_TRIGGER_OVERFLOW_AND_COMPARE
> Rest of the file is pretty mush unsed. So reuse omap_dm_timer
> and OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE in pwm-omap-dmtimer.c
> and delete the header file.
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
