Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9F4C07E9D
	for <linux-pwm@archiver.kernel.org>; Sat, 24 Sep 2022 10:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiIXKes (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Sat, 24 Sep 2022 06:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiIXKeq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 24 Sep 2022 06:34:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2041C18363;
        Sat, 24 Sep 2022 03:34:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A9F4B80185;
        Sat, 24 Sep 2022 10:34:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D15C433D6;
        Sat, 24 Sep 2022 10:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664015680;
        bh=oisNXHG20hbajKiTp7wbgvOV+P1rIP3yuHleqV2SUGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IK0TEg1YwTI9ms7ZKiFlbOQt4D3uUDAMwVdNi1bg7uy/dJrbZ352sBasUwNI0IFKG
         lz6x25YPz+qDvnWUvU4kefzAPuucREiEKHKlsPtZu4xpDQ9CLZXFWBbqk3hH3yjyqf
         VRxP1wX0y61CjfSbBG0DQO6zhEP3snF1nWWzODVMvKGCoPWzN/SD4vthrSw+odq4Y0
         xL796yT+neUWPb37yHs/Ox1QLCq2jT/MHqlD7eVVC1lDQkY7kCYHdvXWeH9W5TpmQa
         sdwALYh3pjcCv5iVO1OXtLYmOARTOh86VD2+95zDQ+oFDmnaH+KR7pPKxVFXQFxOPs
         bjMdd4t6Xu70Q==
Received: by pali.im (Postfix)
        id 0D45F8A2; Sat, 24 Sep 2022 12:34:37 +0200 (CEST)
Date:   Sat, 24 Sep 2022 12:34:37 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Cc:     linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] gpio: mvebu: Fix check for pwm support on non-A8K
 platforms
Message-ID: <20220924103437.ww4urmq6cnhzj373@pali>
References: <20220714115515.5748-1-pali@kernel.org>
 <20220714183328.4137-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220714183328.4137-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

PING?

On Thursday 14 July 2022 20:33:25 Pali Rohár wrote:
> pwm support incompatible with Armada 80x0/70x0 API is not only in
> Armada 370, but also in Armada XP, 38x and 39x. So basically every non-A8K
> platform. Fix check for pwm support appropriately.
> 
> Fixes: 85b7d8abfec7 ("gpio: mvebu: add pwm support for Armada 8K/7K")
> Signed-off-by: Pali Rohár <pali@kernel.org>
> 
> ---
> Changes in v2:
> * reverse the if/else order per Baruch request
> ---
>  drivers/gpio/gpio-mvebu.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index 2db19cd640a4..de1e7a1a76f2 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -793,8 +793,12 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
>  	u32 offset;
>  	u32 set;
>  
> -	if (of_device_is_compatible(mvchip->chip.of_node,
> -				    "marvell,armada-370-gpio")) {
> +	if (mvchip->soc_variant == MVEBU_GPIO_SOC_VARIANT_A8K) {
> +		int ret = of_property_read_u32(dev->of_node,
> +					       "marvell,pwm-offset", &offset);
> +		if (ret < 0)
> +			return 0;
> +	} else {
>  		/*
>  		 * There are only two sets of PWM configuration registers for
>  		 * all the GPIO lines on those SoCs which this driver reserves
> @@ -804,13 +808,6 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
>  		if (!platform_get_resource_byname(pdev, IORESOURCE_MEM, "pwm"))
>  			return 0;
>  		offset = 0;
> -	} else if (mvchip->soc_variant == MVEBU_GPIO_SOC_VARIANT_A8K) {
> -		int ret = of_property_read_u32(dev->of_node,
> -					       "marvell,pwm-offset", &offset);
> -		if (ret < 0)
> -			return 0;
> -	} else {
> -		return 0;
>  	}
>  
>  	if (IS_ERR(mvchip->clk))
> -- 
> 2.20.1
> 
