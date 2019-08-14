From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 2/2] pwm: sprd: Add Spreadtrum PWM support
Date: Wed, 14 Aug 2019 12:55:35 +0200
Message-ID: <20190814105535.svslc57qp3wx5lub@pengutronix.de>
References: <f9d2c7cb01cbf31bf75c4160611fa1d37d99f355.1565703607.git.baolin.wang@linaro.org>
 <4f6e3110b4d7e0a2f7ab317bba98a933de12e5da.1565703607.git.baolin.wang@linaro.org>
 <20190813151612.v6x6e6kzxflkpu7b@pengutronix.de>
 <CAMz4kuJURx=fPE6+0gP4ukzMcXr_z3t1ZH0K3Gv6=o4Od4uc7w@mail.gmail.com>
 <20190814092339.73ybj5mycklvpnrq@pengutronix.de>
 <CAMz4ku+3txx5kO-u_+_pxFwoovnX81WFF-moNBasUUgEpvQb+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMz4ku+3txx5kO-u_+_pxFwoovnX81WFF-moNBasUUgEpvQb+Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>, linux-pwm@vger.kernel.org, DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

Hello Baolin,

On Wed, Aug 14, 2019 at 06:01:50PM +0800, Baolin Wang wrote:
> On Wed, 14 Aug 2019 at 17:23, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Wed, Aug 14, 2019 at 04:42:28PM +0800, Baolin Wang wrote:
> > > On Tue, 13 Aug 2019 at 23:16, Uwe Kleine-König
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > On Tue, Aug 13, 2019 at 09:46:41PM +0800, Baolin Wang wrote:
> > > > [...]
> > > Not really, our hardware's method is, when you changed a new
> > > configuration (MOD or duty is changed) , the hardware will wait for a
> > > while to complete current period, then change to the new period.
> >
> > Can you describe that in more detail? This doesn't explain why MOD must be
> > configured before DUTY. Is there another reason for that?
> 
> Sorry, I did not explain this explicitly. When we change a new PWM
> configuration, the PWM controller will make sure the current period is
> completed before changing to a new period. Once setting the MOD
> register (since we always set MOD firstly), that will tell the
> hardware that a new period need to change.

So if the current period just ended after you reconfigured MOD but
before you wrote to DUTY we'll see a bogus period, right? I assume the
same holds true for writing the prescale value?

> The reason MOD must be configured before DUTY is that, if we
> configured DUTY firstly, the PWM can work abnormally if the current
> DUTY is larger than previous MOD. That is also our hardware's
> limitation.

OK, so you must not get into a situation where DUTY > MOD, right?

Now if the hardware was configured for

	period = 8s, duty = 4s

and now you are supposed to change to

	period = 2s, duty = 1s

you'd need to write DUTY first, don't you?

> > > > > +static int sprd_pwm_remove(struct platform_device *pdev)
> > > > > +{
> > > > > +     struct sprd_pwm_chip *spc = platform_get_drvdata(pdev);
> > > > > +     int ret, i;
> > > > > +
> > > > > +     ret = pwmchip_remove(&spc->chip);
> > > > > +
> > > > > +     for (i = 0; i < spc->num_pwms; i++) {
> > > > > +             struct sprd_pwm_chn *chn = &spc->chn[i];
> > > > > +
> > > > > +             clk_bulk_disable_unprepare(SPRD_PWM_NUM_CLKS, chn->clks);
> > > >
> > > > If a PWM was still running you're effectively stopping it here, right?
> > > > Are you sure you don't disable once more than you enabled?
> > >
> > > Yes, you are right. I should check current enable status of the PWM channel.
> > > Thanks for your comments.
> >
> > I didn't recheck, but I think the right approach is to not fiddle with
> > the clocks at all and rely on the PWM framework to not let someone call
> > sprd_pwm_remove when a PWM is still in use.
> 
> So you mean just return pwmchip_remove(&spc->chip); ?

right.

I just rechecked: If there is still a pwm in use, pwmchip_remove returns
-EBUSY. So this should be safe.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
