Return-Path: <kgene.kim@samsung.com>
From: Kukjin Kim <kgene.kim@samsung.com>
References: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com>
 <201306222001.49600.heiko@sntech.de> <2101400.j50IudOSWr@flatron>
In-reply-to: <2101400.j50IudOSWr@flatron>
Subject: RE: [PATCH v2 00/18] Final Samsung PWM support cleanup
Date: Mon, 24 Jun 2013 09:14:14 +0900
Message-id: <29af01ce706f$c242edd0$46c8c970$%kim@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: quoted-printable
Content-language: ko
List-ID: <linux-pwm.vger.kernel.org>
To: 'Tomasz Figa' <tomasz.figa@gmail.com>, =?ISO-8859-1?Q?'Heiko_St=FCbner'?= <heiko@sntech.de>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, 'Arnd Bergmann' <arnd@arndb.de>, 'Olof Johansson' <olof@lixom.net>, 'Sylwester Nawrocki' <sylvester.nawrocki@gmail.com>, 'Mark Brown' <broonie@kernel.org>, 'Thomas Abraham' <thomas.abraham@linaro.org>, 'Thierry Reding' <thierry.reding@gmail.com>

Tomasz Figa wrote:
>=20
> Hi Heiko,
>=20
> On Saturday 22 of June 2013 20:01:49 Heiko St=FCbner wrote:
> > Am Freitag, 21. Juni 2013, 00:12:45 schrieb Tomasz Figa:
> > > Since we now have a proper Samsung PWM clocksource driver in =
place,
> > > we can proceed with further cleanup of PWM timers support on =
Samsung
> > > SoCs.>
> > > This series attempts to achieve this goal by:
> > >  1) moving remaining Samsung platforms to the new clocksource =
driver
> > >  2) removing old clocksource driver
> > >  3) adding new multiplatform- and DT-aware PWM driver
> > >  4) moving all Samsung platforms to use the new PWM driver
> > >  5) removing old PWM driver
> > >  6) removing all PWM-related code that is not used anymore
> > >
> > > Cleaning up the PWM driver is a bit tricky, because the design of
> > > current driver makes it completely unsuitable for DT and
> > > multiplatform and would require a heavy rework to make it usable,
> > > breaking any existing Samsung PWM users by the way. To avoid any
> > > breakage I decided to keep the old driver, add new one, move all
> > > platforms to it and then remove the old one.
> > >
> > > See particular patches for more detailed descriptions.
> > >
> > > On S3C6410-based Tiny6410 (Mini6410-compatible), after enabling
> > > pwm-beeper and Exynos4210-based Origen board (with PWM0 attached =
to a
> > > scope):
> > >
> > > Tested-by: Tomasz Figa <tomasz.figa@gmail.com>
> >
Thanks.

> > On a s3c2416 based machine (with the additional two v3 patches)
> >
> > Tested-by: Heiko Stuebner <heiko@sntech.de>
> >
Thanks.

> >
> > and again thanks for working on this :-)
>=20
> Thanks for testing!
>=20
> I hope we can get this merged ASAP, as this is an important =
prerequisite
> for further work on S3C24xx and S3C64xx...
>=20
OK, let me take this series into 4th pull-request will be sent to =
arm-soc
tonight in my time. Thanks for your guys' effort.

- Kukjin
