Date: Mon, 24 Jun 2013 22:53:42 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 11/18] pwm: Add new pwm-samsung driver
Message-ID: <20130624205342.GE7163@mithrandir>
References: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com>
 <1888817.YsvuAKkSk2@flatron>
 <20130624201326.GB7163@mithrandir>
 <3059286.XLVAQe4lge@flatron>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jKBxcB1XkHIR0Eqt"
Content-Disposition: inline
In-Reply-To: <3059286.XLVAQe4lge@flatron>
List-ID: <linux-pwm.vger.kernel.org>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>


--jKBxcB1XkHIR0Eqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2013 at 10:32:55PM +0200, Tomasz Figa wrote:
> On Monday 24 of June 2013 22:13:27 Thierry Reding wrote:
> > On Mon, Jun 24, 2013 at 08:31:43PM +0200, Tomasz Figa wrote:
[...]
> > > Channel reservation between clocksource and PWM drivers is completely
> > > correct, relying on the fact that the former can only use channels
> > > _without_ outputs and the latter can only use channels _with_ outputs.
> > > Do I have to add that there can't be a channel both with and without
> > > output?
> > The issue is that you can't really ensure that both the clocksource and
> > PWM drivers use the same variant and therefore might be using different
> > masks.
>=20
> Output mask is _not_ a part of the constant variant data. It is stored in=
=20
> the same struct, which is to simplify passing SoC-specific parameters fro=
m=20
> platform code to both drivers, but it is not defined as a constant=20
> anywhere in drivers.
>=20
> As I already explained in one of my previous replies, it is either parsed=
=20
> from DT (samsung,pwm-outputs property) or passed through the variant=20
> struct as platform_data from board files. It isn't possible for both=20
> drivers to get different mask values.

But samsung_pwm_set_platdata() and samsung_pwm_clocksource_init() can
still be called with different variants, can't they? Furthermore the
variants aren't read-only and therefore can be modified at any point in
time. So it is indeed possible for them to get different mask values.

Granted, it may be unlikely that they will but it wouldn't be all that
difficult to write the driver in a way to make it really impossible and
at the same time make sure that both driver share the same variant
information.

> > > So the only place for improvement here, without starting
> > > overengineering things, is a comment about the purpose of the
> > > spinlock and why it can be used in our case.
> >=20
> > I disagree. You actually even had a version with a halfway decent design
> > at some point and it was discarded. I don't think I'm asking for all
> > that much here. I even gave you the option of admitting that the driver
> > was suboptimal. All I request in return is that you mention that in the
> > code so that either somebody else might go and clean things up or at
> > least that nobody will copy from a bad example.
>=20
> What about:
>=20
> /*
>  * PWM block is shared between pwm-samsung and samsung_pwm_timer drivers
>  * and some registers need access synchronization. If both drivers are
>  * compiled in, the spinlock is defined in the clocksource driver,
>  * otherwise following definition is used.
>  *
>  * Currently we do not need any more complex synchronization method=20
>  * because all the supported SoCs contain only one instance of the PWM=20
>  * IP. Should this change, both drivers will need to be modified to
>  * properly synchronize accesses to particular instances.
>  */

I see that you can't be persuaded. And everybody else seems to be okay
with it so... have it your way. I'm probably going to regret this.

Thierry

--jKBxcB1XkHIR0Eqt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRyLHVAAoJEN0jrNd/PrOhiawP/0L+t7l2Shv/KwFExfJNwt7B
wbwpx4nL4l4D+Uda6pUbpKJzu8P+livrHtZ2gLdcY9tFPq/kSlWlbCt0YncB/Dvv
eaaUUousHkl2yG4AxD5S9obIEIws0cR03gUZ3gKsaTJpwKNMcbQtvdM8OqzQTON/
H3MpTHjPH7fFSYQJFPlaOv5NiK5XsYAkLjeCVAMh2VMg98fVvxaYlYxhmPjPvm5B
eYi5sXES65/VOuGSsHa0M+OklEH2+JYeQ6lI2g3SKSNIk5jIUV9X6SyVOfRPodyN
kgKUKcXGki1YsPDWJ8loqcFoSujkfmZtjj/dCVXN3Hwms2e30Hcf55n1tRtr1zr2
84X1euL3Yy0PxrK/j+FQy2KwWB2b/RZrLe4MnBlaLC04P4cPKZMzbxVPC/dqyqEl
VQqL+tTR1hJ89QE4Nk1xUE3QJh45kD01ZUzoHxgHXPR2utPiF5USkcWtAEPR4yCa
QpxalNr3idMI4zr7jj3gQ3PQgysRK5zigrulw2AZySQHO6Be807pWcwRnq97wkeU
Yo1ArfUJ1IpXv1HOzYhvc5JdNMmD4zfDeNfRaWqQSrCxvJymsec2bIOigLbh7Eu7
xDwMZ3IWJ6HpHFWLV9B01Jz5fejk4WQhF5gUC9ycBZmIfn2AUf51RdMoQw+5mQoK
9s0beHeD/GccraK6SCBT
=p44g
-----END PGP SIGNATURE-----

--jKBxcB1XkHIR0Eqt--
