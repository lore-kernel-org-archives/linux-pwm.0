Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22359396D13
	for <linux-pwm@vger.kernel.org>; Wed,  5 Aug 2026 14:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785941925; cv=none; b=eN+HbwfWdBUlmSJhQlLxwF9G4X6rTVald7+/IP8gX5co81XdUWjl/CvuJ4NVus8VwnYfAVc0Ig7o2AG6eE/4F0QsmonABwlM+OeJey9x1BOMwfYQo1leRWEbPlRUVFB7X1Eyk9LD+sxlZNjOUt+HHhI0TO4+6RnPcYZn6XW6t0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785941925; c=relaxed/simple;
	bh=3X0KDF09iQxMFFXCdCq4FJa4+miV7wutwAqBq7ddcCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHqbbr5p7SMVztIc/jQecxO6u7PC/WH1386FNYRXvtvsEoQoBiGvrxpvAM1cER7wh2Uslgsm0whB0S0OZ+v81ooNzKqQTxjzoQv5EGL1WMwT4SIT1yk1NVXxCyrsz58EipJ66nEOeNZ5CW3N3KHyVeAU2Cbs40o7enrinTK3p+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QeYbRgCP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeYbRgCP"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso12001185ad.2
        for <linux-pwm@vger.kernel.org>; Wed, 05 Aug 2026 07:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785941923; x=1786546723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ew6Pd3+czLAbTbQ+zkKABqRt8uLi3Q4e6R9X4R65Ps0=;
        b=QeYbRgCPastJkS+eXJ5sgz6rBhJq4cUt77SyAdI1nK2SbTypeZvsWYT5ap6s0ZBG6l
         sV6rRpS4hmjqg3Xlqz78FR3l/ZK9IyoASEDgEy+1WojpHmDm8sdkTPMD9N9nGcu66Pon
         OJ7SjyWbZXO/Ya1995FDR2hwbnVTPAQJWYSbDqAgpfIJSuanccMTdKt+Xk27hU4yiHA8
         XWExWAok6w+1Dy5YwXR7BrtWjzwGrgt7qYbuiPAz8odp5lRCmSXvOAiueMHKR1v3RJkE
         iZKd1aPMCpdCh6TnpnvIchtXcR3cHuhHcwggTKpPBEaqctJrP9Uz7Ucdr7qGFZJF/0Xg
         UYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785941923; x=1786546723;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ew6Pd3+czLAbTbQ+zkKABqRt8uLi3Q4e6R9X4R65Ps0=;
        b=mMFNjxDjVfxRj1MslCVBvbq/PPe3qu5oqYsm3FqbavCRDtu8Jm+AMjPloS8E7KPvk+
         /NlG0UIRdGI68GJ6oE/F84xKn/x+p4KL0dQJoyVyqTtVz8pjXWNr8AfFA7Fw+k/4ml2Z
         WH7/fA0+CSiMrl1JRSF5kzgD+3oDP6cvcXFF9VAgTvfwif9JFh/5d7MOjs3fNb3r5ftk
         UpH4S7pBKijYvzRVuUNOmsZQSWJu/EOkzhRh9R20jvVgnYv20eQTjocb22mRn7tSh3Kj
         6wWIJ0GuQlf8DIOm9fVVdxg6e50KwH2gSL5dNZ/oUsvsSc0y9A9ZqJohvB77xtvYGwy9
         y3Pg==
X-Forwarded-Encrypted: i=1; AHgh+RrHTVK65o8cblc2Y28P9nDdnN5B4DMb8QKg08uycX2+w2b9kBghipxlkxsuXT0zSyh3YOMW07+PhFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyriJqOB/9MZw5SEFiD3qsH32TmtDyAZ8Az+MfCAgIw26cMos6A
	n10pj5KmFvR+DL7mWdDL8oZBvqSlv2IRAJZMaPbLqSq3zuwFtiRpwgxH
X-Gm-Gg: AR+sD10VRmLwkiPolFyMc70wXyUGI18PYgTBzvf1BQsoXpSmPK0HaUSPpYgP0hZe5c8
	pXuvTpn89Xc+xQ6/TPNEOXkEH3eaHcA2d6VuYLUHf/35eQFEONen7cNmrnm+rUqGz++TzDHKWbv
	hE0V7mTz5Bb2PfvthGYZFA2DGlMqduPQ4LIXHEZULXOz1LFBYO4a+Z5FiPvOA1w0FMOi/PDdViv
	J4kFxc4arj8x3YKh4+7F4b66uTdx8qGtRKb4O1aEiVbfIMBgBD0+loNoh6OWS0FcoqMuUHTJQ/L
	+xABk3nImaE+XfmZFIuaP5Yt7EGkG/qQD8o+SORDi1Yq41+b017v9wNRNCSLQPxnQHIzF++UvwU
	Het+97kF5jnYnWnLz4RrqtmBobqpyygeU14lVYrUF4L30ydcEgdTiHYXxBJe8BXcO+BV6qBa+79
	sw2xQwl0ITB9pQaRZCXBGyuc94pS1018Wv1EUO2+DpuTbgi1q28iUikZLYPktRdpIgEKlYUPtlF
	w==
X-Received: by 2002:a05:6a20:2449:b0:3c4:2fe1:fa36 with SMTP id adf61e73a8af0-3cb86029556mr7984191637.36.1785941923409;
        Wed, 05 Aug 2026 07:58:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315867a96e4sm16077831eec.26.2026.08.05.07.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 07:58:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 5 Aug 2026 07:58:42 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Darrick J. Wong" <djwong@us.ibm.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [hwmon-next PATCH v6 3/4] hwmon: (adt7470) Expose fan control
 via PWM framework
Message-ID: <2ab29038-dfb3-40ab-a4e8-e880b9cce279@roeck-us.net>
References: <20260805-adt7470_thermalzone-v6-0-5605a5f95467@gmail.com>
 <20260805-adt7470_thermalzone-v6-3-5605a5f95467@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805-adt7470_thermalzone-v6-3-5605a5f95467@gmail.com>

On Wed, Aug 05, 2026 at 10:15:19AM -0300, Luiz Angelo Daros de Luca wrote:
> The ADT7470 features four PWM outputs designed to control fans.
> Previously, these were only accessible through the legacy hwmon
> sysfs interface.
> 
> Expose the ADT7470 fan control lines through the generic PWM framework.
> This allows generic PWM consumers described in Device Tree, such as
> "pwm-fan", to use the device through the "#pwm-cells" property.  This is
> particularly necessary for boards where the ADT7470 external temperature
> sensors are not populated and the chip is used strictly as a fan
> controller (e.g., Edgecore ECS-2100-52T switches). In such setups,
> delegating control to the generic PWM subsystem allows the kernel's
> thermal framework to manage the fans based on unrelated temperature
> zones, such as internal SoC sensors.
> 
> When a PWM consumer applies a new PWM state, the driver automatically
> switches the corresponding PWM channel to manual mode so that the
> requested duty cycle takes effect. The duty cycle specified by the PWM
> framework is internally converted to the 0-255 scale expected by the
> hardware registers.
> 
> To prevent conflicting access, the hwmon PWM sysfs attributes are hidden
> when the device is registered with PWM framework support (i.e. when
> "#pwm-cells" is present in DT and CONFIG_PWM is reachable).
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Applied.

Thanks,
Guenter
