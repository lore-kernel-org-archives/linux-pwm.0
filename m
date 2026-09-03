Received: from smtp.smtpout.orange.fr (smtp-72.smtpout.orange.fr [80.12.242.72])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8570C440A2F;
	Thu,  3 Sep 2026 20:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788467915; cv=none; b=lPuMj2LSjsKraLyejE2j4XGC3oI/M3HDXIrSDPYCuu/Dey5OToF0oY15VVfRfdEgjjsOxj713SJtZFuFpuXQuJMzm7kK9fypr0raleSQecesvD6/KJ2xIrJf+Zf7v6tzbfI407C+eGCojjSliJTnPMBeLUT5DYuhm7B25vyc9M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788467915; c=relaxed/simple;
	bh=vG5ci2nWAgHZLCU6AvFsKiZ0VEOvWRRG6EEH5qQFh54=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iKF8lJuzkBtnSdJNLGNBa8aYs1n/2nZzqJUy9Nrp/8qFi26EXD62akNa9HjT6wTw/PWWfTNEGpGGBW5emgZOpAnBIgC1mP6WRdylY0ZhAEGT8bkMTBvigyBrq9tdJKkCGXoB/aA4xV0rDZp8PmRT0AXce/L2X3eHVS7+czU99Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=TJDYEztg; arc=none smtp.client-ip=80.12.242.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="TJDYEztg"
Received: from [IPV6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e] ([10.65.86.62])
	by smtp.orange.fr with ESMTP
	id 2EBKxwjlI2cNb2EBKxrkjd; Thu, 03 Sep 2026 22:37:10 +0200
Received: from [IPV6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e]
 ([IPv6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e])
	by smtp.orange.fr with ESMTPSA
	id 2EB8xKXgh2arj2EB8xJSGR; Thu, 03 Sep 2026 22:37:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1788467822;
	bh=CwaKpZhY+U1YQ2Z3sLZB+CgUEjk+uqaSTrCtONQLkzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=TJDYEztgMBZr5D+XpbvrUmYthbWh3TsgoaTswh87ZevYrHpSZk7puA/GvTLiGfzRp
	 WLPJJ158Kq2q9AgfFG3m1CXjpTdi5kHg/M1zk7I1Ja6j6QfOGMet5wwl1YzvQbNSq3
	 p7/uQLH1BAgihqSP+0g0KRN/JxTTOZu4S5YfAj0dMuXa576wIR9ILVg4oE3LhjkZhB
	 xwiqdZYgRcgGG4RTDdT4buFeCs18f1OI7xtvU3pRFBWtiefvmIkzlWkeSvE2KXO3qR
	 HTO/cKEio50iZEA7RgC4r87APvZHUW32JC+MCMQmVAcQh4xawDKumgLdL4XBks9EIA
	 aMVAcnfgAZ9Tw==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 03 Sep 2026 22:37:02 +0200
X-ME-IP: 2a01:cb10:785:b00:26fb:aefb:6cd2:db0e
Message-ID: <46772551-207f-4795-89d5-6c02a0b85410@wanadoo.fr>
Date: Thu, 3 Sep 2026 22:36:57 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] pwm: rp1: Add RP1 PWM controller driver
To: Andrea della Porta <andrea.porta@suse.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Naushir Patuck <naush@raspberrypi.com>,
 Stanimir Varbanov <svarbanov@suse.de>, mbrugger@suse.com,
 Sean Young <sean@mess.org>, Julian Braha <julianbraha@gmail.com>
References: <cover.1784539788.git.andrea.porta@suse.com>
 <a83d65b2d91865eb722337c547c94dce175e6086.1784539788.git.andrea.porta@suse.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <a83d65b2d91865eb722337c547c94dce175e6086.1784539788.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 20/07/2026 à 11:44, Andrea della Porta a écrit :
> From: Naushir Patuck <naush@raspberrypi.com>
> 
> The Raspberry Pi RP1 southbridge features an embedded PWM
> controller with 4 output channels, alongside an RPM interface
> to read the fan speed on the Raspberry Pi 5.
> 
> Add the supporting driver.
> 
> Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> Co-developed-by: Stanimir Varbanov <svarbanov@suse.de>
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>

Hi,

...

> +static int rp1_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	unsigned long clk_rate;
> +	struct pwm_chip *chip;
> +	void __iomem	*base;
> +	struct rp1_pwm *rp1;
> +	int ret;
> +
> +	chip = devm_pwmchip_alloc(dev, RP1_PWM_NUM_PWMS, sizeof(*rp1));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +
> +	rp1 = pwmchip_get_drvdata(chip);
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	rp1->regmap = devm_regmap_init_mmio(dev, base, &rp1_pwm_regmap_config);
> +	if (IS_ERR(rp1->regmap))
> +		return dev_err_probe(dev, PTR_ERR(rp1->regmap), "Cannot initialize regmap\n");
> +
> +	rp1->clk = devm_clk_get(dev, NULL);

Could it be devm_clk_get_enabled() to simplify the error handling path 
as done above with other devm function?
...

> +	if (IS_ERR(rp1->clk))
> +		return dev_err_probe(dev, PTR_ERR(rp1->clk), "Clock not found\n");
> +
> +	ret = clk_prepare_enable(rp1->clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable clock\n");

... this also saves these 3 lines.

> +	rp1->clk_enabled = true;
> +
> +	ret = devm_clk_rate_exclusive_get(dev, rp1->clk);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to get exclusive rate\n");
> +		goto err_disable_clk;
> +	}
> +
> +	clk_rate = clk_get_rate(rp1->clk);
> +	if (!clk_rate) {
> +		ret = dev_err_probe(dev, -EINVAL, "Failed to get clock rate\n");
> +		goto err_disable_clk;
> +	}
> +	/*
> +	 * To prevent u64 overflow in period calculations:
> +	 * mul_u64_u64_div_u64(period_ns, clk_rate, NSEC_PER_SEC)
> +	 * If clk_rate > 1 GHz, the result can overflow.
> +	 */
> +	if (clk_rate > HZ_PER_GHZ) {
> +		ret = dev_err_probe(dev, -EINVAL, "Clock rate > 1 GHz is not supported\n");
> +		goto err_disable_clk;
> +	}
> +	rp1->clk_rate = clk_rate;
> +
> +	chip->ops = &rp1_pwm_ops;
> +	chip->atomic = true;
> +
> +	platform_set_drvdata(pdev, chip);
> +
> +	ret = pwmchip_add(chip);

Could it be devm_pwmchip_add() to simplify the error handling path as 
done above with other devm function?

> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to register PWM chip\n");
> +		goto err_disable_clk;
> +	}
> +
> +	ret = of_syscon_register_regmap(np, rp1->regmap);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to register syscon\n");
> +		goto err_remove_chip;
> +	}
> +
> +	return 0;
> +
> +err_remove_chip:
> +	pwmchip_remove(chip);
> +err_disable_clk:
> +	clk_disable_unprepare(rp1->clk);
> +
> +	return ret;
> +}
...

CJ
