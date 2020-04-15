From: Sandipan Patra <spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH] pwm: tegra: dynamic clk freq configuration by PWM driver
Date: Wed, 15 Apr 2020 09:03:35 +0000
Message-ID: <BYAPR12MB3014C0178A7360662C6FA8B7ADDB0@BYAPR12MB3014.namprd12.prod.outlook.com>
References: <1585917303-10573-1-git-send-email-spatra@nvidia.com>
 <20200403151050.nh2mrffkqdqtkozq@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200403151050.nh2mrffkqdqtkozq-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Bibek Basu <bbasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Thank you Uwe for reviewing the changes.
And sorry for the delay in my response.
Please find the responses inline.


Thanks & Regards,
Sandipan

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Sent: Friday, April 3, 2020 8:41 PM
> To: Sandipan Patra <spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Cc: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>; robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; Jonathan
> Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>; Bibek Basu <bbasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>; Laxman
> Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>; linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH] pwm: tegra: dynamic clk freq configuration by PWM dr=
iver
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Fri, Apr 03, 2020 at 06:05:03PM +0530, Sandipan Patra wrote:
> > Added support for dynamic clock freq configuration in pwm kernel driver=
.
> > Earlier the pwm driver used to cache boot time clock rate by pwm clock
> > parent during probe. Hence dynamically changing pwm frequency was not
> > possible for all the possible ranges. With this change, dynamic
> > calculation is enabled and it is able to set the requested period from
> > sysfs knob provided the value is supported by clock source.
>=20
> Without having looked closely at the patch (yet), just for my
> understanding: If the PWM is running and the frequency changes, the outpu=
t
> changes, too, right? If so, do we need a notifier that prevents a frequen=
cy
> change when the PWM is running?
Yes, frequency can be changed anytime but by the same process who has=20
acquired the channel. So if a process is already running/using the channel,
same process can only modify the frequency.

>=20
> And slightly orthogonal to this patch: The tegra driver needs some love t=
o make
> it use the atomic callback .apply() instead of
> .config()/.enable()/.disable() and a .get_state() implementation.
Understood to upgrade pwm-tegra driver with using .apply()
I will work on this with a new change request soon.
>=20
> > Changes mainly have 2 parts:
> >   - T186 and later chips [1]
> >   - T210 and prior chips [2]
> >
> > For [1] - Changes implemented to set pwm period dynamically and
> >           also checks added to allow only if requested period(ns) is
> >           below or equals to higher range.
> >
> > For [2] - Only checks if the requested period(ns) is below or equals
> >           to higher range defined by max clock limit. The limitation
> >           in T210 or prior chips are due to the reason of having only
> >           one pwm-controller supporting multiple channels. But later
> >           chips have multiple pwm controller instances each having
> >         single channel support.
> >
> > Signed-off-by: Sandipan Patra <spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/pwm/pwm-tegra.c | 45
> > +++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 43 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c index
> > aa12fb3..d3ba33c 100644
> > --- a/drivers/pwm/pwm-tegra.c
> > +++ b/drivers/pwm/pwm-tegra.c
> > @@ -4,7 +4,7 @@
> >   *
> >   * Tegra pulse-width-modulation controller driver
> >   *
> > - * Copyright (c) 2010, NVIDIA Corporation.
> > + * Copyright (c) 2010-2020, NVIDIA Corporation.
> >   * Based on arch/arm/plat-mxc/pwm.c by Sascha Hauer
> <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> >   */
> >
> > @@ -83,10 +83,51 @@ static int tegra_pwm_config(struct pwm_chip *chip,
> struct pwm_device *pwm,
> >       val =3D (u32)c << PWM_DUTY_SHIFT;
> >
> >       /*
> > +      * Its okay to ignore the fraction part since we will be trying t=
o set
> > +      * slightly lower value to rate than the actual required rate
>=20
> s/actual/actually/
Noted. I will update in the follow up patch.

>=20
> You round down the rate, that results in rounding up period and duty_cycl=
e,
> right? If so, that's wrong. (Note that if the driver would use the atomic=
 callbacks,
> the just introduced debug checks would tell you this.)
>=20
> > +      */
> > +     rate =3D NSEC_PER_SEC/period_ns;
>=20
> space around / please.
Noted. I will update in the follow up patch.

>=20
> > +
> > +     /*
> > +      *  Period in nano second has to be <=3D highest allowed period
> > +      *  based on the max clock rate of the pwm controller.
> > +      *
> > +      *  higher limit =3D max clock limit >> PWM_DUTY_WIDTH
> > +      */
> > +     if (rate > (pc->soc->max_frequency >> PWM_DUTY_WIDTH))
> > +             return -EINVAL;
>=20
> Related to my question above: What happens if the rate increases after th=
is
> check?
Discussed above with my understanding. Please help me understand if=20
you are referring to any other possibilities that rate can be changed.=20

>=20
> Also the division above is just done to compare the requested period valu=
e with
> the allowed range.
>=20
> Your check is:
>=20
>         NSEC_PER_SEC / period_ns > (max_frequency >> PWM_DUTY_WIDTH)
>=20
> This is equivalent to
>=20
>         period_ns <=3D NSEC_PER_SEC / (max_frequency >> PWM_DUTY_WIDTH)
>=20
> where the right side is constant per PWM type. (Rounding might need
> addressing.)
I will update this calculation in the probe since max_frequency value is
Different for each chip. Also please note that at this point the rate is no=
t
the actual pwm output rate. It's just a reference for what should be the
source clock rate and then requested with clk_set_rate();
Actual rounding is required while setting pwm controller output rate is
done later down in same function.=20

>=20
> > +
> > +     /*
> >        * Compute the prescaler value for which (1 << PWM_DUTY_WIDTH)
> >        * cycles at the PWM clock rate will take period_ns nanoseconds.
> >        */
> > -     rate =3D pc->clk_rate >> PWM_DUTY_WIDTH;
> > +     if (pc->soc->num_channels =3D=3D 1) {
> > +             /*
> > +              * Rate is multiplied with 2^PWM_DUTY_WIDTH so that it ma=
tches
> > +              * with the hieghest applicable rate that the controller
> > + can
>=20
> typo: s/hieghest/highest/
Noted. I will update in the follow up patch.=20

>=20
> > +              * provide. Any further lower value can be derived by set=
ting
> > +              * PFM bits[0:12].
> > +              * Higher mark is taken since BPMP has round-up mechanism
> > +              * implemented.
> > +              */
> > +             rate =3D rate << PWM_DUTY_WIDTH;
> > +
> > +             err =3D clk_set_rate(pc->clk, rate);
> > +             if (err < 0)
> > +                     return -EINVAL;
> > +
> > +             rate =3D clk_get_rate(pc->clk) >> PWM_DUTY_WIDTH;
> > +     } else {
> > +             /*
> > +              * This is the case for SoCs who support multiple channel=
s:
>=20
> s/who/that/
Noted. I will update in the follow up patch.

>=20
> > +              *
> > +              * clk_set_rate() can not be called again in config becau=
se
> > +              * T210 or any prior chip supports one pwm-controller and
> > +              * multiple channels. Hence in this case cached clock rat=
e
> > +              * will be considered which was stored during probe.
>=20
> I don't understand that. If
The if part is for SoCs which have single channel per pwm instance. i.e. T1=
86,=20
T194 etc. For controllers with single channel, dynamic clock rate configura=
tion
is possible. The other part is for legacy controller which has multiple cha=
nnels
for single pwm instance. The pwm controllers having multiple channels share
the source clock. So it does not allow dynamic clock configuration since it
will affect users on the other channels.

> > +              */
> > +             rate =3D pc->clk_rate >> PWM_DUTY_WIDTH;
> > +     }
> >
> >       /* Consider precision in PWM_SCALE_WIDTH rate calculation */
> >       hz =3D DIV_ROUND_CLOSEST_ULL(100ULL * NSEC_PER_SEC, period_ns);
>=20
> I took a deeper look into the driver now. Just to ensure, I understood th=
e PWMs
> behaviour right:
>=20
> There is an ENABLE bit (with obvious semantics), a 13-bit SCALE value and=
 an 8-
> bit DUTY value. There is an internal counter incrementing by one each (SC=
ALE +
> 1) clock cycles and resets at 256. The counter going from 0 to 256 define=
s the
> period length. On counter reset the output gets active and on reaching DU=
TY the
> output gets inactive.
>=20
> So we have:
>=20
>         .period =3D 256 * (SCALE + 1) / clkrate
>         .duty_cycle =3D DUTY * (SCALE + 1) / clkrate
>=20
> Right?
Yes. Right.

>=20
> There are a few things that could be improved in the driver:
>=20
>  - .config() does quite some divisions. This could be reduced which
>    probably even reduces rounding effects.
Explained above and will move the calculation to probe.=20
>=20
>  - When .duty_ns =3D=3D .period the assignment of DUTY overflows.
>    (Can the PWM provide 100% duty cycle at all?)
Yes, PWM controller is capable to provide 100% duty cycle.
Bits 30:16 are dedicated for pulse width out of which only 24:16 (9 bits)
are used. Only 8 bits are usable [23:16] for varying pulse width.
To achieve 100% duty cycle, Bit [24] needs to be programmed of this
register to 1'b1.

>=20
>  - The comment "Since the actual PWM divider is the register's frequency
>    divider field minus 1, we need to decrement to get the correct value
>    to write to the register." seems wrong. If I understand correctly, we
>    need to do s/minus/plus/. If the register holds a 0, the divider
>    isn't -1 for sure?!
Yes, you are right. The comment needs a correction. It will be plus 1=20
instead of minus 1. I will update the comment in the follow up patch.
Otherwise the calculation is correct.
rate =3D DIV_ROUND_CLOSEST_ULL(100ULL * rate, hz);
here rate is the divider value to be set.

>=20
> How does the PWM behave when it gets disabled? Does it complete the
> currently running period? Does the output stop at the inactive level, or =
where it
> just happens to be? How does a running PWM behave when the register is
> updated? Does it complete the currently running period?
Yes, it allows to write the bit during any active and inactive time of the
width. Hence the pwm gets disabled as soon as the enable bit is set to 0.

>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
