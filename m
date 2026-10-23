Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792752045;
	b=TyuLdWTdpWFJU2D7YTxnEBk5zFpgilVnus38BgTDpEg2gChjqSYWksyAwJD/u82rEPv+
	 dH/rxzFeZ/J4qQl4NOsnUxhCLhAmCiJtBidgyalbAnv61jym/Pg4ejYJIXAwufwrhI6Uc
	 Gm6Ntz/T63Akh+64fjgPsTEZ0wn2GHr4KU+83H3jpwc+Ewdk47opoNFvp6I60Sp8M4XW2
	 XiCHJcgoh6Ld+SdJhiYDxs4ZnKVJMkhMabF53wAyHRdCfdQlYmFWomKiwp/LwntZZ3nBP
	 eo/4Fyl1TEmPMKTqQelH/OMJehiCvsFaeLP7etri7sFh0a4tSJoMnANwLiBusR47QXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792752045;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=PU3pthY8C33I9auXpGTnmiUI6trGGQ/gwWp/L1g0V2U=;
	b=HtIG3ufCR6WNEBDAj0AfNhlJJTDYjQSR4aUtcs8zPRd7DxWFHcm23mxbYpCxWtEzS96s
	 Z0oPxVpKgE14qrIxEsuiNrcg4Zy7VD4P6VX9N43Aieza8BPS4YIvJwN8+PfAdEyPlhXqX
	 Eom5Xp/63G4YQSnkweVlzV6/RmlcwxYakNEq2C+zF+xp2jOoVa0WcLUZ0Oin0+VK69JOc
	 C8eEkbXtKxUduqh87zca0kkXiHFhbjLOPdbEhVBVZJ/8QjLN4EDMGIlppIArr4g8uGyE+
	 NHzCxtDfGeSP1wzYU83UqoevaHU7gFqSzbdTf3YEdnsQJoyvCNK4dkHJg/PfzXcNb4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qDHUhalw;
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7A1606A323
	for <linux-pwm@vger.kernel.org>; Fri, 23 Oct 2026 10:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA7A1606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qDHUhalw
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5eac319a6c2so784979e0c.0
        for <linux-pwm@vger.kernel.org>; Fri, 23 Oct 2026 03:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792752044; x=1793356844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PU3pthY8C33I9auXpGTnmiUI6trGGQ/gwWp/L1g0V2U=;
        b=qDHUhalwvENGkYicXhp/819z0Cb38eGLFlBd2GcJ+kd+woA2F1L8l9kYdTAygGzV41
         jjsjJKPrcmEv5ryCEEnITghJ9icCuEe79uAC2TIerrCYohBBHBLTZiMIiSOnL7RgoXOc
         q6Gpso+ZmXyHzx5yBUnX/tlI6/9r0A95XfDV3X7yX3MMwNrPcA9L+Z8BuguX0OIOAqlt
         JHwbigQt7F23Hncc/dEgAZqZdYcICFBMwluD4DA7c4nwdtfDwE9g22DxGn7k0FaCEkPY
         uTBI9O6EHgKlpntPbaAxkPlFVAJrawT3KfULj/F4BGcIPiZqEfUbhbaRfaayJgz0OljI
         ukyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792752044; x=1793356844;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PU3pthY8C33I9auXpGTnmiUI6trGGQ/gwWp/L1g0V2U=;
        b=pKzk3QP/SY3WdIec0SAT2cZQuVleIKDCnD8CLLdsYXzshi5jhVzoHx4IAhj3eWCb7v
         0Xe/qGQ+yE5Latc0EUXE/rtckCcAQub0a1IX2Xrlc8+RN+1BotAfZdOzqYYECnj8td/4
         mWdICwB7n32OWh6e6j7wM2S/P7NMbzhCLpCcdVoETotMBjtKVTd0RQVpTE7kv4HY5sOY
         QB7R5mddmreGd0t1yeXedBHD9VEG9B0ljHIhTdMmj1vK4EIpnpFXSbaNmpvyPDB644XW
         rvjKVeW4eTVGwqzdeKRV+OdfGeJHGrLldF9Gg8l1TPdR7FnVG30fLZlKzzfEeUiUKqyb
         btLQ==
X-Forwarded-Encrypted: i=1; AKwUvBy/pmkzAebz7mygzq0JakXKJdiVVvq7tarKuP162TPUCTLOHFmS31BK13GSgbCMBDd4fmcRfhaaqaQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJiWcem+zkzYu423SKZ38V2ORYK95P2OFCpXYnwRsl3uqQuHQ8i
	1YgoaHGDyNl69214LOwcJ/w/DCostqeQ3d2tJQ6ywSgdBRdX/XQlfcxK
X-Gm-Gg: AYBFou2Belvpy8HZGAAPJT0SVrrM4v1eiCV/pu2aGoeGl3sEqq4u0VbMbqQcyuheqM/
	H7HNSaO6EOEn4oQUHjYWaYcvn89U0QprtK7pU4djft8UuYsVXRPf3L/vUf8YPY2iFB0rcT0CLJv
	RXuyjzq+hsp4jftsP8kZHLV5suVyvcTJr+X2VE2vjQ5Dy67dHCjThOr0XfzeYXFaD0NqwptmdVp
	ODYtcyh2GVNwPljhU/JOv+gxVi1Mc6POd2Dsxou2WQ2p/DpOF+fv1OD9JfmBVYmvs9hLYVqzl4B
	uGpSVeWLFAMN4YJfkjhFCaXAU7FTjVdZkcqYXzv9O0SR2MRtXx/eQEIazNoXtX05gTYKQW1CowP
	1xLqaEjha2Ut67WmrNVO5MdE75cQjYgusMraQEIYjR4alP/oSN+PZkzDNsIeh/O7i/XSP0qrlnf
	ufBORTENyDt5rZDHmtUNtTaNYc/jxE+iQtJZ5NCGUcpMnLX/+rvGtF72fp/ptCfhcrw/hnmNDnq
	sLkb9wrUgdSmA4N9Uu6msmRxeVpZ/J+iUj78lEY7fJKTcKv8+UsZWyCJ/zAf61nt68OmgLH4EcJ
	cVGFIywXLEH7NOt0qQHOvpbB2UaM4txq0it4lcw75bAIDoUEKKs=
X-Received: by 2002:a05:6102:41a1:b0:7cb:bda3:27ab with SMTP id ada2fe7eead31-7ccc32eac6amr858728137.13.1792752043685;
        Fri, 23 Oct 2026 03:40:43 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (158.95.44.30.netskope-rdns.com. [158.95.44.30])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec13deaba5sm1974736e0c.1.2026.10.23.03.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 03:40:42 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Fri, 23 Oct 2026 07:40:32 -0300
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@analog.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-doc@vger.kernel.org, Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 07/10] iio: frequency: ad9910: support drctl control
Message-ID: <pg7pcjaaxuu6vmi4qowgaefyo3mynrvmiu6iazzormyvc5kiat@4hiqrtwbw2gg>
References: <20261022-ad9910-backend-support-v2-0-0ff7f0bff326@analog.com>
 <20261022-ad9910-backend-support-v2-7-0ff7f0bff326@analog.com>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022-ad9910-backend-support-v2-7-0ff7f0bff326@analog.com>

On 22/10/26 12:19, Rodrigo Alencar wrote:
> The DRCTL pin controls the slope direction of the AD9910 digital ramp
> generator (DRG). When dwell is enabled at a ramp limit, the DRG holds
> that limit until the next DRCTL transition, so the sweep pattern is
> defined by the waveform applied to that pin, which can be generated by
> a PWM.
> 
> Get the optional "drctl" PWM and expose the integration_time attribute
> in the DRG ramp up and ramp down channels, which sets the time interval
> assigned to each ramp direction while the sweep parameter is accumulating.

...

> +	st->drctl_pwm = devm_pwm_get(dev, "drctl");
> +	if (IS_ERR(st->drctl_pwm)) {
> +		ret = PTR_ERR(st->drctl_pwm);
> +		if (ret != -ENOENT && ret != -ENODEV)

Sashiko points out the problem with passing a non-nul con_id to devm_pwm_get(),
which would get us EINVAL or ENODATA from of_property_match_string(), and that
would break the intent here for an optional pwm. Similar to what we tried to
achieve with an optional IIO backend. I wonder what is the best strategy here
(ascending order of complexity):

* Use con_id = NULL as DRCTL is the only pwm signal being considered at this point.
* Local workaround by checking for EINVAL and ENODATA too
* Convert error codes from of_property_match_string() in of_pwm_get()
  implementation and create a devm_pwm_get_optional(), which would only check
  for ENODEV and ENOENT.

The pwm is optional as the digital ramp generator is one of the possible modes
to be used.

> +			return dev_err_probe(dev, PTR_ERR(st->drctl_pwm),
> +					     "failed to get drctl pwm\n");
> +		st->drctl_pwm = NULL;
> +	} else {
> +		ret = devm_add_action_or_reset(dev, ad9910_drctl_disable_action,
> +					       st->drctl_pwm);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "failed to add drctl disable action\n");
> +	}

-- 
Kind regards,

Rodrigo Alencar
