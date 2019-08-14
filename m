From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 2/2] pwm: sprd: Add Spreadtrum PWM support
Date: Wed, 14 Aug 2019 15:30:43 +0200
Message-ID: <20190814133043.peh63lwngujjuo5d@pengutronix.de>
References: <f9d2c7cb01cbf31bf75c4160611fa1d37d99f355.1565703607.git.baolin.wang@linaro.org>
 <4f6e3110b4d7e0a2f7ab317bba98a933de12e5da.1565703607.git.baolin.wang@linaro.org>
 <20190813151612.v6x6e6kzxflkpu7b@pengutronix.de>
 <CAMz4kuJURx=fPE6+0gP4ukzMcXr_z3t1ZH0K3Gv6=o4Od4uc7w@mail.gmail.com>
 <20190814092339.73ybj5mycklvpnrq@pengutronix.de>
 <CAMz4ku+3txx5kO-u_+_pxFwoovnX81WFF-moNBasUUgEpvQb+Q@mail.gmail.com>
 <20190814105535.svslc57qp3wx5lub@pengutronix.de>
 <CAMz4ku+H1++pzZ9pAw2N6Z342j3NMBwfRj9VZTdsihtZYzuFOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMz4ku+H1++pzZ9pAw2N6Z342j3NMBwfRj9VZTdsihtZYzuFOw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>, linux-pwm@vger.kernel.org, DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

Hello,

On Wed, Aug 14, 2019 at 08:23:37PM +0800, Baolin Wang wrote:
> On Wed, 14 Aug 2019 at 18:55, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Wed, Aug 14, 2019 at 06:01:50PM +0800, Baolin Wang wrote:
> > > On Wed, 14 Aug 2019 at 17:23, Uwe Kleine-König
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > On Wed, Aug 14, 2019 at 04:42:28PM +0800, Baolin Wang wrote:
> > > > > On Tue, 13 Aug 2019 at 23:16, Uwe Kleine-König
> > > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > > On Tue, Aug 13, 2019 at 09:46:41PM +0800, Baolin Wang wrote:
> > > > > > [...]
> > > > > Not really, our hardware's method is, when you changed a new
> > > > > configuration (MOD or duty is changed) , the hardware will wait for a
> > > > > while to complete current period, then change to the new period.
> > > >
> > > > Can you describe that in more detail? This doesn't explain why MOD must be
> > > > configured before DUTY. Is there another reason for that?
> > >
> > > Sorry, I did not explain this explicitly. When we change a new PWM
> > > configuration, the PWM controller will make sure the current period is
> > > completed before changing to a new period. Once setting the MOD
> > > register (since we always set MOD firstly), that will tell the
> > > hardware that a new period need to change.
> >
> > So if the current period just ended after you reconfigured MOD but
> > before you wrote to DUTY we'll see a bogus period, right? I assume the
> > same holds true for writing the prescale value?
> 
> I confirmed again, I am sorry I missed something before. Yes, like you
> said before, writing DUTY triggers the hardware to actually apply the
> values written to MOD and DUTY to the output. So write DUTY last. I
> will update the comments and change the PWM configure like:
> 
> sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_PRESCALE, prescale);
> sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_MOD, SPRD_PWM_MOD_MAX);
> sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_DUTY, duty);

So PRESCALE is independent and it can still happen that writing PRESCALE
affects the output before MOD and DUTY do?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
