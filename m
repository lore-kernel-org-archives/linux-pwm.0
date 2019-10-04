From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 5/6] pwm: mxs: avoid a division in mxs_pwm_apply()
Date: Fri, 4 Oct 2019 16:08:34 +0200
Message-ID: <20191004140834.4idddyohf52ha4ao@pengutronix.de>
References: <20191004133207.6663-1-linux@rasmusvillemoes.dk>
 <20191004133207.6663-6-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20191004133207.6663-6-linux@rasmusvillemoes.dk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Fri, Oct 04, 2019 at 03:32:06PM +0200, Rasmus Villemoes wrote:
> Since the divisor is not a compile-time constant (unless gcc somehow
> decided to unroll the loop PERIOD_CDIV_MAX times), this does a
> somewhat expensive 32/32 division. Replace that with a right shift.
> =

> We still have a 64/32 division just below, but at least in that
> case the divisor is compile-time constant.
> =

> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

> ---
>  drivers/pwm/pwm-mxs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> =

> diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
> index 57562221c439..f2e57fcf8f8b 100644
> --- a/drivers/pwm/pwm-mxs.c
> +++ b/drivers/pwm/pwm-mxs.c
> @@ -33,8 +33,8 @@
>  #define  PERIOD_CDIV(div)	(((div) & 0x7) << 20)
>  #define  PERIOD_CDIV_MAX	8
>  =

> -static const unsigned int cdiv[PERIOD_CDIV_MAX] =3D {
> -	1, 2, 4, 8, 16, 64, 256, 1024
> +static const u8 cdiv_shift[PERIOD_CDIV_MAX] =3D {
> +	0, 1, 2, 3, 4, 6, 8, 10

One small nitpick: I would like to see this name have a mxs_pwm_ prefix.
But even without this change:

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
