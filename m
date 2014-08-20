From: Boris BREZILLON <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH 2/3] ARM: at91/tclib: move initialization from alloc to
 probe
Date: Wed, 20 Aug 2014 10:16:35 +0200
Message-ID: <20140820101635.3a61d090@bbrezillon>
References: <1408486072-19268-1-git-send-email-gael.portay@gmail.com>
	<1408486072-19268-3-git-send-email-gael.portay@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:35754 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751656AbaHTIQi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 20 Aug 2014 04:16:38 -0400
In-Reply-To: <1408486072-19268-3-git-send-email-gael.portay@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?UTF-8?B?R2HDq2w=?= PORTAY <gael.portay@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Hi Gael,

On Wed, 20 Aug 2014 00:07:51 +0200
Ga=C3=ABl PORTAY <gael.portay@gmail.com> wrote:

> Move resource retrieval from atmel_tc_alloc to tc_probe to avoid late=
ly
> reporting resource related issues when a TC block user request a TC b=
lock.
>=20
> Moreover, resources retrieval are usually done in the probe function,
> thus moving them add some consistency with other drivers.
>=20
> Initialization is done once, ie not every time a tc block is requeste=
d.
> If it fails, the device is not appended to the list of tc blocks.
>=20
> Furhermore, the device id is retrieved at probe as well, avoiding par=
sing
> DT every time the user requests of tc block.
>=20
> Signed-off-by: Ga=C3=ABl PORTAY <gael.portay@gmail.com>

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
>  drivers/clocksource/tcb_clksrc.c |  2 +-
>  drivers/misc/atmel_tclib.c       | 71 +++++++++++++-----------------=
----------
>  drivers/pwm/pwm-atmel-tcb.c      |  2 +-
>  include/linux/atmel_tc.h         |  8 +++--
>  4 files changed, 29 insertions(+), 54 deletions(-)
>=20
> diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/t=
cb_clksrc.c
> index a8d7ea1..f922e81 100644
> --- a/drivers/clocksource/tcb_clksrc.c
> +++ b/drivers/clocksource/tcb_clksrc.c
> @@ -279,7 +279,7 @@ static int __init tcb_clksrc_init(void)
>  	int i;
>  	int ret;
> =20
> -	tc =3D atmel_tc_alloc(CONFIG_ATMEL_TCB_CLKSRC_BLOCK, clksrc.name);
> +	tc =3D atmel_tc_alloc(CONFIG_ATMEL_TCB_CLKSRC_BLOCK);
>  	if (!tc) {
>  		pr_debug("can't alloc TC for clocksource\n");
>  		return -ENODEV;
> diff --git a/drivers/misc/atmel_tclib.c b/drivers/misc/atmel_tclib.c
> index b514a2d..d505d1e 100644
> --- a/drivers/misc/atmel_tclib.c
> +++ b/drivers/misc/atmel_tclib.c
> @@ -35,60 +35,31 @@ static LIST_HEAD(tc_list);
>  /**
>   * atmel_tc_alloc - allocate a specified TC block
>   * @block: which block to allocate
> - * @name: name to be associated with the iomem resource
>   *
>   * Caller allocates a block.  If it is available, a pointer to a
>   * pre-initialized struct atmel_tc is returned. The caller can acces=
s
>   * the registers directly through the "regs" field.
>   */
> -struct atmel_tc *atmel_tc_alloc(unsigned block, const char *name)
> +struct atmel_tc *atmel_tc_alloc(unsigned block)
>  {
>  	struct atmel_tc		*tc;
>  	struct platform_device	*pdev =3D NULL;
> -	struct resource		*r;
> -	size_t			size;
> =20
>  	spin_lock(&tc_list_lock);
>  	list_for_each_entry(tc, &tc_list, node) {
> -		if (tc->pdev->dev.of_node) {
> -			if (of_alias_get_id(tc->pdev->dev.of_node, "tcb")
> -					=3D=3D block) {
> -				pdev =3D tc->pdev;
> -				break;
> -			}
> -		} else if (tc->pdev->id =3D=3D block) {
> +		if (tc->allocated)
> +			continue;
> +
> +		if ((tc->pdev->dev.of_node && tc->id =3D=3D block) ||
> +		    (tc->pdev->id =3D=3D block)) {
>  			pdev =3D tc->pdev;
> +			tc->allocated =3D true;
>  			break;
>  		}
>  	}
> -
> -	if (!pdev || tc->iomem)
> -		goto fail;
> -
> -	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!r)
> -		goto fail;
> -
> -	size =3D resource_size(r);
> -	r =3D request_mem_region(r->start, size, name);
> -	if (!r)
> -		goto fail;
> -
> -	tc->regs =3D ioremap(r->start, size);
> -	if (!tc->regs)
> -		goto fail_ioremap;
> -
> -	tc->iomem =3D r;
> -
> -out:
>  	spin_unlock(&tc_list_lock);
> -	return tc;
> =20
> -fail_ioremap:
> -	release_mem_region(r->start, size);
> -fail:
> -	tc =3D NULL;
> -	goto out;
> +	return pdev ? tc : NULL;
>  }
>  EXPORT_SYMBOL_GPL(atmel_tc_alloc);
> =20
> @@ -96,19 +67,14 @@ EXPORT_SYMBOL_GPL(atmel_tc_alloc);
>   * atmel_tc_free - release a specified TC block
>   * @tc: Timer/counter block that was returned by atmel_tc_alloc()
>   *
> - * This reverses the effect of atmel_tc_alloc(), unmapping the I/O
> - * registers, invalidating the resource returned by that routine and
> - * making the TC available to other drivers.
> + * This reverses the effect of atmel_tc_alloc(), invalidating the re=
source
> + * returned by that routine and making the TC available to other dri=
vers.
>   */
>  void atmel_tc_free(struct atmel_tc *tc)
>  {
>  	spin_lock(&tc_list_lock);
> -	if (tc->regs) {
> -		iounmap(tc->regs);
> -		release_mem_region(tc->iomem->start, resource_size(tc->iomem));
> -		tc->regs =3D NULL;
> -		tc->iomem =3D NULL;
> -	}
> +	if (tc->allocated)
> +		tc->allocated =3D false;
>  	spin_unlock(&tc_list_lock);
>  }
>  EXPORT_SYMBOL_GPL(atmel_tc_free);
> @@ -142,9 +108,7 @@ static int __init tc_probe(struct platform_device=
 *pdev)
>  	struct atmel_tc *tc;
>  	struct clk	*clk;
>  	int		irq;
> -
> -	if (!platform_get_resource(pdev, IORESOURCE_MEM, 0))
> -		return -EINVAL;
> +	struct resource	*r;
> =20
>  	irq =3D platform_get_irq(pdev, 0);
>  	if (irq < 0)
> @@ -160,12 +124,21 @@ static int __init tc_probe(struct platform_devi=
ce *pdev)
>  	if (IS_ERR(clk))
>  		return PTR_ERR(clk);
> =20
> +	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	tc->regs =3D devm_ioremap_resource(&pdev->dev, r);
> +	if (IS_ERR(tc->regs))
> +		return PTR_ERR(tc->regs);
> +
>  	/* Now take SoC information if available */
>  	if (pdev->dev.of_node) {
>  		const struct of_device_id *match;
>  		match =3D of_match_node(atmel_tcb_dt_ids, pdev->dev.of_node);
>  		if (match)
>  			tc->tcb_config =3D match->data;
> +
> +		tc->id =3D of_alias_get_id(tc->pdev->dev.of_node, "tcb");
> +	} else {
> +		tc->id =3D pdev->id;
>  	}
> =20
>  	tc->clk[0] =3D clk;
> diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.=
c
> index f3dcd02..d56e5b7 100644
> --- a/drivers/pwm/pwm-atmel-tcb.c
> +++ b/drivers/pwm/pwm-atmel-tcb.c
> @@ -379,7 +379,7 @@ static int atmel_tcb_pwm_probe(struct platform_de=
vice *pdev)
>  		return err;
>  	}
> =20
> -	tc =3D atmel_tc_alloc(tcblock, "tcb-pwm");
> +	tc =3D atmel_tc_alloc(tcblock);
>  	if (tc =3D=3D NULL) {
>  		dev_err(&pdev->dev, "failed to allocate Timer Counter Block\n");
>  		return -ENOMEM;
> diff --git a/include/linux/atmel_tc.h b/include/linux/atmel_tc.h
> index 89a931b..d8aa884 100644
> --- a/include/linux/atmel_tc.h
> +++ b/include/linux/atmel_tc.h
> @@ -44,12 +44,13 @@ struct atmel_tcb_config {
>  /**
>   * struct atmel_tc - information about a Timer/Counter Block
>   * @pdev: physical device
> - * @iomem: resource associated with the I/O register
>   * @regs: mapping through which the I/O registers can be accessed
> + * @id: block id
>   * @tcb_config: configuration data from SoC
>   * @irq: irq for each of the three channels
>   * @clk: internal clock source for each of the three channels
>   * @node: list node, for tclib internal use
> + * @allocated: if already used, for tclib internal use
>   *
>   * On some platforms, each TC channel has its own clocks and IRQs,
>   * while on others, all TC channels share the same clock and IRQ.
> @@ -61,15 +62,16 @@ struct atmel_tcb_config {
>   */
>  struct atmel_tc {
>  	struct platform_device	*pdev;
> -	struct resource		*iomem;
>  	void __iomem		*regs;
> +	int                     id;
>  	const struct atmel_tcb_config *tcb_config;
>  	int			irq[3];
>  	struct clk		*clk[3];
>  	struct list_head	node;
> +	bool			allocated;
>  };
> =20
> -extern struct atmel_tc *atmel_tc_alloc(unsigned block, const char *n=
ame);
> +extern struct atmel_tc *atmel_tc_alloc(unsigned block);
>  extern void atmel_tc_free(struct atmel_tc *tc);
> =20
>  /* platform-specific ATMEL_TC_TIMER_CLOCKx divisors (0 means 32KiHz)=
 */



--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
