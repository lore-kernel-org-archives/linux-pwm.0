Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9203B4E84
	for <linux-pwm@vger.kernel.org>; Wed, 15 Jul 2026 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784133349; cv=none; b=b+J6RH7Hd2aVYyZOSta5Yl/9CGz5VFZU0dHugZrTsH242WTwq1bpDvmSOXQGAGblNbpuOT4nvvVjuidsSYdqtK/1rJiP0PA0CKr7MuSnct7G5/FB2kGDvyKnz9Os4wE4RDrkUfbdIG+xQgcZW/Mr6TD8CuxSHG8UNZ+8cPACFjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784133349; c=relaxed/simple;
	bh=7IrB0okd03Aqpih7Ns5d5dds/+Un1am8C/UF9ELzHjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUKgy8J5SpeEx1Eo1u6OZb1jDAsncS3qeEw7Nnsb3g/5UHsp4obFaxtHm9ZD/qlEM0b6ca245NQy9GKpapgmwOVIzTbEJQQ+Bhgrs3Uhe1yMiX0IKKCnG9/PBv+sM8U4INlfLC3OXMYkgOIRsM3oL1OM8hSOxbpQXoDELHKzaX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCY8RiUX; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCY8RiUX"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84861fc51f5so3378894b3a.1
        for <linux-pwm@vger.kernel.org>; Wed, 15 Jul 2026 09:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784133346; x=1784738146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xKMpslmS1nZLwbcYPHb8iOZLrmPISU+0dOPEfAdriDw=;
        b=JCY8RiUXpBXqEOBcCz4WafKkyHB8ySjhgeWB8GNXpoxdYAFfl2tk8WWSznNL5s2BNA
         1JdEj5JeRiy7hx6ccsoHwDQRLe4VNpdsjJ0Oqibb/lGu5lxhSCYTvfMZHkzDPGRsgeS7
         Dpfkd8XKHPAGyGd32nvlZ2hOu7P7oJt62VrioZfemi5jqEDQc1OgMwslRo4Es8b8YJ/M
         KyRDmEetrbnIp4UAoQmeR2+zRuPwe8j1gAYhD1PB7XyXJ/SiPIOBJpqo22WcHxe1Wh70
         7Ua9XjwM5KVybYBV3j6irPrF+ud6FUG/PNLXbq5PKdagSe8/hZzAkB8B6ak8w/9RCltM
         Rt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784133346; x=1784738146;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xKMpslmS1nZLwbcYPHb8iOZLrmPISU+0dOPEfAdriDw=;
        b=pVPZOX6hd5XqfBhShwTojGCe7de5FZZ2xbLdgCHz3+hVcnKGiYMy6QLhNFHlCKYM9w
         s15xeZHgZ4UQkjmoLodqJ9eBSwVVW+SRfmdNahFp4U0aTjrl+kO8oAXpk1WuBL30tsKI
         z8pE8eZoJYLjOO9CPN4CnwI2JJsJdLv5wXRT3PjyurZ4RjPlYtA+edNxFAAX8ji+RKqd
         /ostLFbKGtcFB98qDWszQe9Hy3DIxD5f53zy+TPztQ2HEdO4uu6SOc0lX8XMP0AYZKt8
         f6MxxXUtKIuEEg0i10KOCWQF1zADDiQ31OkGj2EEKOPl5dG1kc2Dgl9aRtjLIeZrLDEl
         b9Pw==
X-Forwarded-Encrypted: i=1; AHgh+RobnIhHs5u5ZN/Tda/sJiVQFc9jMJy9GQHyFfFOunf1DmCNqypJKz2U9pm5YqCyOEVaRpGNQ7HWEn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcR0liiLTz3Z0mqWWWRULQuTHuvUnLQQbMV38YMb285LRBCh2x
	JsVIzqlcs2cktnBhB+PZZQ+petVroeQvfUIEi+idaLLlJvXF+L8qIuPg
X-Gm-Gg: AfdE7ckqIOb7JzolwNcvihOJMjLpiJ/zFUlDAYcYhmlmQ5WvFbKjeevWMrIGCrsevp+
	phMkgHFym3E87HtbZ9U9WL9oq4vDsJl5opoVJ4jzmhw07NuYK37gbNVtJVF6vlMBrhXW9Hk7tS4
	RTgLBgu3LnJ9BD4O0c0lOsmQwqT6rvI6YgRwqF9YYwsJRBuvMrt3YnicVrf5KYhGvOFvbesqS95
	e8qAXJT5BiHV0T7C3mqkY85nE78N22UWd6AP0TD9ncEt3/RbxMDyU80l15ducDa1AyDaM2G4wfm
	kwj+2jbcwGPc7ptoTq/hWDMXoixFiFXCNPcpejI5ptPr6DAZ6zfiMBMQYmFgbgS9ZaRtu34/ae/
	b0tM2eVdUI3v57r8wbdDOeq2MXZXUf7Zh/foKZQnqkBgTYXmovXFkOI17JFPnUGtafqh3yURdV7
	KK7F9Tyf8x1hQCkX60tUBZyfZw2g==
X-Received: by 2002:a05:6a00:2d8b:b0:847:770f:da4c with SMTP id d2e1a72fcca58-84a672425fdmr2861024b3a.16.1784133346501;
        Wed, 15 Jul 2026 09:35:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f238b21sm3470359b3a.7.2026.07.15.09.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 09:35:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 15 Jul 2026 09:35:44 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Sasha Finkelstein <k@chaosmail.tech>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-pwm@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 06/10] dt-bindings: watchdog: apple,wdt: Add t6030 and
 t6031 compatibles
Message-ID: <990ec316-5050-4e7b-93f4-b5a2a85ef447@roeck-us.net>
References: <20260715-apple-t603x-initial-devices-v2-0-df65b2485710@jannau.net>
 <20260715-apple-t603x-initial-devices-v2-6-df65b2485710@jannau.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715-apple-t603x-initial-devices-v2-6-df65b2485710@jannau.net>

Hi,

On Wed, Jul 15, 2026 at 11:11:53AM +0200, Janne Grunau wrote:
> The watchdog on Apple silicon M3 Pro, Max and Ultra SoCs is compatible
> with the t8103 (M1) one. Add "apple,t6030-wdt" for M3 Pro and
> "apple,t6031-wdt" for M3 Max and Ultra as per-SoC compatibles.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Janne Grunau <j@jannau.net>

This patch didn't trigger any conflicts against watchdog-next,
so I applied it directly.

Guenter

> ---
>  Documentation/devicetree/bindings/watchdog/apple,wdt.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> index 845b5e8b5abc..bef8255022fa 100644
> --- a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> @@ -18,6 +18,8 @@ properties:
>        - items:
>            - enum:
>                - apple,t6020-wdt
> +              - apple,t6030-wdt
> +              - apple,t6031-wdt
>                - apple,t8122-wdt
>            - const: apple,t8103-wdt
>        - items:
