From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v5 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Date: Thu, 14 Feb 2019 16:59:03 +0100
Message-ID: <20190214155903.7h3b7v3nbhj57uy2@pengutronix.de>
References: <1548762199-7065-1-git-send-email-yash.shah@sifive.com>
 <1548762199-7065-3-git-send-email-yash.shah@sifive.com>
 <20190207101657.rfzcq6xdv6ocvubg@pengutronix.de>
 <20190213123703.GE647@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190213123703.GE647@ulmo>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, palmer@sifive.com, linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>, robh+dt@kernel.org, paul.walmsley@sifive.com, linux-riscv@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Wed, Feb 13, 2019 at 01:37:03PM +0100, Thierry Reding wrote:
> On Thu, Feb 07, 2019 at 11:16:57AM +0100, Uwe Kleine-K=F6nig wrote:
> > On Tue, Jan 29, 2019 at 05:13:19PM +0530, Yash Shah wrote:
> [...]
> > > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> [...]
> > > +	writel(val, pwm->regs + PWM_SIFIVE_PWMCFG);
> > > +
> > > +	writel(frac, pwm->regs + PWM_SIFIVE_PWMCMP0 + dev->hwpwm * SIZE_PWM=
CMP);
> > > +
> > > +	val &=3D ~(1 << PWM_SIFIVE_PWMCFG_DEGLITCH);
> > > +	writel(val, pwm->regs + PWM_SIFIVE_PWMCFG);
> > > +
> > > +	pwm_sifive_get_state(chip, dev, state);
> > =

> > Thierry: This changes the pwm_state. Is this how this should be done?
> =

> Yes, I think that's fine. The PWM state should always reflect the
> current hardware state. If the configuration that we program does not
> reflect the state that was requested, that should be reflected in the
> PWM state.

I'm not sure you blessed what is really done here. If I do:

	state.duty_cycle =3D state.period;
	pwm_apply_state(pwm, &state);

the call in question doesn't only result in pwm->state.duty_cycle <
pwm->state.period, but it also corrects my local state variable (i.e. I
have state.duty_cycle < state.period afterwards).

Is this what you thought to be fine?

Also note that v6 dropped that call because of my doubts.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
