From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v3 2/6] pwm: let pwm_get_state() return the last
 implemented state
Date: Mon, 2 Sep 2019 22:20:27 +0200
Message-ID: <20190902202027.es2vmearjdgzzdpz@pengutronix.de>
References: <20190824153707.13746-1-uwe@kleine-koenig.org>
 <20190824153707.13746-3-uwe@kleine-koenig.org>
 <5802279.ETANMDGNFP@phil>
 <20190902143231.k2ugpv2oemceaequ@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190902143231.k2ugpv2oemceaequ-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Patrick Havelange <patrick.havelange-buIOx9BAs4sybS5Ee8rs3A@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Mon, Sep 02, 2019 at 04:32:31PM +0200, Uwe Kleine-K=F6nig wrote:
> On Fri, Aug 30, 2019 at 07:48:35PM +0200, Heiko Stuebner wrote:
> > Am Samstag, 24. August 2019, 17:37:03 CEST schrieb Uwe Kleine-K=F6nig:
> > > ---
> > >  drivers/pwm/core.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > =

> > > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > > index 72347ca4a647..92333b89bf02 100644
> > > --- a/drivers/pwm/core.c
> > > +++ b/drivers/pwm/core.c
> > > @@ -473,7 +473,14 @@ int pwm_apply_state(struct pwm_device *pwm, stru=
ct pwm_state *state)
> > >  		if (err)
> > >  			return err;
> > >  =

> > > -		pwm->state =3D *state;
> > > +		/*
> > > +		 * .apply might have to round some values in *state, if possible
> > > +		 * read the actually implemented value back.
> > > +		 */
> > > +		if (chip->ops->get_state)
> > > +			chip->ops->get_state(chip, pwm, &pwm->state);
> > > +		else
> > > +			pwm->state =3D *state;
> > =

> > This should probably become
> > >-		pwm->state =3D *state;
> > > +
> > > +		/*
> > > +		 * .apply might have to round some values in *state, if possible
> > > +		 * read the actually implemented value back.
> > > +		 */
> > > +		if (chip->ops->get_state)
> > > +			chip->ops->get_state(chip, pwm, &pwm->state);
> > =

> > so always initialize the state to the provided one and then let the dri=
ver
> > override values?
> =

> This feels wrong. There is another thread that adds a developer knob
> that emits some warnings. Catching this kind of error with it would be a
> good idea IMHO.
> =

> > The inversion case stems from the Rockchip pwm driver (wrongly?) only
> > setting the polarity field when actually inverted, so here the polarity=
 field
> > probably never actually got set at all.
> > =

> > But while we should probably fix the rockchip driver to set polarity al=
l the
> > time, this is still being true for possible future state-fields, which =
also
> > wouldn't get initialzed from all drivers, which might need an adaption
> > first?
> =

> Actually I would prefer that all drivers do it right and rely on this.

FTR: I sent a patch for the rockchip driver to do the right thing here.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
