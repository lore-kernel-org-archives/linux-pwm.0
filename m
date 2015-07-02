From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [RFC PATCH 12/15] pwm: rockchip: add initial state retrieval
Date: Thu, 2 Jul 2015 09:46:50 +0200
Message-ID: <20150702094650.2f934b22@bbrezillon>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
	<1435738921-25027-13-git-send-email-boris.brezillon@free-electrons.com>
	<3258341.kaLi8uDfLr@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <3258341.kaLi8uDfLr@diego>
Sender: linux-leds-owner@vger.kernel.org
To: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>, linux-fbdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bryan Wu <cooloney@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Doug Anderson <dianders@google.com>, Mark Brown <broonie@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Jingoo Han <jingoohan1@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Wed, 01 Jul 2015 23:44:46 +0200
Heiko St=C3=BCbner <heiko@sntech.de> wrote:

> Hi Boris,
>=20
> Am Mittwoch, 1. Juli 2015, 10:21:58 schrieb Boris Brezillon:
> > Implement the ->init_state() function to expose initial state.
> >=20
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
>=20
> [...]
>=20
> > @@ -98,6 +110,36 @@ static void rockchip_pwm_set_enable_v2(struct p=
wm_chip
> > *chip, writel_relaxed(val, pc->base + pc->data->regs.ctrl);
> >  }
> >=20
> > +static void rockchip_pwm_init_state(struct pwm_chip *chip,
> > +				    struct pwm_device *pwm)
> > +{
> > +	struct rockchip_pwm_chip *pc =3D to_rockchip_pwm_chip(chip);
> > +	unsigned long clk_rate;
> > +	u64 tmp;
> > +	int ret;
> > +
> > +	ret =3D clk_enable(pc->clk);
> > +	if (ret)
> > +		return;
> > +
> > +	clk_rate =3D clk_get_rate(pc->clk);
> > +
> > +	tmp =3D readl(pc->base + pc->data->regs.period);
> > +	tmp *=3D pc->data->prescaler * NSEC_PER_SEC;
> > +	tmp =3D do_div(tmp, clk_rate);
>=20
> I guess you want to have the division result here and not the remaind=
er, so
> -       tmp =3D do_div(tmp, clk_rate);
> +       do_div(tmp, clk_rate);
>=20

Oh crap. I make the same mistake over and over again.

[...]
> >  static const struct rockchip_pwm_data pwm_data_v2 =3D {
> > @@ -207,6 +252,7 @@ static const struct rockchip_pwm_data pwm_data_=
v2 =3D {
> >  	.prescaler =3D 1,
> >  	.ops =3D &rockchip_pwm_ops_v2,
> >  	.set_enable =3D rockchip_pwm_set_enable_v2,
> > +	.init =3D rockchip_pwm_init_v2,
>=20
> you're referencing the v2 init here, but only add it in the next patc=
h?
> [pwm: rockchip: add support for atomic update]

Yep, this function should be added in this patch.

Thanks,

Boris


--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
