Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534CE4FECD7
	for <linux-pwm@vger.kernel.org>; Mon,  7 Sep 2026 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788794568; cv=none; b=Ij5d45ZiQUjzSURiCrvan3hpc25WkCRuVW5Wzw+VULLtrNZY1XOLRX6twC5In2HEMN3Wv6PmPnTtb28lcvqfGRL7knX4QLXpXtJa6ms1GwxvEVH1SQHzXVd2jb0oCHXh6Z0fRyga3sgNJUY7CI490d9RAjc9ExQQyHH7zgzY4xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788794568; c=relaxed/simple;
	bh=jmfCKOrsEAkeGu4GxNdLlIPtSWNSStX+SxoQ8W3mBP0=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=BnK842MO+b3QlY8+tBc12/EByM9Tczn0sPUcjff3FHLyeyKbLot7NyrFmWuMP7Bh8c3dDCGMs95dUdTgO65uRarmRELrfDfcI/MbhSsLcJE9QYQeEits8Goxn1MsEOwMGAMyXNMqu5J1OvF4M1xS5fhc+ciQ2dR4IkK85smwsD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Zyr6KoKX; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Zyr6KoKX"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49b8eeb3ff2so34639275e9.2
        for <linux-pwm@vger.kernel.org>; Mon, 07 Sep 2026 08:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788794564; x=1789399364; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=X5xsM2PpkE3MzX+tsKcHsoYtIZRtT3xChs4/YMhT9N0=;
        b=Zyr6KoKX5ns6XsCuWwRXFOJKSZPUFP6fwJXE+ITi7WYbpdwS3OyZb69/QQDCJCv45y
         HE0VinUJs/LVdoloKO/xinKV0fVZrXAKeGKw/DNEUzvrmQgqETkg+BjEC5dWyLPC/LrL
         YJO82YnwdUMpfvmLW27beD/qceIQ3hVXZUD7QxEIcB+C9Dz615RbpUzjbKydkyaxmbZd
         5NF+ooQNYF+3y+UTuiGP0HDhcktm0qQpBLY8//QqJgz/5gte3NLrncqGKTdQp2kou4fC
         LkO3KuXeNxjYjxu4WD1G/O3LHpA0wIWSUEhQkyLIaCogfVyawL5ToZpd0o4OrFqdeBur
         oh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788794564; x=1789399364;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X5xsM2PpkE3MzX+tsKcHsoYtIZRtT3xChs4/YMhT9N0=;
        b=aX0/UJ0eofvfg7Hv6XyhWKHWMW7CGXvIODQXGy3y5GOPKisDXEz7vDIL1h4QNoKmQi
         u8mXG/+PnhWdQ+QNxDlQiVLcRxcgRQeUzT5W0T4wkMRLaZBnqDy6yjxi4DqT1YQtYBNR
         XYg5LJCIn3TMKWcFO6gGu8rEh1GM++fkXR7vJHwx31QBCcujvRUp1N2Ze/9CVsl8YRwF
         Ch3VJssSPy4v78zUl3h6YhWkwwalXFHXxqDfQ3sU48Uccq4j6qyOykf/X5xkN8VB/0Lx
         MLDN5UhVXrs3FMHeYGXzVK9blLXPcFdEXd1+zBjjGx45C6OPLi5e2kTcZHuqz8DUzAlq
         p6zw==
X-Forwarded-Encrypted: i=1; AKwUvBzpe0/kjVXrbh4sNysS8nnWeo+954ETks5SSNAGjRIHd6h+fIhIhx/tC8yX5GG3GW47p2fvbzCyiKY=@vger.kernel.org
X-Gm-Message-State: AFuF++lFshrS/Rkzuw7Rm+RfUh15qs6y95AeJ+I9X/rvM6H4Zthz84/s
	ozaW/oPUa0ua1/KkhDSWQv0JVmMMB0pBoQg/R0uDUejHNs6Gp7eRnYZqHCQT0voDO0g=
X-Gm-Gg: AYBFou2Z3G9PqDy5dWMSUkrGojb6QqJTtqMTvVJJrz527ykv5eFE0zrhV0ZjlKGUrvf
	Bw5MxAuX/XH6gbZYpytfaBXDMYDeuaqSFvaEbQLjwc/g6XLUO/yzeKwECgRYCXl0yLazMuMparc
	b7COw4MknmdXgZceqHgry8q7D+IRMyoiJz14OCP1HF5Do2ZO5jwc6UXKjubUVCyy5C+AlvLCGgW
	snt/ZTr4/9Xi1GvXNmg09AAqxL1oC9o4E7cI9eACqYikNpb8Uxe9DS9xyxLvqvU6VD6+97s/WdX
	eteaAMWBQEm5BHd/fk/UQEXBNBv7vdnMaqJZmA9MwPefHgZvQrrFas5MIlLOsrt+rOolYmIuXPp
	Vz87QTQ26ahR/TFDh7brUTLNzvSVLM7uOKJQtINc7lzTm0qbIPPlDEeP2L+NKOMX113BvZmEEM2
	cEpa3E8XMTDyM+twhNszEz7DU50cTASraCN2WHiCa+ibA0UuWIFi6/H5AM/JtF3j4qedUFj3g78
	TaiP5LSHKPkHv+aputrBx/cccoMhqW0
X-Received: by 2002:a05:600c:3b99:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49cf81fb72amr250088355e9.1.1788794564491;
        Mon, 07 Sep 2026 08:22:44 -0700 (PDT)
Received: from [192.168.7.218] (82-230-44-19.subs.proxad.net. [82.230.44.19])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49cfbdacc45sm288319375e9.11.2026.09.07.08.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:22:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 3/4] pwm: meson: use bulk API for per-channel clocks
From: Alexandre Mergnat <amergnat@baylibre.com>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org
In-Reply-To: <20260827-s6-s7-pwm-v4-3-d28a2015177d@amlogic.com>
References: <20260827-s6-s7-pwm-v4-0-d28a2015177d@amlogic.com>
 <20260827-s6-s7-pwm-v4-3-d28a2015177d@amlogic.com>
Date: Mon, 07 Sep 2026 17:22:44 +0200
Message-Id: <178879456435.2256446.2005394820666057840.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2432; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=jmfCKOrsEAkeGu4GxNdLlIPtSWNSStX+SxoQ8W3mBP0=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBqntbFBsgbKyAhkkOJh84p2SvPyoyzSRQxstw9D
 3A9Z/x836eJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCap7WxQAKCRArRkmdfjHU
 RemCD/9wGgVpKIFJRn8V0zICx86yvsAf6Pfmw2+t+HFAw/vPmcYJU+bEl+gXhNs+6LadQTaWZgP
 Vf5un+G+NE2CloSjsUmEkSlIUP2vxAhKXYup9NC3Lq399aqtzRnP5BqTrJp2rQQ/JeX5s0fDCna
 4EdhFl0ZMgzvr32vurCm44ZywSUGEWiKuGh6t5/0ApKOt0hubBGyc5h8jB5cxAumR9ovgGQ8xUy
 a0dKoglN5NWtk5FQNyrkDOKGIGoPTv7FBx7/ejivTWfRVvmA3EszeGZZ0SGykbdPVj0a9B5vnQE
 agxxO7E1xb7Uxlc9y7Dfgspf3eNU+8j8vIitR0BGPubc+0g1M/X1nwiBLcGCdnqcG83PZgnTuhg
 lxf9rLZcSQTDlxb7016YbagASF6TYHqdoRpHvg5olFqs+3+Xi4Qzd6Y768geLSEsb0J15Xg6+9o
 ytO7ADXO155fq9rdpIZBvIDekDlvfTGW91Naur8Qb3jAAq7NHTVvAkRkUeMRPgz7R6egwCGaGoS
 NX0uBEDW1vmlya4cdM5iMGhR1Jq5javGzdX5N1mF5gxmCiFjpkCMYLG6h6KedB0wg9SRRtm+p03
 VKjXhlKgR9SKCbnjfFZFUUOlugy5dbqSGld55eFhblnv4GNTPndXjvQ49fK9A64ZuhFLSAsdBVt
 9XRe2nETnLlSo1Q==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

> The S4 PWM driver currently gets each channel clock individually with
> of_clk_get() and uses a custom cleanup action to release the clocks.
> 
> Use devm_clk_bulk_get_all() instead to retrieve all per-channel clocks
> at once. Verify that the number of clocks matches the number of PWM
> channels and assign each clock to its corresponding channel.
> 
> This also allows the per-channel clock initialization code to be shared
> by Meson PWM variants using one clock per channel.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 22cefc6d5dd0..6f151464d7cc 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -497,33 +497,25 @@ static int meson_pwm_init_channels_meson8b_v2(struct pwm_chip *chip)
>  	return meson_pwm_init_clocks_meson8b(chip, mux_parent_data);
>  }
>  
> -static void meson_pwm_s4_put_clk(void *data)
> -{
> -	struct clk *clk = data;
> -
> -	clk_put(clk);
> -}
> -
> -static int meson_pwm_init_channels_s4(struct pwm_chip *chip)
> +static int meson_pwm_init_channels_per_channel_clk(struct pwm_chip *chip)
>  {
>  	struct device *dev = pwmchip_parent(chip);
> -	struct device_node *np = dev->of_node;
>  	struct meson_pwm *meson = to_meson_pwm(chip);
> -	int i, ret;
> +	struct clk_bulk_data *clks;
> +	unsigned int i;
> +	int num;
>  
> -	for (i = 0; i < chip->npwm; i++) {
> -		meson->channels[i].clk = of_clk_get(np, i);
> -		if (IS_ERR(meson->channels[i].clk))
> -			return dev_err_probe(dev,
> -					     PTR_ERR(meson->channels[i].clk),
> -					     "Failed to get clk\n");
> -
> -		ret = devm_add_action_or_reset(dev, meson_pwm_s4_put_clk,
> -					       meson->channels[i].clk);
> -		if (ret)
> -			return dev_err_probe(dev, ret,
> -					     "Failed to add clk_put action\n");
> -	}
> +	num = devm_clk_bulk_get_all(dev, &clks);
> +	if (num < 0)
> +		return dev_err_probe(dev, num, "Failed to get clocks\n");
> +
> +	if (num != chip->npwm)
> +		return dev_err_probe(dev, -EINVAL,
> +				"expected %u clocks, got %d\n",

Small style nit: the continuation arguments are not aligned with the open
parenthesis, whereas the dev_err_probe() just above and the rest of the driver
do align them. Can you fix it please ?

After that,
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Alexandre Mergnat <amergnat@baylibre.com>
