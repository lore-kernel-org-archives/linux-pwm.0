Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 14/15] ARM: SAMSUNG: Remove remaining uses of plat/regs-timer.h header
Date: Thu, 13 Jun 2013 22:38:57 +0200
Message-ID: <2199978.JEbm7Iqajq@flatron>
In-Reply-To: <201306132224.33866.heiko@sntech.de>
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com> <1370467100-10820-15-git-send-email-tomasz.figa@gmail.com> <201306132224.33866.heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
List-ID: <linux-pwm.vger.kernel.org>
To: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, thierry.reding@gmail.com, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>

On Thursday 13 of June 2013 22:24:33 Heiko St=FCbner wrote:
> Am Mittwoch, 5. Juni 2013, 23:18:19 schrieb Tomasz Figa:
> > This patch removes remaining inclusions of plat/regs-timer.h as a
> > preparation to remove the header.
>=20
> hmm, the patch does a bit more than that, as it also removes the savi=
ng
> of the registers from the suspend calls, which is most likely handled=

> by the driver now. But the description should possibly reflect that.

True, although I couldn't test suspend/resume with these patches, becau=
se=20
it was already broken before, at least on s3c64xx and/or mini6410.

As an interesting side note, in case of s3c64xx and s5p64x0, existing c=
ode=20
was not enough to make suspend/resume of the timer work, as it can be s=
een=20
in case of s5pv210, which has it done almost correctly.

Almost, because as far as I know (and I can see in the manual) the TCNT=
O=20
register is read only and there is a separate procedure for loading tim=
er=20
value manually.

Thanks for review.

Best regards,
Tomasz

> > Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> > ---
> >=20
> >  arch/arm/mach-s3c64xx/irq-pm.c  |  2 --
> >  arch/arm/mach-s5p64x0/pm.c      |  3 ---
> >  arch/arm/mach-s5pv210/pm.c      | 10 ----------
> >  arch/arm/plat-samsung/s5p-irq.c |  1 -
> >  4 files changed, 16 deletions(-)
> >=20
> > diff --git a/arch/arm/mach-s3c64xx/irq-pm.c
> > b/arch/arm/mach-s3c64xx/irq-pm.c index 0c7e1d9..c3da1b6 100644
> > --- a/arch/arm/mach-s3c64xx/irq-pm.c
> > +++ b/arch/arm/mach-s3c64xx/irq-pm.c
> > @@ -22,7 +22,6 @@
> >=20
> >  #include <mach/map.h>
> > =20
> >  #include <plat/regs-serial.h>
> >=20
> > -#include <plat/regs-timer.h>
> >=20
> >  #include <mach/regs-gpio.h>
> >  #include <plat/cpu.h>
> >  #include <plat/pm.h>
> >=20
> > @@ -43,7 +42,6 @@ static struct sleep_save irq_save[] =3D {
> >=20
> >  =09SAVE_ITEM(S3C64XX_EINT0FLTCON2),
> >  =09SAVE_ITEM(S3C64XX_EINT0FLTCON3),
> >  =09SAVE_ITEM(S3C64XX_EINT0MASK),
> >=20
> > -=09SAVE_ITEM(S3C64XX_TINT_CSTAT),
> >=20
> >  };
> > =20
> >  static struct irq_grp_save {
> >=20
> > diff --git a/arch/arm/mach-s5p64x0/pm.c b/arch/arm/mach-s5p64x0/pm.=
c
> > index 97c2a08a..861e15c 100644
> > --- a/arch/arm/mach-s5p64x0/pm.c
> > +++ b/arch/arm/mach-s5p64x0/pm.c
> > @@ -18,7 +18,6 @@
> >=20
> >  #include <plat/cpu.h>
> >  #include <plat/pm.h>
> >=20
> > -#include <plat/regs-timer.h>
> >=20
> >  #include <plat/wakeup-mask.h>
> > =20
> >  #include <mach/regs-clock.h>
> >=20
> > @@ -48,8 +47,6 @@ static struct sleep_save s5p64x0_misc_save[] =3D =
{
> >=20
> >  =09SAVE_ITEM(S5P64X0_MEM0CONSLP1),
> >  =09SAVE_ITEM(S5P64X0_MEM0DRVCON),
> >  =09SAVE_ITEM(S5P64X0_MEM1DRVCON),
> >=20
> > -
> > -=09SAVE_ITEM(S3C64XX_TINT_CSTAT),
> >=20
> >  };
> > =20
> >  /* DPLL is present only in S5P6450 */
> >=20
> > diff --git a/arch/arm/mach-s5pv210/pm.c b/arch/arm/mach-s5pv210/pm.=
c
> > index 2b68a67..3cf3f9c 100644
> > --- a/arch/arm/mach-s5pv210/pm.c
> > +++ b/arch/arm/mach-s5pv210/pm.c
> > @@ -21,7 +21,6 @@
> >=20
> >  #include <plat/cpu.h>
> >  #include <plat/pm.h>
> >=20
> > -#include <plat/regs-timer.h>
> >=20
> >  #include <mach/regs-irq.h>
> >  #include <mach/regs-clock.h>
> >=20
> > @@ -77,15 +76,6 @@ static struct sleep_save s5pv210_core_save[] =3D=
 {
> >=20
> >  =09/* Clock ETC */
> >  =09SAVE_ITEM(S5P_CLK_OUT),
> >  =09SAVE_ITEM(S5P_MDNIE_SEL),
> >=20
> > -
> > -=09/* PWM Register */
> > -=09SAVE_ITEM(S3C2410_TCFG0),
> > -=09SAVE_ITEM(S3C2410_TCFG1),
> > -=09SAVE_ITEM(S3C64XX_TINT_CSTAT),
> > -=09SAVE_ITEM(S3C2410_TCON),
> > -=09SAVE_ITEM(S3C2410_TCNTB(0)),
> > -=09SAVE_ITEM(S3C2410_TCMPB(0)),
> > -=09SAVE_ITEM(S3C2410_TCNTO(0)),
> >=20
> >  };
> > =20
> >  static int s5pv210_cpu_suspend(unsigned long arg)
> >=20
> > diff --git a/arch/arm/plat-samsung/s5p-irq.c
> > b/arch/arm/plat-samsung/s5p-irq.c index 6729cb2..ddfaca9 100644
> > --- a/arch/arm/plat-samsung/s5p-irq.c
> > +++ b/arch/arm/plat-samsung/s5p-irq.c
> > @@ -17,7 +17,6 @@
> >=20
> >  #include <mach/irqs.h>
> >  #include <mach/map.h>
> >=20
> > -#include <plat/regs-timer.h>
> >=20
> >  #include <plat/cpu.h>
> > =20
> >  void __init s5p_init_irq(u32 *vic, u32 num_vic)
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-samsung-soc" in the body of a message to
> majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
