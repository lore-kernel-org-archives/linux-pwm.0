Return-path: <kernel-bounces@pengutronix.de>
Date: Fri, 12 Oct 2018 19:14:53 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: RFC: don't let drivers issue pwm_disable after pwm_config(pwm,
 0, period)
Message-ID: <20181012171453.mex2jupjnkzn7l7t@pengutronix.de>
References: <20180806155129.cjcc7okmwtaujf43@pengutronix.de>
 <20181009075345.GB5565@ulmo>
 <20181009093554.ugfxek3n4wacc7px@pengutronix.de>
 <20181010122607.GA21134@ulmo>
 <20181011101914.dapsvczsd4lteugk@pengutronix.de>
 <20181011120007.GA22811@ulmo>
 <20181011203450.muo4eoj4mnqo634a@pengutronix.de>
 <20181012095349.GA9162@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181012095349.GA9162@ulmo>
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Gavin Schenk <g.schenk@eckelmann.de>, Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

Hello Thierry,

On Fri, Oct 12, 2018 at 11:53:49AM +0200, Thierry Reding wrote:
> On Thu, Oct 11, 2018 at 10:34:50PM +0200, Uwe Kleine-K=F6nig wrote:
> [...]
> > > We can speculate about that as much as we want. i.MX is the only one
> > > that this issue has been reported against, so I'm going to have to
> > > assume that it's working fine for all of the others. If it isn't then
> > > people should come forward and report it.
> >=20
> > You really assume that all the drivers that don't make use of
> > PWM_POLARITY_INVERSED (33 of 50 + imx at least, probably more) behave as
> > you expect when the PWM user does:
> >=20
> > 	pwm_apply_state(pwm, { .period =3D 100; .duty_cycle=3D0; polarity=3DPW=
M_POLARITY_INVERSED; enabled=3Dfalse; })
> >=20
> > ? I'd say your assumption that all are working fine is treading on thin
> > ice. The effect maybe is only that the i.MX users use more corners of
> > the PWM API and/or are more open to report actual problems.
>=20
> Look, it's unrealistic to expect me to actually test or verify all of
> the different PWM controllers out there. The only thing I can go by is
> by what the maintainers of the individual drivers tell me, or what has
> been reported by users. So I'm going to assume that a driver works until
> somebody reports that it is broken.

I didn't expect from you to test everything. I just pointed out that
your argument "I assume all drivers to behave correctly because there is
no report that any of them doesn't work" doesn't build on solid facts.

But lets make this explicit and official: I looked into all 48 pwm
drivers (at commit 6b3944e42e2e) and sorted them into categories:

a) not ported to pwm_state and no support .set_polarity:
   - pwm-ab8500.c
   - pwm-brcmstb.c
   - pwm-clps711x.c
   - pwm-crc.c
   - pwm-img.c
   - pwm-imx.c (1 of 2 pwm_ops in this driver)
   - pwm-lp3943.c
   - pwm-lpc32xx.c
   - pwm-mediatek.c
   - pwm-mtk-disp.c
   - pwm-mxs.c
   - pwm-pca9685.c
   - pwm-puv3.c
   - pwm-pxa.c
   - pwm-rcar.c
   - pwm-spear.c
   - pwm-sti.c
   - pwm-stmpe.c
   - pwm-twl-led.c
   - pwm-twl.c
   - pwm-tegra.c
 =20
b) supports inversion in hardware and pwm_state, polarity handling looks fi=
ne:
   - pwm-bcm-iproc.c
   - pwm-hibvt.c
   - pwm-rockchip.c
   - pwm-sun4i.c
   - pwm-zx.c

c) not ported to pwm_state, supports .set_polarity in hardware:
   - pwm-atmel-tcb.c
   - pwm-bcm2835.c
   - pwm-bcm-kona.c
   - pwm-berlin.c
   - pwm-ep93xx.c
   - pwm-fsl-ftm.c
   - pwm-lpc18xx-sct.c
   - pwm-jz4740.c
   - pwm-omap-dmtimer.c (not sure here, didn't find the actual implementati=
on)
   - pwm-renesas-tpu.c
   - pwm-samsung.c
   - pwm-vt8500.c
   - pwm-tiehrpwm.c
   - pwm-tiecap.c

d) implements pwm_state, but ignores polarity:
   - pwm-cros-ec.c
   - pwm-lpss.c (with pwm-lpss-pci.c, pwm-lpss-platform.c)

e) supports state, but doesn't check .polarity on disable
   - pwm-atmel.c
   - pwm-atmel-hlcdc.c
   - pwm-imx.c (1 of 2 pwm_ops in this driver)
   - pwm-meson.c
   - pwm-stm32.c
   - pwm-stm32-lp.c

f) not actually a pwm driver (huh?):
   - pwm-tipwmss.c

So it's not as worse as I expected, mainly because some drivers don't
mention PWM_POLARITY_INVERSED but test for PWM_POLARITY_NORMAL.

The drivers in categories d) and e) are definitively broken and need
fixing. Some in the categories b) and c) might have the same problem as
imx (i.e. the output doesn't behave in pwm_disable(pwm) as in
pwm_config(pwm, 0, period)), but I'm unable to research that without the
respective hardware on my desk. (Reading the HW manual probably isn't
enough because most of them won't be explicit what happens in "off"
state. At least that's the case for the imx manual.)

> So again, if somebody notices that any of the other drivers are broken,
> please do report it so that it can be fixed. Otherwise I don't have a
> choice but assume that they still work.

done. :-)

> [...]

I deleted a big part of your mail and the repeating arguments I already
wrote in reply to it. I hope to work towards a compromise this way and
taking some heat out of the discussion.

> To be honest, the whole discussion here is somewhat unproductive.

I think the problem in this discussion is that there is a
misunderstanding between us. In my eyes the current state is:

I want to implement a change to the PWM API because I see a benefit in
it. I listed several advantages, some of them you accepted. You claimed
there was a disadvantage that makes the API less expressive. I tried to
understand that, asked several times for an example where the difference
you see actually matters but I don't get a reply to this question.

In this state I cannot invalidate your claim and I stay dissatisfied
because my incentive for a change is blocked by an argument I think is
void.

So I'll try to only discuss in the remaining part of this mail the
single issue that I think is key to our discussion:

You state there was a difference between

	pwm_disable(pwm);

and

	pwm_config(pwm, 0, period);

In my eyes they are equivalent. Both are expected to set the output to
inactive (that is 0 for an uninverted PWM, 1 for an inverted one).

The only differences I see are:

 - hardware driver details
   Some driver might not disable some resources after pwm_config and so
   failing to save some power. You stated however this is not the
   relevant issue.
 - after pwm_config(pwm, 0, period) pwm_enable(pwm) doesn't restore the old
   duty cycle.
   So with my suggested change the PWM framework stops caching the duty
   cycle. This appears too tiny for a reason to me to actually matter.

I assume I failed to list the detail you consider relevant. Can you
please make an effort to describe a use-case where the difference you
care about actually matters?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
