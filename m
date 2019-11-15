From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v4 4/7] pwm: sun4i: Add support to output source clock
 directly
Date: Fri, 15 Nov 2019 08:35:47 +0100
Message-ID: <20191115073547.iflhs6vqdsmyjla3@pengutronix.de>
References: <20191108084517.21617-1-peron.clem@gmail.com>
 <20191108084517.21617-5-peron.clem@gmail.com>
 <20191113085858.76rad3vpszknu4cp@pengutronix.de>
 <CAJiuCceYg7WC=peHYeC=eE-HOsKH_SdsKyWwkWY5VpeY+uzaKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAJiuCceYg7WC=peHYeC=eE-HOsKH_SdsKyWwkWY5VpeY+uzaKA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>, devicetree <devicetree@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>, linux-kernel <linux-kernel@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>, Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de, Philipp Zabel <pza@pengutronix.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

Hello Cl=E9ment,

On Thu, Nov 14, 2019 at 11:47:00PM +0100, Cl=E9ment P=E9ron wrote:
> On Wed, 13 Nov 2019 at 09:58, Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Fri, Nov 08, 2019 at 09:45:14AM +0100, Cl=E9ment P=E9ron wrote:
> > > From: Jernej Skrabec <jernej.skrabec@siol.net>
> > > +     /*
> > > +      * Although it would make much more sense to check for bypass in
> > > +      * sun4i_pwm_calculate(), value of bypass bit also depends on "=
enabled".
> >
> > I don't understand this reasoning. sun4i_pwm_calculate knows about
> > .enabled and also sun4i_pwm->data->has_direct_mod_clk_output. Maybe just
> > add a bool *bypass as parameter and move the logic there?
> =

> I asked myself the same question, however the sun4i_pwm_calculate is
> only called when period or duty_cycle is updated not when state is
> toggled between disabled / enabled.
> =

> Should we also call it when the state is switched to enabled ?

Given that the check

	if ((cstate.period !=3D state->period) ||
	    (cstate.duty_cycle !=3D state->duty_cycle)) {

is not perfect anyhow (because if I toggle between

	pwm_apply_state(pwm, { .period =3D 50000001, .duty_cycle =3D 25000000, .en=
abled =3D true });

and

	pwm_apply_state(pwm, { .period =3D 50000000, .duty_cycle =3D 25000000, .en=
abled =3D true });

the code recalculates every parameter while it (probably) doesn't make a
difference.) And also given that cstate is filled by pwm_get_state which
might change its semantic slightly in the future I would say calculating
the needed parameter always is also cleaner. (But I'm aware this isn't
objective enough to overrule different opinions.) While I'm a fan of
avoid unneeded calculations, I think having a simple driver is more
important.

(And apart from that I don't like lowlevel drivers calling the pwm API
that is designed for consumers.)

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
