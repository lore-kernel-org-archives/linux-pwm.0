From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v3 4/5] pwm: omap-dmtimer: Do not disable pwm before
 changing period/duty_cycle
Date: Thu, 12 Mar 2020 07:21:26 -0700
Message-ID: <20200312142126.GB2466@localhost>
References: <20200312042210.17344-1-lokeshvutla@ti.com>
 <20200312042210.17344-5-lokeshvutla@ti.com>
 <20200312064042.p7himm3odxjyzroi@pengutronix.de>
 <f250549f-1e7c-06d6-b2a4-7ae01c06725b@ti.com>
 <20200312084739.isixgdo3txr6rjzg@pengutronix.de>
 <2a5a06cd-7aca-c450-b048-33329d058eca@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2a5a06cd-7aca-c450-b048-33329d058eca@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

On Thu, Mar 12, 2020 at 04:14:34PM +0530, Lokesh Vutla wrote:
> But the problem here is that inactive breaks between two periods is not desired.
> Because the pwm is used to generate a 1PPS signal and is continuously
> synchronized with PTP clock.

The 1-PPS case is the "easy" one.  If the PWM is adjustable on the
fly, then people will use it with higher frequency signals.
 
> I am up if this can be solved generically. But updating period is very specific
> to hardware implementation. Not sure what generic solution can be brought out of
> this. Please correct me if I am wrong.

What happens today when the PWM frequency or duty cycle are changed
while the signal is enabled?

Do different PWM devices/drivers behave the same way?

Does this series change the behavior of the am335x and friends?

Thanks,
Richard
