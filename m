From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: mxs: set pwm_chip can_sleep flag
Date: Tue, 8 Apr 2014 19:59:04 +0200
Message-ID: <20140408175904.GT29751@pengutronix.de>
References: <1396956597-26159-1-git-send-email-shawn.guo@freescale.com>
 <5343FDD3.3070308@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34487 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932665AbaDHR7I (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Apr 2014 13:59:08 -0400
Content-Disposition: inline
In-Reply-To: <5343FDD3.3070308@i2se.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Shawn Guo <shawn.guo@freescale.com>, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Hello,

On Tue, Apr 08, 2014 at 03:46:59PM +0200, Stefan Wahren wrote:
> Am 08.04.2014 13:29, schrieb Shawn Guo:
> > The .config() calls clk_get_rate() which might sleep, so we need to=
 set
> > pwm_chip can_sleep flag.  Otherwise, we see the following warning w=
hen
> > using pwm driven heartbeat led.
> >
> > WARNING: CPU: 0 PID: 0 at kernel/locking/mutex.c:856 mutex_trylock+=
0x184/0x1a4()
> > DEBUG_LOCKS_WARN_ON(in_interrupt())
> > Modules linked in:
> > CPU: 0 PID: 0 Comm: swapper Not tainted 3.14.0-rc5 #18
> > [<c0015420>] (unwind_backtrace) from [<c0012cb0>] (show_stack+0x10/=
0x14)
> > [<c0012cb0>] (show_stack) from [<c001daf8>] (warn_slowpath_common+0=
x6c/0x8c)
> > [<c001daf8>] (warn_slowpath_common) from [<c001dbac>] (warn_slowpat=
h_fmt+0x30/0x40)
> > [<c001dbac>] (warn_slowpath_fmt) from [<c045df74>] (mutex_trylock+0=
x184/0x1a4)
> > [<c045df74>] (mutex_trylock) from [<c0360950>] (clk_prepare_lock+0x=
c/0xec)
> > [<c0360950>] (clk_prepare_lock) from [<c0362020>] (clk_get_rate+0xc=
/0x68)
> > [<c0362020>] (clk_get_rate) from [<c028d07c>] (mxs_pwm_config+0x20/=
0x198)
> > [<c028d07c>] (mxs_pwm_config) from [<c028bde8>] (pwm_config+0x60/0x=
70)
> > [<c028bde8>] (pwm_config) from [<c034b61c>] (__led_pwm_set+0x1c/0x3=
c)
> > [<c034b61c>] (__led_pwm_set) from [<c034bc3c>] (led_heartbeat_funct=
ion+0x70/0x110)
> > [<c034bc3c>] (led_heartbeat_function) from [<c00292f0>] (call_timer=
_fn+0x7c/0x164)
> > [<c00292f0>] (call_timer_fn) from [<c00295c8>] (run_timer_softirq+0=
x1f0/0x260)
> > [<c00295c8>] (run_timer_softirq) from [<c002255c>] (__do_softirq+0x=
c4/0x2f0)
> > [<c002255c>] (__do_softirq) from [<c0022890>] (irq_exit+0xa4/0x10c)
> > [<c0022890>] (irq_exit) from [<c0010240>] (handle_IRQ+0x34/0x84)
> > [<c0010240>] (handle_IRQ) from [<c0013524>] (__irq_svc+0x44/0x54)
> > [<c0013524>] (__irq_svc) from [<c00107f8>] (arch_cpu_idle+0x40/0x48=
)
> > [<c00107f8>] (arch_cpu_idle) from [<c005deb8>] (cpu_startup_entry+0=
x70/0x198)
> > [<c005deb8>] (cpu_startup_entry) from [<c060aac8>] (start_kernel+0x=
2a8/0x2f8)
> >
> > Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > ---
> >  drivers/pwm/pwm-mxs.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
> > index 9475bc7..4f1bb4e 100644
> > --- a/drivers/pwm/pwm-mxs.c
> > +++ b/drivers/pwm/pwm-mxs.c
> > @@ -147,6 +147,7 @@ static int mxs_pwm_probe(struct platform_device=
 *pdev)
> >  	mxs->chip.dev =3D &pdev->dev;
> >  	mxs->chip.ops =3D &mxs_pwm_ops;
> >  	mxs->chip.base =3D -1;
> > +	mxs->chip.can_sleep =3D true;
> >  	ret =3D of_property_read_u32(np, "fsl,pwm-number", &mxs->chip.npw=
m);
> >  	if (ret < 0) {
> >  		dev_err(&pdev->dev, "failed to get pwm number: %d\n", ret);
>=20
> thanks for the patch. I've tested it with our i.MX28 board and the
> warning above never came. So it works.
> Unfortunately the led still don't behave as expected. If i set the le=
d
> trigger to heartbeat the led goes on and stays in this state.
>=20
> May be this has something to do with the following discussion
>=20
> http://comments.gmane.org/gmane.linux.leds/208
I guess that's your problem, yes. Does patch 2 of my series (i.e.
http://thread.gmane.org/gmane.linux.ports.arm.kernel/282593/focus=3D282=
596)
help you?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
