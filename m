From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Subject: Re: [PATCH v2] pwm: kconfig: enable kona pwm to be built for cygnus arch
Date: Fri, 23 Nov 2018 10:31:18 +0100
Message-ID: <CAJiuCcdt9Kk3z6gsr68O1JrPfan-ENpRjo0dnBaGxs4xDidOzQ@mail.gmail.com>
References: <20181121123508.25119-1-peron.clem@gmail.com> <20181122200536.ndgrxuxealtovngy@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122200536.ndgrxuxealtovngy@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: u.kleine-koenig@pengutronix.de
Cc: Thierry Reding <thierry.reding@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi,

On Thu, 22 Nov 2018 at 21:05, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Cl=C3=A9ment,
>
> On Wed, Nov 21, 2018 at 01:35:08PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > The Cygnus architecture use a Kona PWM. This is already present
> > in the device tree but can't be built actually. Hence, allow the
> > Kona PWM to be built for Cygnus arch.
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  drivers/pwm/Kconfig | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index 27e5dd47a01f..982f4059f4e8 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -88,7 +88,9 @@ config PWM_BCM_IPROC
> >
> >  config PWM_BCM_KONA
> >       tristate "Kona PWM support"
> > -     depends on ARCH_BCM_MOBILE
> > +     depends on ARCH_BCM_MOBILE || ARCH_BCM_CYGNUS || COMPILE_TEST
> > +     depends on HAVE_CLK && HAS_IOMEM
> > +     default ARCH_BCM_CYGNUS
>
> This looks good. As pointed out before the default is a bit strange
> and could include ARCH_BCM_MOBILE for symmetry.

Ok, let me resend a v3

>
> Anyhow:
>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>
> Related to this driver I have a set of questions: If the disable
> callback completed, does the hardware still drive the pin? If yes, would
> it be possible to disable the pin driver such that the pin gets high-Z?
> If yes, how?

The output pin type is configured with the bit "21:16 PWMOUT_TYPE RW
default 0x3F" in the Control register
PWM_CONTROL_TYPE_SHIFT macro in the driver
Datasheets says : "When set to 1 the PWM Output signal will have a
push/pull type.When set to 0 the PWM Output signal will have an open
drain output type.Recommend to leave it push/pull type."

In the driver we actually set push/pull mode for all channels :
/* Set push/pull for all channels */
for (chan =3D 0; chan < kp->chip.npwm; chan++)
value |=3D (1 << PWM_CONTROL_TYPE_SHIFT(chan));

Regards,
Clement

>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
