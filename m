From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] pwm: mxs: set pwm_chip can_sleep flag
Date: Wed, 9 Apr 2014 01:42:43 +0200
Message-ID: <20140408234243.GB13898@piout.net>
References: <1396956597-26159-1-git-send-email-shawn.guo@freescale.com>
 <5343FDD3.3070308@i2se.com>
 <20140408175904.GT29751@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:56762 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756232AbaDHXmq (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Apr 2014 19:42:46 -0400
Content-Disposition: inline
In-Reply-To: <20140408175904.GT29751@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Shawn Guo <shawn.guo@freescale.com>, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org

Hi,

On 08/04/2014 at 19:59:04 +0200, Uwe Kleine-K=F6nig wrote :
> Hello,
>=20
> On Tue, Apr 08, 2014 at 03:46:59PM +0200, Stefan Wahren wrote:
> > Am 08.04.2014 13:29, schrieb Shawn Guo:
> > > The .config() calls clk_get_rate() which might sleep, so we need =
to set
> > > pwm_chip can_sleep flag.  Otherwise, we see the following warning=
 when
> > > using pwm driven heartbeat led.
> > >
> > > WARNING: CPU: 0 PID: 0 at kernel/locking/mutex.c:856 mutex_tryloc=
k+0x184/0x1a4()
> > > DEBUG_LOCKS_WARN_ON(in_interrupt())
> > > Modules linked in:
> > > CPU: 0 PID: 0 Comm: swapper Not tainted 3.14.0-rc5 #18
> > > [<c0015420>] (unwind_backtrace) from [<c0012cb0>] (show_stack+0x1=
0/0x14)
> > > [<c0012cb0>] (show_stack) from [<c001daf8>] (warn_slowpath_common=
+0x6c/0x8c)
> > > [<c001daf8>] (warn_slowpath_common) from [<c001dbac>] (warn_slowp=
ath_fmt+0x30/0x40)
> > > [<c001dbac>] (warn_slowpath_fmt) from [<c045df74>] (mutex_trylock=
+0x184/0x1a4)
> > > [<c045df74>] (mutex_trylock) from [<c0360950>] (clk_prepare_lock+=
0xc/0xec)
> > > [<c0360950>] (clk_prepare_lock) from [<c0362020>] (clk_get_rate+0=
xc/0x68)
> > > [<c0362020>] (clk_get_rate) from [<c028d07c>] (mxs_pwm_config+0x2=
0/0x198)
> > > [<c028d07c>] (mxs_pwm_config) from [<c028bde8>] (pwm_config+0x60/=
0x70)
> > > [<c028bde8>] (pwm_config) from [<c034b61c>] (__led_pwm_set+0x1c/0=
x3c)
> > > [<c034b61c>] (__led_pwm_set) from [<c034bc3c>] (led_heartbeat_fun=
ction+0x70/0x110)
> > > [<c034bc3c>] (led_heartbeat_function) from [<c00292f0>] (call_tim=
er_fn+0x7c/0x164)
> > > [<c00292f0>] (call_timer_fn) from [<c00295c8>] (run_timer_softirq=
+0x1f0/0x260)
> > > [<c00295c8>] (run_timer_softirq) from [<c002255c>] (__do_softirq+=
0xc4/0x2f0)
> > > [<c002255c>] (__do_softirq) from [<c0022890>] (irq_exit+0xa4/0x10=
c)
> > > [<c0022890>] (irq_exit) from [<c0010240>] (handle_IRQ+0x34/0x84)
> > > [<c0010240>] (handle_IRQ) from [<c0013524>] (__irq_svc+0x44/0x54)
> > > [<c0013524>] (__irq_svc) from [<c00107f8>] (arch_cpu_idle+0x40/0x=
48)
> > > [<c00107f8>] (arch_cpu_idle) from [<c005deb8>] (cpu_startup_entry=
+0x70/0x198)
> > > [<c005deb8>] (cpu_startup_entry) from [<c060aac8>] (start_kernel+=
0x2a8/0x2f8)
> > >
> > > Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
> > > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > > ---
> > >  drivers/pwm/pwm-mxs.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
> > > index 9475bc7..4f1bb4e 100644
> > > --- a/drivers/pwm/pwm-mxs.c
> > > +++ b/drivers/pwm/pwm-mxs.c
> > > @@ -147,6 +147,7 @@ static int mxs_pwm_probe(struct platform_devi=
ce *pdev)
> > >  	mxs->chip.dev =3D &pdev->dev;
> > >  	mxs->chip.ops =3D &mxs_pwm_ops;
> > >  	mxs->chip.base =3D -1;
> > > +	mxs->chip.can_sleep =3D true;
> > >  	ret =3D of_property_read_u32(np, "fsl,pwm-number", &mxs->chip.n=
pwm);
> > >  	if (ret < 0) {
> > >  		dev_err(&pdev->dev, "failed to get pwm number: %d\n", ret);
> >=20
> > thanks for the patch. I've tested it with our i.MX28 board and the
> > warning above never came. So it works.
> > Unfortunately the led still don't behave as expected. If i set the =
led
> > trigger to heartbeat the led goes on and stays in this state.
> >=20
> > May be this has something to do with the following discussion
> >=20
> > http://comments.gmane.org/gmane.linux.leds/208
> I guess that's your problem, yes. Does patch 2 of my series (i.e.
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/282593/focus=3D2=
82596)
> help you?
>=20

While I had exactly the same issue back in september and wrote the exac=
t
same patch that got rejected. I would agree with Thierry here taht we
need to keep the pwm_disable() there as it potentially allows to save
power.

However, it seems to not work quite well with PWMs from Freescale (see
the thread from Russell). Or I would say with PWM with an undefined
state when disabled and I believe we are soon to find more.

We could either:
 - add a flag like can_sleep that would allow driver to know that the
   pwm always has to be enable to get sane results.
 - or introduce functions like prepare/unprepare to be called from prob=
e
   and remove in the leds-pwm driver and that will enable/disable the
channel in pwm-mxs. pwm_enable/pwm_disable not doing anything.

That is waht is coming to mind but it might be too late for me to think
straight.

--=20
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
