From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Subject: Re: [PATCH 6/6] hwmon: pwm-fan: Update the duty cycle inorder to
 control the pwm-fan
Date: Fri, 10 Apr 2015 14:00:01 +0200
Message-ID: <1428667201.22057.20.camel@collabora.co.uk>
References: <1427387955-5129-1-git-send-email-linux.amoon@gmail.com>
	 <1427387955-5129-7-git-send-email-linux.amoon@gmail.com>
	 <20150408104415.07e1c821@amdc2363> <20150408153214.GA15942@roeck-us.net>
	 <CANAwSgSD52sDpP7NH2hhiZX-=LZF6Qo-X3enqsqM+5XAMfyP=Q@mail.gmail.com>
	 <20150408165351.GA22846@roeck-us.net>
	 <CANAwSgQbNV9QZ2bFGk6g+RyWW6f5iW4e8ii_5rJ4srv02L=L_Q@mail.gmail.com>
	 <CANAwSgRSxj9frUHRXh3JwD+bpnFrj8WkpDMKHZn-OPmuCEgP7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CANAwSgRSxj9frUHRXh3JwD+bpnFrj8WkpDMKHZn-OPmuCEgP7w@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Anand Moon <linux.amoon@gmail.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Lukasz Majewski <l.majewski@samsung.com>, Eduardo Valentin <edubezval@gmail.com>, Russell King <linux@arm.linux.org.uk>, Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Markus Reichl <m.reichl@fivetechno.de>
List-Id: linux-pwm@vger.kernel.org

Hey Anand,

On Fri, 2015-04-10 at 16:58 +0530, Anand Moon wrote:
> Hi Guenter/Lukasz,
>=20
> Earlier I send v2 version of the patch spiking this one.
>=20
> Markus Riechl came back to me with below mail.
> So This patch confirms fixes the bug.
>=20
> I will send v3 version of the patch. Earlier I was in delima about th=
e bug.
>=20
> -Anand Moon
> -------------------------------------------
> Hi Anand,
>=20
> I tested your patch.
>=20
> After booting the fan is spinning despite only 44=C2=B0C.
>=20
> /sys/class/thermal/cooling_device0/curstate is 0.
> /sys/class/hwmon/hwmon4/pwm1 is 0
>=20
> when I echo 1 > cur_state and then echo 0 > cur_state again,
> the fan switches to off and behaves as expected.
>=20
> It looks like there is a bug in initializing the pwm output
> immediately after booting.

The problem here will be that at boot the PWM runs at full duty. With
the current exynos PWM drive if you disable the PWM it will stop pulsin=
g
but remain high if it was at 100% duty. My patch on which you depend
upon fixed a race  where disabling the pwm right after changing the dut=
y
cycle (e.g. to 0%) also kept the signal high.=20

=46rom looking at other PWM users at the time it seemed that most if no=
t
all always first set to duty to 0% and then disable the pwm. Which
should work fine on exynos now. However iirc Thierry recently clarified
that the expected result of pwm_disable is not just that the modulation
stops but also that the output signal goes low, although that's not ver=
y
explicit in the current pwm documentation.. The exynos PWM driver will
need another fix tweak to make that true.



> Best Regards,



> --
> Markus Reichl
>=20
> On 8 April 2015 at 23:19, Anand Moon <linux.amoon@gmail.com> wrote:
> > Hi Guenter,
> >
> > Sorry my blunder mistake. Sorry for the noise.
> >
> > I just tested with spiking this patch and my observation and testin=
g
> > were wrong we can skip this patch.
> >
> > I will send an v2 patch series removing the patch 5 and patch 6.
> >
> > With correct dts changes.
> >
> > Thanks for pointing my mistake.
> >
> > -Anand Moon
> >
> > On 8 April 2015 at 22:23, Guenter Roeck <linux@roeck-us.net> wrote:
> >> On Wed, Apr 08, 2015 at 09:32:05PM +0530, Anand Moon wrote:
> >>> Hi Guenter,
> >>>
> >>> Initially the board bootup the cooling level state is 0.
> >>> So update the duty cycle and this power off the fan.
> >>> As their is no state change the fan will not spin.
> >>>
> >>> Once the temperature sensor is reached to alert temperature it ch=
anges state.
> >>> With the state change the fan cools the CPU and then stop's
> >>>
> >>> I have observed this state change with tmon utility in linux/tool=
s/thermal/tmon/
> >>>
> >> Sorry, I am missing something. I still don't see what problem you =
are fixing
> >> with this patch. What behavior is wrong with the current code, and=
 how does your
> >> patch fix it ?
> >>
> >> Guenter
> >>
> >>> -Anand Moon
> >>>
> >>> On 8 April 2015 at 21:02, Guenter Roeck <linux@roeck-us.net> wrot=
e:
> >>> > On Wed, Apr 08, 2015 at 10:44:15AM +0200, Lukasz Majewski wrote=
:
> >>> >> Hi Anand,
> >>> >>
> >>> >> > Below changes depend on following patch.
> >>> >> > https://patchwork.kernel.org/patch/5944061/
> >>> >> >
> >>> >> > Update the pwm_config with duty then update the pwm_disable
> >>> >> > to poweroff the cpu fan.
> >>> >> >
> >>> >
> >>> > Unfortunately, the patch does not include an explanation why it=
 is needed.
> >>> >
> >>> > The original code presumably did not update the duty cycle beca=
use
> >>> > pwm was about to be disabled anyway. That kind of made sense to=
 me.
> >>> > Updating the duty cycle to 0 just to disable the pwm channel ri=
ght
> >>> > afterwards does not immediately make sense.
> >>> >
> >>> > Given that, I would expect to see a rationale here. Why is this=
 patch needed ?
> >>> > Does it fix a bug ? If yes, pelase describe the bug. If not, wh=
at is the
> >>> > purpose of this patch ?
> >>> >
> >>> > Maybe that is all explained in patch 0/6, which I was not copie=
d on. Even
> >>> > if so, the reationale will be needed in the changelog to explai=
n to future
> >>> > developers why this change was made.
> >>> >
> >>> > Thanks,
> >>> > Guenter
> >>> >
> >>> >> > Tested on OdroidXU3 board.
> >>> >> >
> >>> >> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> >>> >> > ---
> >>> >> >  drivers/hwmon/pwm-fan.c | 10 ++++------
> >>> >> >  1 file changed, 4 insertions(+), 6 deletions(-)
> >>> >> >
> >>> >> > diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan=
=2Ec
> >>> >> > index 7c83dc4..f25c841 100644
> >>> >> > --- a/drivers/hwmon/pwm-fan.c
> >>> >> > +++ b/drivers/hwmon/pwm-fan.c
> >>> >> > @@ -44,26 +44,24 @@ static int  __set_pwm(struct pwm_fan_ctx=
 *ctx,
> >>> >> > unsigned long pwm) int ret =3D 0;
> >>> >> >
> >>> >> >     mutex_lock(&ctx->lock);
> >>> >> > +
> >>> >
> >>> > [ please refrain from unnecessary whitespace changes ]
> >>> >
> >>> >> >     if (ctx->pwm_value =3D=3D pwm)
> >>> >> >             goto exit_set_pwm_err;
> >>> >> >
> >>> >> > -   if (pwm =3D=3D 0) {
> >>> >> > -           pwm_disable(ctx->pwm);
> >>> >> > -           goto exit_set_pwm;
> >>> >> > -   }
> >>> >> > -
> >>> >> >     duty =3D DIV_ROUND_UP(pwm * (ctx->pwm->period - 1), MAX_=
PWM);
> >>> >> >     ret =3D pwm_config(ctx->pwm, duty, ctx->pwm->period);
> >>> >> >     if (ret)
> >>> >> >             goto exit_set_pwm_err;
> >>> >> >
> >>> >> > +   if (pwm =3D=3D 0)
> >>> >> > +           pwm_disable(ctx->pwm);
> >>> >> > +
> >>> >> >     if (ctx->pwm_value =3D=3D 0) {
> >>> >> >             ret =3D pwm_enable(ctx->pwm);
> >>> >> >             if (ret)
> >>> >> >                     goto exit_set_pwm_err;
> >>> >> >     }
> >>> >> >
> >>> >> > -exit_set_pwm:
> >>> >> >     ctx->pwm_value =3D pwm;
> >>> >> >  exit_set_pwm_err:
> >>> >> >     mutex_unlock(&ctx->lock);
> >>> >>
> >>> >> Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>
> >>> >>
> >>> >> BTW: I've added Guenter to CC.
> >>> >>
> >>> >> --
> >>> >> Best regards,
> >>> >>
> >>> >> Lukasz Majewski
> >>> >>
> >>> >> Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
