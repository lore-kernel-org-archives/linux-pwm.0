From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/2] pwm: kconfig: enable kona pwm to be built for cygnus
 arch
Date: Fri, 9 Nov 2018 11:53:12 +0100
Message-ID: <20181109105312.lzeue3toefszv6sh@pengutronix.de>
References: <20181107093613.26734-1-peron.clem@gmail.com>
 <20181107161247.sesu2comhes2d4kx@pengutronix.de>
 <dbd99d36-4ff2-8e14-cc54-0896459fdb0e@broadcom.com>
 <CAJiuCccuFKaht93QPvT+taaT8g7CHGS9uP9Ekr0VWASp+ZGZmA@mail.gmail.com>
 <20181108122246.GB1340@ulmo>
 <CAJiuCcc07mTfqk1UOKqkSuJGOR-2AN18EJZ7qcvzkKoTGeUhaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJiuCcc07mTfqk1UOKqkSuJGOR-2AN18EJZ7qcvzkKoTGeUhaA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Scott Branden <scott.branden@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Fri, Nov 09, 2018 at 10:58:41AM +0100, Clément Péron wrote:
> Hi Thierry,
> 
> On Thu, 8 Nov 2018 at 13:22, Thierry Reding <thierry.reding@gmail.com> wrote:
> >
> > On Thu, Nov 08, 2018 at 11:47:53AM +0100, Clément Péron wrote:
> > > Hi Uwe, Scott,
> > >
> > > On Wed, 7 Nov 2018 at 17:48, Scott Branden <scott.branden@broadcom.com> wrote:
> > > >
> > > >
> > > > On 2018-11-07 8:12 a.m., Uwe Kleine-König wrote:
> > > > > On Wed, Nov 07, 2018 at 10:36:12AM +0100, Clément Péron wrote:
> > > > >> The Cygnus architecture use a Kona PWM. This is already present
> > > > >> in the device tree but can't be built actually. Hence, allow the
> > > > >> Kona PWM to be built for Cygnus arch.
> > > > >>
> > > > >> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> > > > >> ---
> > > > >>   drivers/pwm/Kconfig | 3 ++-
> > > > >>   1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >>
> > > > >> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > > >> index 763ee50ea57d..76d56fc8b1b7 100644
> > > > >> --- a/drivers/pwm/Kconfig
> > > > >> +++ b/drivers/pwm/Kconfig
> > > > >> @@ -88,7 +88,8 @@ config PWM_BCM_IPROC
> > > > >>
> > > > >>   config PWM_BCM_KONA
> > > > >>      tristate "Kona PWM support"
> > > > >> -    depends on ARCH_BCM_MOBILE
> > > > >> +    depends on ARCH_BCM_MOBILE || ARCH_BCM_CYGNUS
> > > > >> +    default ARCH_BCM_CYGNUS
> > > > > Is it possible to build this driver also on other arches? Then you might
> > > > > want to consider
> > > > >
> > > > >       depends on ARCH_BCM_MOBILE || ARCH_BCM_CYGNUS || COMPILE_TEST
> > > > good idea to add the COMPILE_TEST just to increase compile coverage
> > >
> > > Will Do.
> >
> > This is known to potentially break builds on things like UM where we
> > have !HAS_IOMEM. Please make sure you thoroughly build-test before you
> > switch on COMPILE_TEST.
> 
> Thanks for the point, so something like this (but maybe it's too
> protective no ?) :
> 
> config PWM_BCM_KONA
>         tristate "Kona PWM support"
>         depends on ARCH_BCM_MOBILE || ARCH_BCM_CYGNUS || COMPILE_TEST
>         depends on COMMON_CLK && HAS_IOMEM && OF

Instead of COMMON_CLK HAVE_CLK should be good enough. Just for compile
testing the default implementations provided in include/linux/clk.h
should even be good enough in the !HAVE_CLK case.

Also OF might not be necessary, at least the driver compiles fine on
amd64 without OF.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
