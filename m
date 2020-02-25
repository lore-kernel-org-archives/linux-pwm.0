From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/4] pwm: omap-dmtimer: Drop unused header file
Date: Tue, 25 Feb 2020 07:43:46 +0100
Message-ID: <20200225064346.xj5gejuvu76riou2@pengutronix.de>
References: <20200224052135.17278-1-lokeshvutla@ti.com>
 <20200224052135.17278-2-lokeshvutla@ti.com>
 <20200224075302.jd3vcrdl6fuqrkpb@pengutronix.de>
 <ca33326e-22c8-e57b-c5fe-900f4749e640@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ca33326e-22c8-e57b-c5fe-900f4749e640@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-pwm@vger.kernel.org

On Tue, Feb 25, 2020 at 10:32:04AM +0530, Lokesh Vutla wrote:
> Hi Uwe,
> 
> On 24/02/20 1:23 PM, Uwe Kleine-König wrote:
> > Hello,
> > 
> > On Mon, Feb 24, 2020 at 10:51:32AM +0530, Lokesh Vutla wrote:
> >> @@ -190,9 +190,8 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
> >>  		load_value, load_value,	match_value, match_value);
> >>  
> >>  	omap->pdata->set_pwm(omap->dm_timer,
> >> -			      pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
> >> -			      true,
> >> -			      PWM_OMAP_DMTIMER_TRIGGER_OVERFLOW_AND_COMPARE);
> >> +			     pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
> >> +			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE);
> > 
> > This is unrelated.
> 
> PWM_OMAP_DMTIMER_TRIGGER_OVERFLOW_AND_COMPARE is deleted along with header file
> and used OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE. I should have mentioned this
> in my commit description. Will fix it in v2.

Ah, indeed I missed that the register name was changed in that hunk and
considered that an indention only change.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
