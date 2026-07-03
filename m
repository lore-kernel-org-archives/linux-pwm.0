Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A92222590
	for <linux-pwm@vger.kernel.org>; Fri,  3 Jul 2026 14:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783090401; cv=none; b=h5np9OpyYVwJuGqD6h19jD0MfF3QQRkV1SIXiY0MeQhk4a/pWxJq5nt/VnlYZ9qNAdSObXOkpgPIp8sc93V4JYoK9s3IhAzMBfDScXMAjLfkm8Fmb252iT03lK9aOhVKTDCMCX71hYJW5TaiR8PLcJtLj0quigK5c1vxzz1ERSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783090401; c=relaxed/simple;
	bh=dr4BeQSiZnpR1IwzMb3FXywWpykA6u0hAgioLbsXY/g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giXt80o6eJawARDGHyEkE3cWSBvOkYy9pJalSer5eiTuMbjsNacgM0H1oXVZouJ/XAXOgtUVQMEB9UdWDUV4TKPQ8F1T5EObPpfbzjg2PklDjWqjboMDq8V4hK5hhoSi48wWdE75z8JcFNHmd06KDaPE2NK0nWyI1oA+TpMUFHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I9uEped4; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I9uEped4"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493b77b150aso5317235e9.2
        for <linux-pwm@vger.kernel.org>; Fri, 03 Jul 2026 07:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783090398; x=1783695198; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QB59yWoF1xJrXodhOCNsO8AMkW1gWMSY+FjvASquQ6Q=;
        b=I9uEped4GFKy/QJq6J3kzsqIarOXaMA6P7VdfvzDAsdY57C630g6SbvpY3F4cT4Uha
         Y5DJPK7cjAyGqIgAuO30NpvSmeL+ZEOgoqMmlmLSoza5Z8S5khOktJP/NHT5I+PBFD0F
         VrCZOMZJdHmCyZlOejTueT/xvXcjfyJwmq1FNgmSxlzndMtTuvaSp3NTrBzSKkSdLC8B
         lW7TJgOXKqOSjTfh75PoIAjtU7OAWP3llBfxH9P27Iz9UTL2N4HNGaaiVmby46wZX0k+
         YI186HHOA0qV6tcOpPOJA88Hfk5lCmGaL2qBeW/sCpDFr03QVsr6PdT77lDS7NnHPNya
         0vpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783090398; x=1783695198;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QB59yWoF1xJrXodhOCNsO8AMkW1gWMSY+FjvASquQ6Q=;
        b=ae6I26WxqDSPGQb2QsixVAdQThepaEcTuvtfuSgPwAwF7ECxQhv43lFqClQT8DYUjN
         UGmlDmR6eKWAfCmdBJS4z6b6oczFmyLUy9qrsbLvAJdAACeyh8Z3V0BV8S7JDCr+ZSKJ
         lKyU0+TyGtEAWlWOvq0qiP6Q46h3lYhbQkqcE5Jlp3bCMcdrDxHGrZ/XvsbLZAu5MJbq
         Sn+ihiWzKakodOYiZ5lrVnHDIkaSovSijqjQipU59Bl3+e4lD/1znw7eIjqQJdV6N5N0
         hcwmwd9Zf3ZRdKyhbOfpD+xB0eIuC+ObdcxF9I1UCjwxvgO016O9u7U1YcjB3AVGNGIz
         FpDw==
X-Forwarded-Encrypted: i=1; AFNElJ+03qiaxrrvDeTBMltv/TvDJ3nkfS//gQcA0fvCR63dm5m6ORqMQYAr3wSICm34+vgdLNIjraUF5xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YySvXgAk1pNopHZosynxE9FJbrXGND3JUjA7RpAYXcutT5uh9w+
	U165JE/2sBFkoMeIMFncbYv+gafzkm7E+MRTX987yRSrzf6aRp7zyzqLnXLq9iab5Fc=
X-Gm-Gg: AfdE7ckAbGWQ4OvBwOiSHf5fQe3WXZI0ENCO7eLdGySNqvEWL5rZkRinnVLtYCntS8Q
	bfPrtLG/AQSNaZtW/DSVnWYiKRfLHYIu2GXhqYNE5ataKZxtjLklcYepf4rdr30mao4AqJWZ9h5
	CHqoopR/EEJRaz3H8Ofvw6GY1DqzRSks6IaeK7/x3wv5ydoJeqfCg2EXMOGYhkcKhVEQCMcme0B
	1bLp7C3/qa4re9WeVmTmq5n0yNnH0F3soXNENXJb1x97zJR+Cp1XBfLEokZNAvHjif3NMg3g7OZ
	Kz2xk1Q2hG07ayEz+OxE/nlmmpusQ65tjfCRCUjgsctv+pmH+dXc11JgRsU9YWh7h5QxHuSppqv
	Dc4kkKYNqxJ3K7ZQ5b9Iq0ECZIfGibUSersF5HYio7SDGehZcUQITIpszUKHMR7lbcx+VMWPY7C
	Br/BbpRu4pW5c=
X-Received: by 2002:a05:600c:1988:b0:490:e19b:bd99 with SMTP id 5b1f17b1804b1-493d0f43052mr2171635e9.30.1783090398625;
        Fri, 03 Jul 2026 07:53:18 -0700 (PDT)
Received: from localhost ([195.94.145.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477db8a44d7sm17320171f8f.9.2026.07.03.07.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 07:53:18 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 3 Jul 2026 16:56:44 +0200
To: Julian Braha <julianbraha@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Naushir Patuck <naush@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>, mbrugger@suse.com
Subject: Re: [PATCH v5 2/3] pwm: rp1: Add RP1 PWM controller driver
Message-ID: <akfNrGoa0bitVSu9@apocalypse>
References: <cover.1780670224.git.andrea.porta@suse.com>
 <f8dd46a553351adaf9d29fbba9f98e803b672fe7.1780670224.git.andrea.porta@suse.com>
 <0b6a7f41-b753-48dc-b46e-77aaf0e999f4@gmail.com>
 <ai-dNlC1_nbQTy5Z@monoceros>
 <6babbdea-fa93-4cd7-8198-5cd3accc34cc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6babbdea-fa93-4cd7-8198-5cd3accc34cc@gmail.com>

Hi Julian,

On 11:29 Mon 15 Jun     , Julian Braha wrote:
> Hi Uwe,
> 
> On 6/15/26 07:37, Uwe Kleine-König wrote:
> > IMHO selecting REGMAP_MMIO explicitly here is fine because at least to
> > me it's not obvious that MFD_SYSCON enforces REGMAP_MMIO.
> 
> I think it's better to use comments to document non-obvious behavior,
> rather than dead code.
> E.g.:
> 'select MFD_SYSCON # selects REGMAP_MMIO'
> 
> But I guess this is not really worth bikeshedding over.

Honestly I don't have a strong opinion on that, but documenting is basically
the same than just selecting the option (well with the addition of the #), so
not really a difference. If there's no major concern about that I also wouuld
prefer to expicitly declare teh selecion of REGMAP_MMIO. 

Many thanks,
Andrea

> 
> - Julian Braha
