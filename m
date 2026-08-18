Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AE74746AF
	for <linux-pwm@vger.kernel.org>; Tue, 18 Aug 2026 12:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787057636; cv=none; b=U1hZ1KDtwkSnROdVgAhMN+zi/Uf6c2ATXSNiH2DxGG3EB8e9un3nEggmyo1NW1jnY08F0JFBkI43dqrt/XYsRVgFug9prcAGF+yxjzgxvAjCaYgpKoiVAoD2ov56OTdaSjPw08S7gcign0+nNme4LoUsdDRbjGtMZdFNJSRuSL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787057636; c=relaxed/simple;
	bh=EL3KK8jlLJGv/DFviAz1KFPEh1vXG+ZrypDU0NDk9Lg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=XicKHy2hRhMogSQCgOmvqE2eJd2N3w8Cr3et1rVFIzNIeke+2OmP+49WcQaUIf0GXWeHp3fEFmA7tFNzdxOrGHwks3fSCyfZD8sFN/6buttIc2hkWgQ9T3X5vK8tAxJHXVp2aUFcdKWaGvsxbWVLsw4tcB9I2Hl9ULRjPEbnvew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=o6OWqhPH; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="o6OWqhPH"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47f7027ca11so2815108f8f.3
        for <linux-pwm@vger.kernel.org>; Tue, 18 Aug 2026 05:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787057629; x=1787662429; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xrJlFSriS8B2b9nn703o+fJtCUBgBFvDtgFvMr5LkkY=;
        b=o6OWqhPHyYA7nrbWE6O90n6G6Iyo16zRQDQvfNN43Z8ElEKKHwd1kHBeKb8opmYxqx
         Nh5rFaj3jzU2H8lMRmjw9HoODuQZvv09VzcNV3SZyNHkoMHQcfYsErrIcVaN6IqVS3my
         iR+PHzi1BavcIkpsM4XmFZI/tteu0g3lDtZwNIA8eBNCusnhz/0KzV26BRb75YGZ+3/C
         1jqPUGNewO+iYsYNHQTta02fTfm3UEnsbbznCI/biKdg9qoXB9T/2OTvzFxUKcZVfRFM
         zLsTw1RTZI7RUQj14P4dDqpu+ZdCasR0r1WzxhWtQ8F8rafTzG9AbePcN1vC6X31jNh1
         zqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787057629; x=1787662429;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xrJlFSriS8B2b9nn703o+fJtCUBgBFvDtgFvMr5LkkY=;
        b=Nr1sfgwdwT8dVkwgN3rIuB/PX6wtr5YbN52L8Rxw4n2UvdqZNJLVLeEX0NGN2SfEXz
         dmvjEATpYeVbLZkQ8QU8/jWpCbRzotRsaBc0kFer3YeXWSy5aaVaA+m7AnjrNNw1R2Mt
         /sqvaB1TglRGREmJBwgJMIe+WduSVcFb4qQXRB2lF/em0fQzmmexq8qlv7uVAttcbwTD
         M9xfUdc+jpR4X3IpazWkDq0L5/xKEdlXFCqjldLVt9OoElqNM2zrOlEceEWW/zDczJio
         gL3N+lrx2Ye1oClCjOrbeInAkL4V7eZPBrz+1Obry56uMxREXSq9u7G3UOwVv6ojOfKc
         5HhA==
X-Forwarded-Encrypted: i=1; AHgh+RqYVKxr8+hlW3qqMmuCEsCBxU3BmjNMjAXN0SAe37/JMXvPqJaSOEzwTcGqPR2cmTP30OVO3i2HmGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTfpWWKhj5C5k31/P5TYSh6Gb4JhjRO3mZ9mwxzTi5OTsTeWmK
	aXbtMa5tQnsUZpMuw2G7PypEHCkCJKtyCOkoyaixvSLfjr7yFIFsvRVW2N0xCbmOqrA=
X-Gm-Gg: AR+sD10VGCgRFXWjRRSLvq6JogV0uZne1Il2kR0Fmsi3XAEiNAeF5W77joDJXuT/3/8
	bNg1LhWatULXSI/emz9a1y9T/PCnnki0cDxzUGTZ8qEgI6sHA5DL7jf31TXVsNt5yE6X1AZbLPP
	JsLUMwWLtc1kFVH8CjkCKZgBK9FhLR6RYjornmqDi7prLdFZpLmVbCUNspd7YkQFumtsTRykcON
	rL35a0qbd6W2ouuRVJzvsjkY/gC9O1EqNu6uFoFBZra2A7MEFtsx5bWT3w/ANwRGqiTZE4GBGOf
	8aySLjmr0Gzg4WlVsUAYLUEozqvfCsk1DwdmmT3UE0Wxtic2oAfdn0COLPqss7mcMrLgMP0z/un
	ZSBZUD38x1urDiZFFUlEGw9IN7McLVHRnpfoW4bBdcEb7WErtRk/2iTXijHU1+OEmxBpvL3YwDQ
	7qaOzgnhwzRrfvZavXM0DecnPWfKX0wpzbdnHSE0OHlRzoD2SOigbLXHuvRQp68j5oTk7SLssEX
	jSs9MVG5p0jc2e23xY3EvI=
X-Received: by 2002:a05:600c:4fcb:b0:499:5a50:b022 with SMTP id 5b1f17b1804b1-49987928d0cmr559638885e9.3.1787057628879;
        Tue, 18 Aug 2026 05:53:48 -0700 (PDT)
Received: from [192.168.5.218] (82-230-44-19.subs.proxad.net. [82.230.44.19])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49996183b89sm299651425e9.12.2026.08.18.05.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 05:53:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 2/2] pwm: meson: Add support for Amlogic S7
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
In-Reply-To: <20260521-s6-s7-pwm-v3-2-57b073fbafef@amlogic.com>
References: <20260521-s6-s7-pwm-v3-0-57b073fbafef@amlogic.com>
 <20260521-s6-s7-pwm-v3-2-57b073fbafef@amlogic.com>
Date: Tue, 18 Aug 2026 14:53:50 +0200
Message-Id: <178705763029.1733024.16040030322013834677.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5071; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=EL3KK8jlLJGv/DFviAz1KFPEh1vXG+ZrypDU0NDk9Lg=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBqhFXiSMDykhwqFRJyduNIxl6nWCcthhpZK54QI
 uixLX9cm7CJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCaoRV4gAKCRArRkmdfjHU
 RU6KD/929yysdZ0oy7pCYZQi5pEUo3qc1BezyULQNpqFYVX3DhBL2qRZwSH0duBSBHX6wcYgycX
 l99l9rgeS4epETHlQL/RupF7OQUg4EBRSwqK9OlmGCoeH1riPQn/a26u9eM1ASZv52rXAlnwuhE
 FVkGD1WwaHId+1+m981ZQt4CW1Lhpm7cuZBWa5MFz9CyJDPPFI8enNNgXAkKLMCg/wB1G+SE8fb
 HBNtU1bgs/4eYvrWZXR582cxanrPghjFrKwwW679F7SX5RcoOMyNNH9Joud9V/CGozSYZachWqo
 z7TiauCCUl3QKSWeRifkmXWzlzOub2rG3LWpFk5RrFsPaPOjBO+xzTla0cklgz+dBKl8grJIbzV
 lGhVYlrqrxWBdP4fVlpH7/oNOraWK1gSa9ZqEa5vtaV4n/XNb9m2wHbwsRCb7JKhW3jmHlAlZZq
 c5iNwGJrhfDM9X/oFTaff3iUBGK1Qp00l0BEPF/USBmP8xjLTQWAnXYeUpmifG5ZYyWmmyHdH0G
 01ulg6mfGWildgEWaIOIZ3qpwWFoGzR03uLn467Towkf8KgcIoWSCpMBf9TN96P4imyabxrbEWl
 5DfBXWJ2vu5Z0CPr3HF26gwp2tebeItZSU/x+CONYLwB5GO58NfzvYaL3eY3ZePY7IxNBpEeitM
 4o/65qEn7zxOG9Q==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

On Thu, 21 May 2026 08:26:59 +0000, Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 8c6bf3d49753..66c41bf036de 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -503,6 +504,18 @@ static void meson_pwm_s4_put_clk(void *data)
>  	clk_put(clk);
>  }
>  
> +static int meson_pwm_init_channels_s7(struct pwm_chip *chip)
> +{
> +	struct device *dev = pwmchip_parent(chip);
> +	struct meson_pwm *meson = to_meson_pwm(chip);
> +
> +	meson->channels[0].clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(meson->channels[0].clk))
> +		return dev_err_probe(dev, PTR_ERR(meson->channels[0].clk),
> +				     "Failed to get clk\n");
> +	return 0;
> +}

This adds a fourth channels_init callback, and after the series
pwm_s7_data ends up differing from pwm_s4_data only by .npwm and by this
function. Would it make sense to share a single init between the two
instead?

What blocks reusing meson_pwm_init_channels_s4() as it stands is that it
needs an indexed clock lookup, and there is no devm variant of clk_get()
taking an index, hence the of_clk_get() + devm_add_action_or_reset()
dance. devm_clk_bulk_get_all() (include/linux/clk.h) is however both
devm-managed and index-based, and of_clk_bulk_get_all() is implemented as
clks[i].clk = of_clk_get(np, i) (drivers/clk/clk-bulk.c), so it performs
exactly the lookup the S4 path already does, only with automatic cleanup.
Something along these lines:

 static int meson_pwm_init_channels_per_channel_clk(struct pwm_chip *chip)
 {
      struct device *dev = pwmchip_parent(chip);
      struct meson_pwm *meson = to_meson_pwm(chip);
      struct clk_bulk_data *clks;
      unsigned int i;
      int num;

      num = devm_clk_bulk_get_all(dev, &clks);
      if (num < 0)
              return dev_err_probe(dev, num, "Failed to get clocks\n");

      if (num != chip->npwm)
              return dev_err_probe(dev, -EINVAL,
                                   "expected %u clocks, got %d\n",
                                   chip->npwm, num);

      for (i = 0; i < chip->npwm; i++)
              meson->channels[i].clk = clks[i].clk;

      return 0;
 }

chip->npwm is usable here because devm_pwmchip_alloc() fills it in probe
before channels_init() runs, so one function covers npwm = 2 and npwm = 1
with no variant-specific code, and meson_pwm_s4_put_clk() goes away with
it. A future variant would then only need its .npwm value.

The count check is worth keeping: of_clk_get(np, i) currently fails probe
with a clear message when the DT node has fewer clocks than expected,
while devm_clk_bulk_get_all() would simply return fewer clocks and leave
channels[i].clk NULL. As clk_prepare_enable(NULL) succeeds and
clk_round_rate(NULL, ...) returns 0, the problem would only surface later
in .apply() as a confusing "invalid source clock frequency". The check
just preserves the diagnostic you have today.

There is a similar use of this API, count check included, in
drivers/pmdomain/amlogic/meson-ee-pwrc.c, in case it is useful as a
reference.

Since this touches the existing S4 path, it would probably be easier to
review split up, roughly:

   1. dt-bindings (unchanged, keeps its Reviewed-by tags)
   2. pwm: meson: make the PWM count driver data -- add .npwm, fill the
      existing entries, use it in probe, and switch the loop in
      meson_pwm_init_clocks_meson8b() to chip->npwm. No functional change.
   3. pwm: meson: get per-channel clocks with devm_clk_bulk_get_all() --
      convert and rename meson_pwm_init_channels_s4(), drop
      meson_pwm_s4_put_clk(). No functional change.
   4. pwm: meson: Add support for Amlogic S7 -- reduced to pwm_s7_data
      with .npwm = 1 and the of_device_id entry.

That is clearly more work than what you have, so please do push back if
you think it is not worth it for this series. And if you are keeping a
separate function on purpose because devm_clk_get() is where you would
like the driver to head, that is a perfectly good answer too -- I may
well be missing context here.

> @@ -530,6 +543,7 @@ static int meson_pwm_init_channels_s4(struct pwm_chip *chip)
>  static const struct meson_pwm_data pwm_meson8b_data = {
>  	.parent_names = { "xtal", NULL, "fclk_div4", "fclk_div3" },
>  	.channels_init = meson_pwm_init_channels_meson8b_legacy,
> +	.npwm = MESON_NUM_PWMS,

I suggest use "2" instead of "MESON_NUM_PWMS"

> @@ -642,7 +672,11 @@ static const struct of_device_id meson_pwm_matches[] = {
>  		.compatible = "amlogic,meson-s4-pwm",
>  		.data = &pwm_s4_data
>  	},
> -	{},
> +	{
> +		.compatible = "amlogic,s7-pwm",
> +		.data = &pwm_s7_data
> +	},
> +	{ }

Small nit: changing the sentinel from "{}," to "{ }" is unrelated to
adding S7 support. Patches tend to be easier to review when they carry only
the functional change, so would you mind dropping it, or splitting it into
its own trivial cleanup?

-- 
Alexandre Mergnat <amergnat@baylibre.com>
