Return-Path: <thierry.reding@gmail.com>
Date: Mon, 24 Jun 2013 22:13:27 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 11/18] pwm: Add new pwm-samsung driver
Message-ID: <20130624201326.GB7163@mithrandir>
References: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com>
 <51C86442.6090406@samsung.com>
 <20130624174903.GA6795@mithrandir>
 <1888817.YsvuAKkSk2@flatron>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
In-Reply-To: <1888817.YsvuAKkSk2@flatron>
List-ID: <linux-pwm.vger.kernel.org>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2013 at 08:31:43PM +0200, Tomasz Figa wrote:
> On Monday 24 of June 2013 19:49:04 Thierry Reding wrote:
> > On Tue, Jun 25, 2013 at 12:22:42AM +0900, Kukjin Kim wrote:
> > > On 06/22/13 22:06, Tomasz Figa wrote:
> > > >This patch introduces new Samsung PWM driver, which is heavily
> > > >cleaned,
> > > >multiplatform aware and supports DeviceTree based instantiation.
> > > >
> > > >Since on historical hardware PWM block can be shared with clocksource
> > > >driver, a shared spinlock is used to protect access to shared
> > > >registers, already exported from the clocksource driver.
> > > >
> > > >Signed-off-by: Tomasz Figa<tomasz.figa@gmail.com>
> > > >---
> > > >
> > > >  drivers/pwm/Makefile      |   1 +
> > > >  drivers/pwm/pwm-samsung.c | 601
> > > >  ++++++++++++++++++++++++++++++++++++++++++++++ 2 files changed,
> > > >  602 insertions(+)
> > > >  create mode 100644 drivers/pwm/pwm-samsung.c
> > > >
> > > >Changes since v2:
> > > >  - Replaced __raw_{readl,writel} with {readl,writel}.
> > > >  - Corrected commit message.
> > >=20
> > > [...]
> > >=20
> > > >+	of_property_for_each_u32(np, "samsung,pwm-outputs", prop, cur,=20
> val)
> > > >{
> > > >+		if (val>=3D SAMSUNG_PWM_NUM) {
> > > >+			pr_warning("%s: invalid channel index in=20
> samsung,pwm-outputs
> > > >property\n",>=20
> > > Just note, checkpatch complains following, so fixed to use pr_warn()
> > > when I applied.
> >=20
> > Note that you can't apply patches that touch the PWM tree without my Ack
> > and I already mentioned that the current way this driver is written
> > isn't acceptable.
> >=20
> > So either you fix it properly, or if everybody except me thinks we don't
> > need a proper design for drivers anymore, then the only way I'll accept
> > this driver into the PWM tree is if you put a really big comment at the
> > top of the file saying that the driver is badly designed on purpose and
> > that people shouldn't be using it as a reference.
>=20
> Sorry, I don't understand what problem you have with this design. It=20
> completely meets all the requirements applicable on hardware platforms it=
=20
> is (and going to be) used on.

My main problem with it is that there is no design. And as such it sets
a bad example. If I accept this into the PWM tree as is then what am I
supposed to tell the next person that comes up with a similarly broken
driver?

> The only thing it would do in a suboptimal way would be synchronization o=
f=20
> register accesses for multiple instances of the driver - one spinlock=20
> would be used for all of them. This is insignificant because there is no=
=20
> time critical code in this driver and it is really unlikely that a SoC=20
> with multiple instances of this IP block shows up.

I've had people give me guarantees that this and that would *never*
happen only to change their minds 6 months down the road. And again,
even if it was actually true in this case, it isn't a valid excuse for
setting a bad example.

> Channel reservation between clocksource and PWM drivers is completely=20
> correct, relying on the fact that the former can only use channels=20
> _without_ outputs and the latter can only use channels _with_ outputs. Do=
=20
> I have to add that there can't be a channel both with and without output?

The issue is that you can't really ensure that both the clocksource and
PWM drivers use the same variant and therefore might be using different
masks.

> So the only place for improvement here, without starting overengineering=
=20
> things, is a comment about the purpose of the spinlock and why it can be=
=20
> used in our case.

I disagree. You actually even had a version with a halfway decent design
at some point and it was discarded. I don't think I'm asking for all
that much here. I even gave you the option of admitting that the driver
was suboptimal. All I request in return is that you mention that in the
code so that either somebody else might go and clean things up or at
least that nobody will copy from a bad example.

Thierry

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRyKhmAAoJEN0jrNd/PrOhB0sQALnvPfTuZrfkrFzDpol0cOhP
bU0eg4y9pifi7wb66wN1fVcLZZrrQ5KsO1LoqwYlFs/Z74jE8XRISexQrJNNO8Dh
1wfFRUEbIIjX0jNntyfJbF1eQ/aWBbR3Oo7RkqMXPiqR+O1jKr7rbwVXG1/CVjOO
+WgsKHxhZp1SEbRf5C5ya9Yo7YKUjFL5fI7OMia8pJjuphkvkqlMiMHh3xOfC+5Z
0aKvdUgdgwohkatIMgdYZaYT3a5F0SmghP9sxjrox4mrzc8uyBxrfXhxyS+WV9Nn
2e5NVlKYf7vhqA6NinpEggSh/JAPgYdLrQA6KOjr1ZYjlhkNmfSa/dVhbRkO3IDl
jUiC4OEuCvdGU/mFv+/4Rbs+KuOxOBFJW/wWDef6BmN620vpLEctLKqjCFnoLYa1
ndeh4TTepGGTIBBKDrek6rDC4y8SF6ccI0FdH8Qs6+8i9XdYqS13u/AIwAyYIqL1
dqb4pAN4ZmX8uQBUq3tm0wl8/xKxM+qlvHUncvlqK9UpFuGPOipo3ySzxeUNseXX
tezycwN26cJU5faOFG9O3RGlnt1CbcjUqoKX5KdVXiEVnm4kpRTSt95zXUcam8U4
5MfY6TL+ADTbPrqqJkFvfpt76kflDC74BvkiZa/KwbyAqkVfg/ZBQ+9gbhK7QI2e
S9OWmainif+EFjd13exc
=Y+E3
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
