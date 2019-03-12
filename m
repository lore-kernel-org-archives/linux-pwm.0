From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/2] pwm: ensure pwm_apply_state() doesn't modify the
 state argument
Date: Tue, 12 Mar 2019 13:59:51 +0100
Message-ID: <20190312125951.2oo6q2gwavxd77ko@pengutronix.de>
References: <20190312083537.23748-1-u.kleine-koenig@pengutronix.de>
 <20190312083537.23748-3-u.kleine-koenig@pengutronix.de>
 <20190312114247.GJ31026@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190312114247.GJ31026@ulmo>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Mar 12, 2019 at 12:42:47PM +0100, Thierry Reding wrote:
> On Tue, Mar 12, 2019 at 09:35:37AM +0100, Uwe Kleine-K=F6nig wrote:
> [...]
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 470d4f71e7eb..52dace9f739e 100644
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> [...]
> > @@ -193,17 +193,11 @@ static int sun4i_pwm_calculate(struct sun4i_pwm_c=
hip *sun4i_pwm,
> >  	*dty =3D div;
> >  	*prsclr =3D prescaler;
> >  =

> > -	div =3D (u64)pval * NSEC_PER_SEC * *prd;
> > -	state->period =3D DIV_ROUND_CLOSEST_ULL(div, clk_rate);
> > -
> > -	div =3D (u64)pval * NSEC_PER_SEC * *dty;
> > -	state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(div, clk_rate);
> > -
> =

> Perhaps split this out into a separate patch like you did for Rockchip?

Ah right, I also forgot this driver when writing my cover lever, so
there are actually two drivers that gave feedback.

Will respin later today.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
