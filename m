From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v4 1/2] pwm: mtk_disp: fix pwm clocks not poweroff when
 disable pwm
Date: Mon, 20 Jan 2020 15:31:34 +0100
Message-ID: <20200120143134.yqojufklnack27xf@pengutronix.de>
References: <20191217040237.28238-1-jitao.shi@mediatek.com>
 <20191217040237.28238-2-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43413 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgATObg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jan 2020 09:31:36 -0500
Content-Disposition: inline
In-Reply-To: <20191217040237.28238-2-jitao.shi@mediatek.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jitao Shi <jitao.shi@mediatek.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, CK Hu <ck.hu@mediatek.com>, linux-mediatek@lists.infradead.org, sj.huang@mediatek.com

Hello,

I fully agree to what Thierry said about the commit log.

One more comment:

On Tue, Dec 17, 2019 at 12:02:36PM +0800, Jitao Shi wrote:
> @@ -194,14 +194,6 @@ static int mtk_disp_pwm_probe(struct platform_device *pdev)
>  	if (IS_ERR(mdp->clk_mm))
>  		return PTR_ERR(mdp->clk_mm);
>  
> -	ret = clk_prepare(mdp->clk_main);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret = clk_prepare(mdp->clk_mm);
> -	if (ret < 0)
> -		goto disable_clk_main;
> -
>  	mdp->chip.dev = &pdev->dev;
>  	mdp->chip.ops = &mtk_disp_pwm_ops;
>  	mdp->chip.base = -1;

After this there is:

	if (!mdp->data->has_commit) {
		mtk_disp_pwm_update_bits(mdp, mdp->data->bls_debug, ...);
		...
	}

So I wonder if dropping the clk_enables above is safe if there are some
register accesses later on.

Side note: The driver you're touching here is still using the legacy
API. Would be great to convert it to .apply() instead.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
