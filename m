From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 6/6] hwmon: pwm-fan: Update the duty cycle inorder to
 control the pwm-fan
Date: Fri, 10 Apr 2015 15:58:46 +0200
Message-ID: <20150410135844.GA20147@ulmo.nvidia.com>
References: <20150408104415.07e1c821@amdc2363>
 <20150408153214.GA15942@roeck-us.net>
 <CANAwSgSD52sDpP7NH2hhiZX-=LZF6Qo-X3enqsqM+5XAMfyP=Q@mail.gmail.com>
 <20150408165351.GA22846@roeck-us.net>
 <CANAwSgQbNV9QZ2bFGk6g+RyWW6f5iW4e8ii_5rJ4srv02L=L_Q@mail.gmail.com>
 <CANAwSgRSxj9frUHRXh3JwD+bpnFrj8WkpDMKHZn-OPmuCEgP7w@mail.gmail.com>
 <1428667201.22057.20.camel@collabora.co.uk>
 <CANAwSgQHi2-i8xHn+X+KTGg8HFpe6SPgkuSvuApJP3342N8+zQ@mail.gmail.com>
 <5527CB78.4040002@roeck-us.net>
 <1428672601.22057.25.camel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1428672601.22057.25.camel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Cc: Guenter Roeck <linux@roeck-us.net>, Anand Moon <linux.amoon@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Eduardo Valentin <edubezval@gmail.com>, Russell King <linux@arm.linux.org.uk>, Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Markus Reichl <m.reichl@fivetechno.de>
List-Id: linux-pwm@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2015 at 03:30:01PM +0200, Sjoerd Simons wrote:
> On Fri, 2015-04-10 at 06:09 -0700, Guenter Roeck wrote:
> > On 04/10/2015 05:59 AM, Anand Moon wrote:
> > > Hi Sjoerd,
> > >
> > > I don't much advance knowledge on internal signaling of pwm-samsung m=
odule.
> > >
> > > So do I need to send this patch again ?
> > >
> >=20
> >  From the context, it seems that the fix in hwmon would only paint
> > over a problem in the actual pwm driver, correct ?
>=20
> Yes/no/maybe :). Imho this is something to clarify in the pwm API
> documentation. As currently all it says is:=20
>   "pwm_disable - stop a PWM output toggling",=20
>=20
> Which is what the exynos driver does.=20
>=20
> Thierry, could you clearify what the intention is here? I'm happy to
> prepare a pwm driver patch if needed to solve this?

I think the safest thing to do is for users to do both. You call
pwm_config() with a zero duty cycle to make it clear what the status is
that you want. Then you call pwm_disable() to state that you don't need
the output signal anymore, so that any clocks needed by the PWM can be
stopped. Doing so gives the driver the most information and should make
the user more resilient against any possible quirks in drivers.

Drivers that on pwm_disable() still invert the signal should still be
fixed, though. In the cases that I'm aware of the sequence of setting
the duty cycle to 0 and calling pwm_disable() won't actually paper over
any bugs. It's precisely that sequence that triggers the bug. Merely
calling pwm_disable() should trigger it as well, pwm_config(0) without
pwm_disable() would hide it.

Thierry

> > If you resubmit the patch I would expect you to explain this in the
> > commit log.
> >=20
> > Guenter
> >=20
> > > -Anand Moon
> > >
> > >
> > > On 10 April 2015 at 17:30, Sjoerd Simons <sjoerd.simons@collabora.co.=
uk> wrote:
> > >> Hey Anand,
> > >>
> > >> On Fri, 2015-04-10 at 16:58 +0530, Anand Moon wrote:
> > >>> Hi Guenter/Lukasz,
> > >>>
> > >>> Earlier I send v2 version of the patch spiking this one.
> > >>>
> > >>> Markus Riechl came back to me with below mail.
> > >>> So This patch confirms fixes the bug.
> > >>>
> > >>> I will send v3 version of the patch. Earlier I was in delima about =
the bug.
> > >>>
> > >>> -Anand Moon
> > >>> -------------------------------------------
> > >>> Hi Anand,
> > >>>
> > >>> I tested your patch.
> > >>>
> > >>> After booting the fan is spinning despite only 44=C2=B0C.
> > >>>
> > >>> /sys/class/thermal/cooling_device0/curstate is 0.
> > >>> /sys/class/hwmon/hwmon4/pwm1 is 0
> > >>>
> > >>> when I echo 1 > cur_state and then echo 0 > cur_state again,
> > >>> the fan switches to off and behaves as expected.
> > >>>
> > >>> It looks like there is a bug in initializing the pwm output
> > >>> immediately after booting.
> > >>
> > >> The problem here will be that at boot the PWM runs at full duty. With
> > >> the current exynos PWM drive if you disable the PWM it will stop pul=
sing
> > >> but remain high if it was at 100% duty. My patch on which you depend
> > >> upon fixed a race  where disabling the pwm right after changing the =
duty
> > >> cycle (e.g. to 0%) also kept the signal high.
> > >>
> > >>  From looking at other PWM users at the time it seemed that most if =
not
> > >> all always first set to duty to 0% and then disable the pwm. Which
> > >> should work fine on exynos now. However iirc Thierry recently clarif=
ied
> > >> that the expected result of pwm_disable is not just that the modulat=
ion
> > >> stops but also that the output signal goes low, although that's not =
very
> > >> explicit in the current pwm documentation.. The exynos PWM driver wi=
ll
> > >> need another fix tweak to make that true.
> > >>
> > >>
> > >>
> > >>> Best Regards,
> > >>
> > >>
> > >>
> > >>> --
> > >>> Markus Reichl
> > >>>
> > >>> On 8 April 2015 at 23:19, Anand Moon <linux.amoon@gmail.com> wrote:
> > >>>> Hi Guenter,
> > >>>>
> > >>>> Sorry my blunder mistake. Sorry for the noise.
> > >>>>
> > >>>> I just tested with spiking this patch and my observation and testi=
ng
> > >>>> were wrong we can skip this patch.
> > >>>>
> > >>>> I will send an v2 patch series removing the patch 5 and patch 6.
> > >>>>
> > >>>> With correct dts changes.
> > >>>>
> > >>>> Thanks for pointing my mistake.
> > >>>>
> > >>>> -Anand Moon
> > >>>>
> > >>>> On 8 April 2015 at 22:23, Guenter Roeck <linux@roeck-us.net> wrote:
> > >>>>> On Wed, Apr 08, 2015 at 09:32:05PM +0530, Anand Moon wrote:
> > >>>>>> Hi Guenter,
> > >>>>>>
> > >>>>>> Initially the board bootup the cooling level state is 0.
> > >>>>>> So update the duty cycle and this power off the fan.
> > >>>>>> As their is no state change the fan will not spin.
> > >>>>>>
> > >>>>>> Once the temperature sensor is reached to alert temperature it c=
hanges state.
> > >>>>>> With the state change the fan cools the CPU and then stop's
> > >>>>>>
> > >>>>>> I have observed this state change with tmon utility in linux/too=
ls/thermal/tmon/
> > >>>>>>
> > >>>>> Sorry, I am missing something. I still don't see what problem you=
 are fixing
> > >>>>> with this patch. What behavior is wrong with the current code, an=
d how does your
> > >>>>> patch fix it ?
> > >>>>>
> > >>>>> Guenter
> > >>>>>
> > >>>>>> -Anand Moon
> > >>>>>>
> > >>>>>> On 8 April 2015 at 21:02, Guenter Roeck <linux@roeck-us.net> wro=
te:
> > >>>>>>> On Wed, Apr 08, 2015 at 10:44:15AM +0200, Lukasz Majewski wrote:
> > >>>>>>>> Hi Anand,
> > >>>>>>>>
> > >>>>>>>>> Below changes depend on following patch.
> > >>>>>>>>> https://patchwork.kernel.org/patch/5944061/
> > >>>>>>>>>
> > >>>>>>>>> Update the pwm_config with duty then update the pwm_disable
> > >>>>>>>>> to poweroff the cpu fan.
> > >>>>>>>>>
> > >>>>>>>
> > >>>>>>> Unfortunately, the patch does not include an explanation why it=
 is needed.
> > >>>>>>>
> > >>>>>>> The original code presumably did not update the duty cycle beca=
use
> > >>>>>>> pwm was about to be disabled anyway. That kind of made sense to=
 me.
> > >>>>>>> Updating the duty cycle to 0 just to disable the pwm channel ri=
ght
> > >>>>>>> afterwards does not immediately make sense.
> > >>>>>>>
> > >>>>>>> Given that, I would expect to see a rationale here. Why is this=
 patch needed ?
> > >>>>>>> Does it fix a bug ? If yes, pelase describe the bug. If not, wh=
at is the
> > >>>>>>> purpose of this patch ?
> > >>>>>>>
> > >>>>>>> Maybe that is all explained in patch 0/6, which I was not copie=
d on. Even
> > >>>>>>> if so, the reationale will be needed in the changelog to explai=
n to future
> > >>>>>>> developers why this change was made.
> > >>>>>>>
> > >>>>>>> Thanks,
> > >>>>>>> Guenter
> > >>>>>>>
> > >>>>>>>>> Tested on OdroidXU3 board.
> > >>>>>>>>>
> > >>>>>>>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > >>>>>>>>> ---
> > >>>>>>>>>   drivers/hwmon/pwm-fan.c | 10 ++++------
> > >>>>>>>>>   1 file changed, 4 insertions(+), 6 deletions(-)
> > >>>>>>>>>
> > >>>>>>>>> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> > >>>>>>>>> index 7c83dc4..f25c841 100644
> > >>>>>>>>> --- a/drivers/hwmon/pwm-fan.c
> > >>>>>>>>> +++ b/drivers/hwmon/pwm-fan.c
> > >>>>>>>>> @@ -44,26 +44,24 @@ static int  __set_pwm(struct pwm_fan_ctx =
*ctx,
> > >>>>>>>>> unsigned long pwm) int ret =3D 0;
> > >>>>>>>>>
> > >>>>>>>>>      mutex_lock(&ctx->lock);
> > >>>>>>>>> +
> > >>>>>>>
> > >>>>>>> [ please refrain from unnecessary whitespace changes ]
> > >>>>>>>
> > >>>>>>>>>      if (ctx->pwm_value =3D=3D pwm)
> > >>>>>>>>>              goto exit_set_pwm_err;
> > >>>>>>>>>
> > >>>>>>>>> -   if (pwm =3D=3D 0) {
> > >>>>>>>>> -           pwm_disable(ctx->pwm);
> > >>>>>>>>> -           goto exit_set_pwm;
> > >>>>>>>>> -   }
> > >>>>>>>>> -
> > >>>>>>>>>      duty =3D DIV_ROUND_UP(pwm * (ctx->pwm->period - 1), MAX_=
PWM);
> > >>>>>>>>>      ret =3D pwm_config(ctx->pwm, duty, ctx->pwm->period);
> > >>>>>>>>>      if (ret)
> > >>>>>>>>>              goto exit_set_pwm_err;
> > >>>>>>>>>
> > >>>>>>>>> +   if (pwm =3D=3D 0)
> > >>>>>>>>> +           pwm_disable(ctx->pwm);
> > >>>>>>>>> +
> > >>>>>>>>>      if (ctx->pwm_value =3D=3D 0) {
> > >>>>>>>>>              ret =3D pwm_enable(ctx->pwm);
> > >>>>>>>>>              if (ret)
> > >>>>>>>>>                      goto exit_set_pwm_err;
> > >>>>>>>>>      }
> > >>>>>>>>>
> > >>>>>>>>> -exit_set_pwm:
> > >>>>>>>>>      ctx->pwm_value =3D pwm;
> > >>>>>>>>>   exit_set_pwm_err:
> > >>>>>>>>>      mutex_unlock(&ctx->lock);
> > >>>>>>>>
> > >>>>>>>> Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>
> > >>>>>>>>
> > >>>>>>>> BTW: I've added Guenter to CC.
> > >>>>>>>>
> > >>>>>>>> --
> > >>>>>>>> Best regards,
> > >>>>>>>>
> > >>>>>>>> Lukasz Majewski
> > >>>>>>>>
> > >>>>>>>> Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
> > >>
> > >>
> > >
> >=20
>=20
>=20

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVJ9cSAAoJEN0jrNd/PrOhZ2EP/0KJv1lXxe7+u1UWUdNRIJie
aTkfnFseTpXy0UT3agEVJg1FZYuppJtLlD2bj8sSg112YnT5knWde3gobJgsUdiB
05SnVHTF/DjldvAcAV4pl5P1ha6K6G0vLOgmiDuTHllowHKsQa5k5LrRTG4ewlDe
OyVMb4WwBIz0mO7VGZ9IqODm/QvXN8PL9n+FDmnzSfwxEiRbayyPl7DPpzTQSOCb
rvpDlKfHvERlBEu1YqIfY5MUwU5fTOUDuTjoe9TfQoEcTQIm2wkg0Tx0cTgXbe9e
tcEwkfaQ1U8oXj/MLkTlXbfuRYz7lslqt9OqDcwbmjJmsyDj7Tqrl3eGJ8ZzyZpJ
ev4umGtXZmbLklWh5gqNIRDPigHuSqIg0wKBIFQsvxzVZx4Xhsi9Rsi9GTPWPdxC
QBsmPE6JsIOheJFGmqWKm6t/FUFD1h0cuRVZ2uhu9zxUyW0zqGPy57q36zEQ5AWD
U4nFmE5BHwyvi/+u8nLNIrBhoqFqHwD9vmrrOAi7QHqFoO4lag39SPKqVpxtuPj/
RbFU/CWKhyKR6CWRTD7AL0kYBgLvFDYqhBLEEHr938Gh9gdpycGouvmb9oePmp3t
H5RiA6Lok/tB5D9lM5FO/Sk7TgqEha9rv9NzHDZAqhmD+oOkhdLg0/IC2ojL5tjU
xA6uPXDrnO1UcemFbWDi
=QteG
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
