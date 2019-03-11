From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v8 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Date: Mon, 11 Mar 2019 14:29:22 +0100
Message-ID: <20190311132922.iowselp7qvmroiaa@pengutronix.de>
References: <1551437599-29509-1-git-send-email-yash.shah@sifive.com>
 <1551437599-29509-3-git-send-email-yash.shah@sifive.com>
 <20190307152745.kaiv6q4ygf2apmuv@pengutronix.de>
 <CAJ2_jOFvr=sw7mWR53JbzMJa1jxwjhJSTibCsKYsxrht+PLPWw@mail.gmail.com>
 <20190308115726.smgooacsr37fmxwg@pengutronix.de>
 <CAJ2_jOFtg2_MAUYkTQM-=6KE2RN+FMxfEhLjZZfzM0k3A5RQiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJ2_jOFtg2_MAUYkTQM-=6KE2RN+FMxfEhLjZZfzM0k3A5RQiA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yash Shah <yash.shah@sifive.com>
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>, linux-kernel@vger.kernel.org, robh+dt@kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de, Paul Walmsley <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hello,

On Mon, Mar 11, 2019 at 05:10:17PM +0530, Yash Shah wrote:
> On Fri, Mar 8, 2019 at 5:27 PM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Fri, Mar 08, 2019 at 04:59:36PM +0530, Yash Shah wrote:
> > > On Thu, Mar 7, 2019 at 8:57 PM Uwe Kleine-König
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > +     if (state->period != cur_state.period) {
> > > >
> > > > Did you test this with more than one consumer? For sure the following
> > > > should work:
> > > >
> > > >         pwm1 = pwm_get(.. the first ..);
> > > >         pwm_apply_state(pwm1, { .enabled = true, .period = 10000000, .... });
> > > >
> > > >         pwm2 = pwm_get(.. the second ..);
> > > >         pwm_apply_state(pwm2, { .enabled = true, .period = 10000000, .... });
> > > >
> > > > but for the second pwm_apply_state() run state->period is likely not
> > > > exactly 10000000.
> > >
> > > Yes, I have tested multiple consumers using sysfs interface. It is working.
> >
> > Can you provide details about your testing here? What is the parent clk
> > rate? Which settings did you test? Can you confirm my claim that the
> > above sequence would fail or point out my error in reasoning?
> >
> 
> I have tested on HiFive Unleashed board using sysfs interface.
> Parent clk rate is around 512 Mhz.
> I have tested scenarios as you mentioned above with various period and
> duty_cycle values.
> 
> After considering your below suggestion,
>  | To get the result independent of the prior configuration you better use
>  | the real targeted period length as input instead of the last configured
>  | approximation
> I will introduce approx_period feild, which will be used as the
> targeted period length.
> Also, in pwm_sifive_get_state, I will make below change
> - state->period = pwm->real_period;
> + state->period = pwm->approx_period.
> So with this change in place, I believe the cur_state.period for the
> second pwm_apply_state() above (pwm2) will be exactly 10000000

I don't understand your intention completely. Just send a new patch
round, then I will gladly take another look.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
