From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Subject: Re: [PATCH 1/2] pwm: kconfig: enable kona pwm to be built for cygnus arch
Date: Thu, 8 Nov 2018 11:47:53 +0100
Message-ID: <CAJiuCccuFKaht93QPvT+taaT8g7CHGS9uP9Ekr0VWASp+ZGZmA@mail.gmail.com>
References: <20181107093613.26734-1-peron.clem@gmail.com> <20181107161247.sesu2comhes2d4kx@pengutronix.de>
 <dbd99d36-4ff2-8e14-cc54-0896459fdb0e@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <dbd99d36-4ff2-8e14-cc54-0896459fdb0e@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Scott Branden <scott.branden@broadcom.com>
Cc: u.kleine-koenig@pengutronix.de, Thierry Reding <thierry.reding@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Uwe, Scott,

On Wed, 7 Nov 2018 at 17:48, Scott Branden <scott.branden@broadcom.com> wro=
te:
>
>
> On 2018-11-07 8:12 a.m., Uwe Kleine-K=C3=B6nig wrote:
> > On Wed, Nov 07, 2018 at 10:36:12AM +0100, Cl=C3=A9ment P=C3=A9ron wrote=
:
> >> The Cygnus architecture use a Kona PWM. This is already present
> >> in the device tree but can't be built actually. Hence, allow the
> >> Kona PWM to be built for Cygnus arch.
> >>
> >> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> >> ---
> >>   drivers/pwm/Kconfig | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> >> index 763ee50ea57d..76d56fc8b1b7 100644
> >> --- a/drivers/pwm/Kconfig
> >> +++ b/drivers/pwm/Kconfig
> >> @@ -88,7 +88,8 @@ config PWM_BCM_IPROC
> >>
> >>   config PWM_BCM_KONA
> >>      tristate "Kona PWM support"
> >> -    depends on ARCH_BCM_MOBILE
> >> +    depends on ARCH_BCM_MOBILE || ARCH_BCM_CYGNUS
> >> +    default ARCH_BCM_CYGNUS
> > Is it possible to build this driver also on other arches? Then you migh=
t
> > want to consider
> >
> >       depends on ARCH_BCM_MOBILE || ARCH_BCM_CYGNUS || COMPILE_TEST
> good idea to add the COMPILE_TEST just to increase compile coverage

Will Do.

Thanks,
Clement

> >
> > Best regards
> > Uwe
> >
