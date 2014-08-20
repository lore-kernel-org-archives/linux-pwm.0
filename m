From: Boris BREZILLON <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH 1/3] ARM: at91/tclib: prefer using of devm_* functions
Date: Wed, 20 Aug 2014 10:19:46 +0200
Message-ID: <20140820101946.3c894130@bbrezillon>
References: <1408486072-19268-1-git-send-email-gael.portay@gmail.com>
	<1408486072-19268-2-git-send-email-gael.portay@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408486072-19268-2-git-send-email-gael.portay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?R2HDq2w=?= PORTAY <gael.portay@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
List-Id: linux-pwm@vger.kernel.org

On Wed, 20 Aug 2014 00:07:50 +0200
Ga=C3=ABl PORTAY <gael.portay@gmail.com> wrote:

> Signed-off-by: Ga=C3=ABl PORTAY <gael.portay@gmail.com>

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
>  drivers/misc/atmel_tclib.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/misc/atmel_tclib.c b/drivers/misc/atmel_tclib.c
> index c8d8e38..b514a2d 100644
> --- a/drivers/misc/atmel_tclib.c
> +++ b/drivers/misc/atmel_tclib.c
> @@ -150,17 +150,15 @@ static int __init tc_probe(struct platform_devi=
ce *pdev)
>  	if (irq < 0)
>  		return -EINVAL;
> =20
> -	tc =3D kzalloc(sizeof(struct atmel_tc), GFP_KERNEL);
> +	tc =3D devm_kzalloc(&pdev->dev, sizeof(struct atmel_tc), GFP_KERNEL=
);
>  	if (!tc)
>  		return -ENOMEM;
> =20
>  	tc->pdev =3D pdev;
> =20
> -	clk =3D clk_get(&pdev->dev, "t0_clk");
> -	if (IS_ERR(clk)) {
> -		kfree(tc);
> -		return -EINVAL;
> -	}
> +	clk =3D devm_clk_get(&pdev->dev, "t0_clk");
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> =20
>  	/* Now take SoC information if available */
>  	if (pdev->dev.of_node) {
> @@ -171,10 +169,10 @@ static int __init tc_probe(struct platform_devi=
ce *pdev)
>  	}
> =20
>  	tc->clk[0] =3D clk;
> -	tc->clk[1] =3D clk_get(&pdev->dev, "t1_clk");
> +	tc->clk[1] =3D devm_clk_get(&pdev->dev, "t1_clk");
>  	if (IS_ERR(tc->clk[1]))
>  		tc->clk[1] =3D clk;
> -	tc->clk[2] =3D clk_get(&pdev->dev, "t2_clk");
> +	tc->clk[2] =3D devm_clk_get(&pdev->dev, "t2_clk");
>  	if (IS_ERR(tc->clk[2]))
>  		tc->clk[2] =3D clk;
> =20



--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
