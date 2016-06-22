From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: improve args checking in pwm_apply_state()
Date: Wed, 22 Jun 2016 14:00:42 +0200
Message-ID: <20160622120042.GA26943@ulmo.ba.sec>
References: <1464367549-111530-1-git-send-email-briannorris@chromium.org>
 <CAMuHMdUVgwb8QwKcORDuoJUCJJKE7Xmzg3R45S1VdnupAXUx0w@mail.gmail.com>
 <20160621183730.GA130978@google.com>
 <20160622100422.5c34f975@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160622100422.5c34f975@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Brian Norris <briannorris@chromium.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux PWM List <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Doug Anderson <dianders@chromium.org>, linux-renesas-soc@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: linux-pwm@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 22, 2016 at 10:04:22AM +0200, Boris Brezillon wrote:
> On Tue, 21 Jun 2016 11:37:31 -0700
> Brian Norris <briannorris@chromium.org> wrote:
>=20
> > Hi Geert,
> >=20
> > On Tue, Jun 21, 2016 at 04:42:04PM +0200, Geert Uytterhoeven wrote:
> > > On Fri, May 27, 2016 at 6:45 PM, Brian Norris <briannorris@chromium.o=
rg> wrote: =20
> > > > It seems like in the process of refactoring pwm_config() to utilize=
 the
> > > > newly-introduced pwm_apply_state() API, some args/bounds checking w=
as
> > > > dropped.
> > > >
> > > > In particular, I noted that we are now allowing invalid period
> > > > selections. e.g.:
> > > >
> > > >   # echo 1 > /sys/class/pwm/pwmchip0/export
> > > >   # cat /sys/class/pwm/pwmchip0/pwm1/period
> > > >   100
> > > >   # echo 101 > /sys/class/pwm/pwmchip0/pwm1/duty_cycle
> > > >   [... driver may or may not reject the value, or trigger some logi=
c bug ...]
> > > >
> > > > It's better to see:
> > > >
> > > >   # echo 1 > /sys/class/pwm/pwmchip0/export
> > > >   # cat /sys/class/pwm/pwmchip0/pwm1/period
> > > >   100
> > > >   # echo 101 > /sys/class/pwm/pwmchip0/pwm1/duty_cycle
> > > >   -bash: echo: write error: Invalid argument
> > > >
> > > > This patch reintroduces some bounds checks in both pwm_config() (fo=
r its
> > > > signed parameters; we don't want to convert negative values into la=
rge
> > > > unsigned values) and in pwm_apply_state() (which fix the above desc=
ribed
> > > > behavior, as well as other potential API misuses).
> > > >
> > > > Fixes: 5ec803edcb70 ("pwm: Add core infrastructure to allow atomic =
updates")
> > > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > > ---
> > > > v2:
> > > >  * changed subject, as this covers more scope now
> > > >  * add Fixes tag, as this is a v4.7-rc regression
> > > >  * add more bounds/args checks in pwm_apply_state() and pwm_config()
> > > >
> > > >  drivers/pwm/core.c  | 3 ++-
> > > >  include/linux/pwm.h | 3 +++
> > > >  2 files changed, 5 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > > > index dba3843c53b8..ed337a8c34ab 100644
> > > > --- a/drivers/pwm/core.c
> > > > +++ b/drivers/pwm/core.c
> > > > @@ -457,7 +457,8 @@ int pwm_apply_state(struct pwm_device *pwm, str=
uct pwm_state *state)
> > > >  {
> > > >         int err;
> > > >
> > > > -       if (!pwm)
> > > > +       if (!pwm || !state || !state->period ||
> > > > +           state->duty_cycle > state->period)
> > > >                 return -EINVAL; =20
> > >=20
> > > This check breaks the LCD backlight on r8a7740/armadillo.
> > > Apparently both period and duty_cycle are zero during the first invoc=
ation.
> > > Later, these are initialized from DT, cfr.
> > >=20
> > >         pwms =3D <&tpu 2 33333 PWM_POLARITY_INVERTED>;
> > >=20
> > > in arch/arm/boot/dts/r8a7740-armadillo800eva.dts. =20
> >=20
> > Hmm, this isn't super obvious how to best fix. On one hand, the
> > pwm_config() API used to reject period<=3D0, but on the other hand, I
> > think its replacement (pwm_apply_state()) is getting used in more places
> > than it used to be, and not all of them are really handling the "atomic
> > update" concept yet. Seems like a product of Boris's multi-phase attempt
> > to convert the PWM APIs to support atomic updates -- and many users
> > haven't really converted yet.
> >=20
> > > With added debug printing, the difference between failure and success=
 is:
> > >=20
> > >  renesas-tpu-pwm e6600000.pwm: TPU PWM -1 registered
> > >  tpu_pwm_request:223
> > >  pwm_apply_state:460: pwm backlight/2: period 0, duty_cycle 0
> > > +Ignoring failure
> > > +pwm_apply_state:479: polarity 0 -> 1
> > > +tpu_pwm_set_polarity:343
> > > +pwm_apply_state:502: period 0 -> 0
> > > +pwm_apply_state:503: duty_cycle 0 -> 0
> > > +pwm_apply_state:516: enabled 0 -> 0
> > >  pwm_config:238: pwm backlight/2: duty_ns 33333, period_ns 33333
> > >  pwm_apply_state:460: pwm backlight/2: period 33333, duty_cycle 33333
> > > -pwm_apply_state:479: polarity 0 -> 0
> > > +pwm_apply_state:479: polarity 1 -> 1
> > >  pwm_apply_state:502: period 0 -> 33333
> > >  pwm_apply_state:503: duty_cycle 0 -> 33333
> > >  tpu_pwm_config:267
> > >  pwm_apply_state:516: enabled 0 -> 0
> > >  pwm_apply_state:460: pwm backlight/2: period 33333, duty_cycle 33333
> > > -pwm_apply_state:479: polarity 0 -> 0
> > > +pwm_apply_state:479: polarity 1 -> 1
> > >  pwm_apply_state:502: period 33333 -> 33333
> > >  pwm_apply_state:503: duty_cycle 33333 -> 33333
> > >  pwm_apply_state:516: enabled 0 -> 1
> > >  tpu_pwm_enable:354 =20
> >=20
> > I'm not sure I 100% understand this debug log, but I think maybe the
> > problem is in pwm_apply_args(), which calls pwm_disable() and
> > pwm_set_polarity() sequentially, without ever configuring a period? What
> > if pwm_apply_args() were to configure the period for us?
> >=20
> > Boris, any thoughts?
> >=20
>=20
> I had second thoughts and I think you're right: pwm_apply_args()
> should set the pargs.period period for us.
>=20
> Here is a patch addressing that.
>=20
> Geert, can you test it?
>=20
> --->8---
> From 0610f7e24976e176054bce20445ff42d8aea9513 Mon Sep 17 00:00:00 2001
> From: Boris Brezillon <boris.brezillon@free-electrons.com>
> Date: Wed, 22 Jun 2016 09:25:14 +0200
> Subject: [PATCH] pwm: Fix pwm_apply_args()
>=20
> Commit 5ec803edcb70 ("pwm: Add core infrastructure to allow atomic
> updates"), implemented pwm_disable() as a wrapper around
> pwm_apply_state(), and then, commit ef2bf4997f7d ("pwm: Improve args
> checking in pwm_apply_state()") added missing checks on the ->period
> value in pwm_apply_state() to ensure we were not passing inappropriate
> values to the ->config() or ->apply() methods.
>=20
> The conjunction of these 2 commits led to a case where pwm_disable()
> was no longer succeeding, thus preventing the polarity setting done
> in pwm_apply_args().
>=20
> Set a valid period in pwm_apply_args() to ensure polarity setting
> won't be rejected.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Suggested-by: Brian Norris <briannorris@chromium.org>
> Fixes: 5ec803edcb70 ("pwm: Add core infrastructure to allow atomic update=
s")
> ---
>  include/linux/pwm.h | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 908b67c847cd..c038ae36b10e 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -464,6 +464,8 @@ static inline bool pwm_can_sleep(struct pwm_device *p=
wm)
> =20
>  static inline void pwm_apply_args(struct pwm_device *pwm)
>  {
> +	struct pwm_state state =3D { };
> +
>  	/*
>  	 * PWM users calling pwm_apply_args() expect to have a fresh config
>  	 * where the polarity and period are set according to pwm_args info.
> @@ -476,18 +478,20 @@ static inline void pwm_apply_args(struct pwm_device=
 *pwm)
>  	 * at startup (even if they are actually enabled), thus authorizing
>  	 * polarity setting.
>  	 *
> -	 * Instead of setting ->enabled to false, we call pwm_disable()
> -	 * before pwm_set_polarity() to ensure that everything is configured
> -	 * as expected, and the PWM is really disabled when the user request
> -	 * it.
> +	 * To fulfill this requirement, we apply a new state which disables
> +	 * the PWM device and set the reference period and polarity config.
>  	 *
>  	 * Note that PWM users requiring a smooth handover between the
>  	 * bootloader and the kernel (like critical regulators controlled by
>  	 * PWM devices) will have to switch to the atomic API and avoid calling
>  	 * pwm_apply_args().
>  	 */
> -	pwm_disable(pwm);
> -	pwm_set_polarity(pwm, pwm->args.polarity);
> +
> +	state.enabled =3D false;
> +	state.polarity =3D pwm->args.polarity;
> +	state.period =3D pwm->args.period;
> +
> +	pwm_apply_state(pwm, &state);
>  }
> =20
>  struct pwm_lookup {

This looks reasonable to me. I'll wait for a Tested-by from Geert before
applying, though.

Thierry

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXan3nAAoJEN0jrNd/PrOhWBAP/RwzvdgE6TJ1Xc0yZ50vk9Cg
DX65jfmyd6i0tTEvd4DJ+7ltHB6VlUKEtv/NhK6avltMULHu7J9DWKGe+uMCh1rO
RpT6muN7iqo/DddVg7hE1HkwMcm6VRVfse2d+QOjdW/SvxfiIMfXbWYlWRgptADw
cBxJUjXd343PPa57TEuLJMr/bGm4N6Ye1pjyXQU3G46gJcb+EfvDj0+RrlHYI9Dj
ZR8pCZfXJrOF6ADdpHJW6bzv8N9aB9sN3lkmTr5q5DDGTXTKLH/LUgq2BO8sEnPL
mtkF2ePaYbTXYIJoByvFL9zyeAk5r5PbI+TYrGJq/wGg5PKN2ZK3DBBumVE+2Mr5
oShxwAReNSAtUPWPyXYKQ+5FbchM0UVwV+Vfex26d0qelv7xW40zWKMu+IBw93eS
98idtorQiYgnGX0OnZi8OFRJ7wnKWkNAOo6JsXg18qreAa9oexDkIpQYZb7jKwZ/
f8S/2QBZG+/L+rdo4aoDR/vfHR8o5nqmm3Ju3lzLZXO9qx9XpZdI82bSe5D1rpGe
Utrim1NcpUqHouJbiZpcsDp4EPZt1q6kLtM8gbVNsbyHjqviQ7yR8m0pN6lRnsO+
khd3ICJsiPLH1MYCoDlV7FstOO+WfyXrPSmYuvYe5bW4pLCnXx/lQeQLUwnR0cmo
2aXdP6N4EepIndHS4Yhb
=sq5J
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
