From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] backlight: pwm_bl: Set pin to sleep state when powered
 down
Date: Mon, 24 Jun 2019 16:31:57 +0200
Message-ID: <1561386717.20436.0@crapouillou.net>
References: <20190522163428.7078-1-paul@crapouillou.net>
        <5b0f8bb3-e7b0-52c1-1f2f-9709992b76fc@linaro.org>
        <20190621135608.GB11839@ulmo> <20190624112844.fmwbfpdxjkst3u7r@holly.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190624112844.fmwbfpdxjkst3u7r@holly.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, od@zcrc.me, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org



Le lun. 24 juin 2019 =E0 13:28, Daniel Thompson=20
<daniel.thompson@linaro.org> a =E9crit :
> On Fri, Jun 21, 2019 at 03:56:08PM +0200, Thierry Reding wrote:
>>  On Fri, Jun 21, 2019 at 01:41:45PM +0100, Daniel Thompson wrote:
>>  > On 22/05/2019 17:34, Paul Cercueil wrote:
>>  > > When the driver probes, the PWM pin is automatically configured=20
>> to its
>>  > > default state, which should be the "pwm" function.
>>  >
>>  > At which point in the probe... and by who?
>>=20
>>  The driver core will select the "default" state of a device right=20
>> before
>>  calling the driver's probe, see:
>>=20
>>  	drivers/base/pinctrl.c: pinctrl_bind_pins()
>>=20
>>  which is called from:
>>=20
>>  	drivers/base/dd.c: really_probe()
>>=20
>=20
> Thanks. I assumed it would be something like that... although given
> pwm-backlight is essentially a wrapper driver round a PWM I wondered=20
> why
> the pinctrl was on the backlight node (rather than the PWM node).
>=20
> Looking at the DTs in the upstream kernel it looks like ~20% of the
> backlight drivers have pinctrl on the backlight node. Others=20
> presumable
> have none or have it on the PWM node (and it looks like support for
> sleeping the pins is *very* rare amoung the PWM drivers).

If your PWM driver has more than one channel and has the pinctrl node,=20
you
cannot fine-tune the state of individual pins. They all share the same=20
state.

>>  > > However, at this
>>  > > point we don't know the actual level of the pin, which may be=20
>> active or
>>  > > inactive. As a result, if the driver probes without enabling the
>>  > > backlight, the PWM pin might be active, and the backlight would=20
>> be
>>  > > lit way before being officially enabled.
>>  > >
>>  > > To work around this, if the probe function doesn't enable the=20
>> backlight,
>>  > > the pin is set to its sleep state instead of the default one,=20
>> until the
>>  > > backlight is enabled. Whenk the backlight is disabled, the pin=20
>> is reset
>>  > > to its sleep state.
>>  > Doesn't this workaround result in a backlight flash between=20
>> whatever enables
>>  > it and the new code turning it off again?
>>=20
>>  Yeah, I think it would. I guess if you're very careful on how you=20
>> set up
>>  the device tree you might be able to work around it. Besides the=20
>> default
>>  and idle standard pinctrl states, there's also the "init" state. The
>>  core will select that instead of the default state if available.=20
>> However
>>  there's also pinctrl_init_done() which will try again to switch to=20
>> the
>>  default state after probe has finished and the driver didn't switch=20
>> away
>>  from the init state.
>>=20
>>  So you could presumably set up the device tree such that you have=20
>> three
>>  states defined: "default" would be the one where the PWM pin is=20
>> active,
>>  "idle" would be used when backlight is off (PWM pin inactive) and=20
>> then
>>  another "init" state that would be the same as "idle" to be used=20
>> during
>>  probe. During probe the driver could then switch to the "idle"=20
>> state so
>>  that the pin shouldn't glitch.
>>=20
>>  I'm not sure this would actually work because I think the way that
>>  pinctrl handles states both "init" and "idle" would be the same=20
>> pointer
>>  values and therefore pinctrl_init_done() would think the driver=20
>> didn't
>>  change away from the "init" state because it is the same pointer=20
>> value
>>  as the "idle" state that the driver selected. One way to work around
>>  that would be to duplicate the "idle" state definition and=20
>> associate one
>>  instance of it with the "idle" state and the other with the "init"
>>  state. At that point both states should be different (different=20
>> pointer
>>  values) and we'd get the init state selected automatically before=20
>> probe,
>>  select "idle" during probe and then the core will leave it alone.=20
>> That's
>>  of course ugly because we duplicate the pinctrl state in DT, but=20
>> perhaps
>>  it's the least ugly solution.
>>  Adding Linus for visibility. Perhaps he can share some insight.
>=20
> To be honest I'm happy to summarize in my head as "if it flashes then=20
> it's not
> a pwm_bl.c's problem" ;-).

It does not flash. But the backlight lits way too early, so we have a=20
1-2 seconds
of "white screen" before the panel driver starts.

-Paul

>=20
> Daniel.
>=20
>=20
>>=20
>>  On that note, I'm wondering if perhaps it'd make sense for pinctrl=20
>> to
>>  support some mode where a device would start out in idle mode. That=20
>> is,
>>  where pinctrl_bind_pins() would select the "idle" mode as the=20
>> default
>>  before probe. With something like that we could easily support this
>>  use-case without glitching.
>>=20
>>  I suppose yet another variant would be for the PWM backlight to not=20
>> use
>>  any of the standard pinctrl states at all. Instead it could just=20
>> define
>>  custom states, say "active" and "inactive". Looking at the code that
>>  would prevent pinctrl_bind_pins() from doing anything with pinctrl
>>  states and given the driver exact control over when each of the=20
>> states
>>  will be selected. That's somewhat suboptimal because we can't make=20
>> use
>>  of the pinctrl PM helpers and it'd require more boilerplate.
>>=20
>>  Thierry
>>=20
>>  > > Signed-off-by: Paul Cercueil <paul@crapouillou.net> > ---
>>  > >   drivers/video/backlight/pwm_bl.c | 9 +++++++++
>>  > >   1 file changed, 9 insertions(+)
>>  > >
>>  > > diff --git a/drivers/video/backlight/pwm_bl.c=20
>> b/drivers/video/backlight/pwm_bl.c
>>  > > index fb45f866b923..422f7903b382 100644
>>  > > --- a/drivers/video/backlight/pwm_bl.c
>>  > > +++ b/drivers/video/backlight/pwm_bl.c
>>  > > @@ -16,6 +16,7 @@
>>  > >   #include <linux/module.h>
>>  > >   #include <linux/kernel.h>
>>  > >   #include <linux/init.h>
>>  > > +#include <linux/pinctrl/consumer.h>
>>  > >   #include <linux/platform_device.h>
>>  > >   #include <linux/fb.h>
>>  > >   #include <linux/backlight.h>
>>  > > @@ -50,6 +51,8 @@ static void pwm_backlight_power_on(struct=20
>> pwm_bl_data *pb)
>>  > >   	struct pwm_state state;
>>  > >   	int err;
>>  > > +	pinctrl_pm_select_default_state(pb->dev);
>>  > > +
>>  > >   	pwm_get_state(pb->pwm, &state);
>>  > >   	if (pb->enabled)
>>  > >   		return;
>>  > > @@ -90,6 +93,8 @@ static void pwm_backlight_power_off(struct=20
>> pwm_bl_data *pb)
>>  > >   	regulator_disable(pb->power_supply);
>>  > >   	pb->enabled =3D false;
>>  > > +
>>  > > +	pinctrl_pm_select_sleep_state(pb->dev);
>>  > >   }
>>  > >   static int compute_duty_cycle(struct pwm_bl_data *pb, int=20
>> brightness)
>>  > > @@ -626,6 +631,10 @@ static int pwm_backlight_probe(struct=20
>> platform_device *pdev)
>>  > >   	backlight_update_status(bl);
>>  > >   	platform_set_drvdata(pdev, bl);
>>  > > +
>>  > > +	if (bl->props.power =3D=3D FB_BLANK_POWERDOWN)
>>  > > +		pinctrl_pm_select_sleep_state(&pdev->dev);
>>  >
>>  > Didn't backlight_update_status(bl) already do this?
>>  >
>>  >
>>  > Daniel.
>>  >
>>  >
>>  > > +
>>  > >   	return 0;
>>  > >   err_alloc:
>>  > >
>>  >
>=20
>=20

=
