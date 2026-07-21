Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CF13403F7;
	Tue, 21 Jul 2026 13:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784639419; cv=none; b=DfZagHviVBO5Y3FnrnEe3fxW6Xtb4bwV+Ywy/xKS6yXlpQPSknO2WRRzAoceEi6CA2H/g1k2k9oq54yMgbwLtg1LP2s1GJG6H9eEeVoBncSHc6gxSDYwehEVWHjXTHdLSOiPB6JJ3M7C9S+V/V/4RwVVajnXP9RJcIy/aXf+vUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784639419; c=relaxed/simple;
	bh=BgeAh41OqiCsVguxtZEAIFYRp1KTccsXSeYMGSINdfA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z2ObwxqCpl50n2507C/4xcjM5es+X5X/0WtaiApdeOK2ycyVkDdoeR8IKgqA9jJf62P2w8DTLNdMcZDrvkswE4Z5J72jsYM88dGUmKykTVQG5n6pCeO7ZO22WikW83W1MkYakTeuAeGUk3CClT2R2SOGVO3Cu8jGZADw4KEjsck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 1644A202994;
	Tue, 21 Jul 2026 15:10:13 +0200 (CEST)
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wmAEe-000Zxz-3C;
	Tue, 21 Jul 2026 15:10:13 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wmAEe-00000000DgW-3fDo;
	Tue, 21 Jul 2026 15:10:12 +0200
Message-ID: <f7b1c5f1594c99e662d0033dc002ff1a46f17107.camel@pengutronix.de>
Subject: Re: [PATCH v12 3/4] pwm: dwc: add of/platform support
From: Philipp Zabel <p.zabel@pengutronix.de>
To: dongxuyang@eswincomputing.com, ukleinek@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, ben-linux@fluff.org, 
	ben.dooks@codethink.co.uk, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 daniel.lezcano@kernel.org, tglx@kernel.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com, 
	xuxiang@eswincomputing.com, wangguosheng@eswincomputing.com, 
	pinkesh.vaghela@einfochips.com
Date: Tue, 21 Jul 2026 15:10:12 +0200
In-Reply-To: <20260721120905.1302-1-dongxuyang@eswincomputing.com>
References: <20260721120757.1134-1-dongxuyang@eswincomputing.com>
	 <20260721120905.1302-1-dongxuyang@eswincomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Di, 2026-07-21 at 20:09 +0800, dongxuyang@eswincomputing.com wrote:
> From: Xuyang Dong <dongxuyang@eswincomputing.com>
>=20
> The dwc pwm controller can be used in non-PCI systems, so allow
> either platform or OF based probing.
>=20
> The controller is reset only when no PWM channel is enabled.
> Otherwise, clocks are enabled and the runtime PM state is updated
> to reflect the active hardware configuration.
>=20
> The DWC PWM controller does not provide a hardware polarity bit.
> Currently, the driver only supports active-low output, which is
> incompatible with devices requiring active-high waveforms (e.g.,
> backlight controllers, fan speed regulators).
>=20
> Implement polarity control by exploiting the timer's dual load
> registers. The hardware uses:
> - LD_CNT:  LOW period count
> - LD_CNT2: HIGH period count
>=20
> The total period is defined as (LD_CNT + LD_CNT2). By swapping the
> duty cycle between these registers, we invert the polarity while
> keeping the period unchanged:
> - PWM_POLARITY_NORMAL:  write duty_cycle to LD_CNT2 (HIGH period)
> - PWM_POLARITY_INVERSED: write duty_cycle to LD_CNT  (LOW period)
>=20
> Implementation:
> Update both apply() and get_state() to handle state->polarity
> consistently. Since the hardware does not store polarity, get_state()
> returns the last successfully applied software state, ensuring that
> read-back matches what was originally set.
>=20
> Co-developed-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Signed-off-by: Xiang Xu <xuxiang@eswincomputing.com>
> Signed-off-by: Guosheng Wang <wangguosheng@eswincomputing.com>
> Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
> ---
>  drivers/pwm/Kconfig        |  10 ++
>  drivers/pwm/Makefile       |   1 +
>  drivers/pwm/pwm-dwc-core.c | 172 ++++++++++++++++----
>  drivers/pwm/pwm-dwc-of.c   | 312 +++++++++++++++++++++++++++++++++++++
>  drivers/pwm/pwm-dwc.h      |  25 ++-
>  5 files changed, 481 insertions(+), 39 deletions(-)
>  create mode 100644 drivers/pwm/pwm-dwc-of.c
>=20
[...]
> diff --git a/drivers/pwm/pwm-dwc-of.c b/drivers/pwm/pwm-dwc-of.c
> new file mode 100644
> index 000000000000..460863549274
> --- /dev/null
> +++ b/drivers/pwm/pwm-dwc-of.c
> @@ -0,0 +1,312 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DesignWare PWM Controller driver OF
> + *
> + * Copyright (C) 2026 SiFive, Inc.
> + */
> +
> +#define DEFAULT_SYMBOL_NAMESPACE "dwc_pwm_of"
> +
> +#include <linux/clk.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pwm.h>
> +#include <linux/reset.h>
> +
> +#include "pwm-dwc.h"
> +
> +struct dwc_pwm_plat_data {
> +	bool reset_required;

This is not needed.

> +};
> +
> +static int dwc_pwm_plat_probe(struct platform_device *pdev)
> +{
[...]
> +	pdata =3D device_get_match_data(dev);
> +	if (pdata && pdata->reset_required)
> +		dwc->rst =3D devm_reset_control_get_exclusive(dev, NULL);
> +	else
> +		dwc->rst =3D devm_reset_control_array_get_optional_exclusive(dev);

Please drop reset_required from pdata and just use

	dwc->rst =3D devm_reset_control_array_get_optional_exclusive(dev);

That works for a single reset as well.

Device tree validation already makes sure required reset controls are
present. There is no need handle this in the driver as a special case.

> +
> +	if (IS_ERR(dwc->rst))
> +		return dev_err_probe(dev, PTR_ERR(dwc->rst),
> +				     "failed to get reset control\n");
> +
> +	ret =3D clk_prepare_enable(dwc->bus_clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to enable bus clock\n");
> +
> +	ret =3D clk_prepare_enable(dwc->clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable timer clock\n");

		dev_err_probe(dev, "failed to enable timer clock\n");

prints the actual error. Same for other dev_err()s in the probe
function.

regards
Philipp
