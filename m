From: Yash Shah <yash.shah@sifive.com>
Subject: Re: [PATCH v8 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Date: Tue, 12 Mar 2019 12:22:38 +0530
Message-ID: <CAJ2_jOG50Bh0Zu64-htwy+VFy5Bce1Wj5dnMKVEE35C3MEbLPA@mail.gmail.com>
References: <1551437599-29509-1-git-send-email-yash.shah@sifive.com>
 <1551437599-29509-3-git-send-email-yash.shah@sifive.com> <20190307152745.kaiv6q4ygf2apmuv@pengutronix.de>
 <CAJ2_jOFvr=sw7mWR53JbzMJa1jxwjhJSTibCsKYsxrht+PLPWw@mail.gmail.com>
 <20190308115726.smgooacsr37fmxwg@pengutronix.de> <CAJ2_jOFtg2_MAUYkTQM-=6KE2RN+FMxfEhLjZZfzM0k3A5RQiA@mail.gmail.com>
 <20190311132922.iowselp7qvmroiaa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190311132922.iowselp7qvmroiaa@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>, linux-kernel@vger.kernel.org, robh+dt@kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de, Paul Walmsley <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Mon, Mar 11, 2019 at 6:59 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Mon, Mar 11, 2019 at 05:10:17PM +0530, Yash Shah wrote:
> > On Fri, Mar 8, 2019 at 5:27 PM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Fri, Mar 08, 2019 at 04:59:36PM +0530, Yash Shah wrote:
> > > > On Thu, Mar 7, 2019 at 8:57 PM Uwe Kleine-K=C3=B6nig
> > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > > +     if (state->period !=3D cur_state.period) {
> > > > >
> > > > > Did you test this with more than one consumer? For sure the follo=
wing
> > > > > should work:
> > > > >
> > > > >         pwm1 =3D pwm_get(.. the first ..);
> > > > >         pwm_apply_state(pwm1, { .enabled =3D true, .period =3D 10=
000000, .... });
> > > > >
> > > > >         pwm2 =3D pwm_get(.. the second ..);
> > > > >         pwm_apply_state(pwm2, { .enabled =3D true, .period =3D 10=
000000, .... });
> > > > >
> > > > > but for the second pwm_apply_state() run state->period is likely =
not
> > > > > exactly 10000000.
> > > >
> > > > Yes, I have tested multiple consumers using sysfs interface. It is =
working.
> > >
> > > Can you provide details about your testing here? What is the parent c=
lk
> > > rate? Which settings did you test? Can you confirm my claim that the
> > > above sequence would fail or point out my error in reasoning?
> > >
> >
> > I have tested on HiFive Unleashed board using sysfs interface.
> > Parent clk rate is around 512 Mhz.
> > I have tested scenarios as you mentioned above with various period and
> > duty_cycle values.
> >
> > After considering your below suggestion,
> >  | To get the result independent of the prior configuration you better =
use
> >  | the real targeted period length as input instead of the last configu=
red
> >  | approximation
> > I will introduce approx_period feild, which will be used as the
> > targeted period length.
> > Also, in pwm_sifive_get_state, I will make below change
> > - state->period =3D pwm->real_period;
> > + state->period =3D pwm->approx_period.
> > So with this change in place, I believe the cur_state.period for the
> > second pwm_apply_state() above (pwm2) will be exactly 10000000
>
> I don't understand your intention completely. Just send a new patch
> round, then I will gladly take another look.

I was planning to go with above-mentioned change but then I realized
that pwm state should always reflect the current hardware state, so I
have dropped the above idea.
Coming back to your concern on

 |     if (state->period !=3D cur_state.period) {

It is not failing for the scenario you mentioned but failing for
another way around.

         pwm1 =3D pwm_get(.. the first ..);
         pwm_apply_state(pwm1, { .enabled =3D true, .period =3D 10000000, .=
... });

         pwm2 =3D pwm_get(.. the second ..);
         pwm_apply_state(pwm2, { .enabled =3D true, .period =3D 20000000, .=
... });

The pwm2 should get an error for period mismatch but with v8 patch, it
is not getting any error.

I am sending a v9 patch which has the fix for this.
With v9 changes, I have tested all scenarios and it is working fine.

>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
