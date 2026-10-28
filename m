Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203784;
	b=REXZkgOpCC7e/J8fBeXh5yQGScOjATEEyi0gtmRGlI5rgg0gpSEmLrgpGv6711e3PMEr
	 Pvo5P9CmgOyxZbg7RP6qct1WZTb19PnNx4EmxpCmmZgGzRlchtQVMNrxNAF3XhdyUNH8g
	 sy7orjzfqYJZGGqrHtMzarRcWV8gBTk/CuSQ+AabJLFdo7NvwDwEqx3KeJRBnb+AMKoih
	 KQ/I6tzryIAVraEol5kxsvj4YOHCrbGtaGbW6P5MR4b8bOylqjXaObni4rkWFywLqO56O
	 Mwyp9yYQE9MvSTHyPBFW9lcgDoHi/zxQFuh1WKEXwxqQGpQEXiEcZTlhQCI3vJqeaZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203784;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=YZcts4qcYFLKUzeEZmCB29OAtaKV7wlY2duix3l+9sA=;
	b=cxRy8zOGtzZ7T32Ag2eBdGC8WKrJGeyg8OAaAfVRmv8ywX4YymKGiECfb5HJ/l0u/aJi
	 oOxZHd/ijRsPWJmQW40HEcMVWrzijBJRghdsHa9U5TNnYrby5rPP605vXy7CThEAK3GCT
	 yReOIDFCzW7eWenoz2V8BGQJ0QiEcoH+DamHkREahNhEBFWyOshDqptlyCc58HYllUvcw
	 2HhPtaub0UvK9aetlgSj+W8D43l330ooI2Fc2TlmF63MHLUbspx7PnGiv5LnX7i0XDKl1
	 rKGt4eklolvsqQ51f1F6HBKJZEwHWzo+0jNOg2v+aYloEdUvVfWtFkgM+IM1pgdg+vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Ji5Xvtpo;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90F1606A32F
	for <linux-pwm@vger.kernel.org>; Wed, 28 Oct 2026 16:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B90F1606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Ji5Xvtpo
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48dfdd0678dso753979f8f.0
        for <linux-pwm@vger.kernel.org>; Wed, 28 Oct 2026 09:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793203782; x=1793808582; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YZcts4qcYFLKUzeEZmCB29OAtaKV7wlY2duix3l+9sA=;
        b=Ji5Xvtpoxyb8kVn4SdVY2cX+DsEgu1bKkZdsC3ebjs4d1+CltzAuRtjoP6qRorAjmm
         U/OTale8tpuOeROnVeyxXNIIaWfog47eEJFCNp27SbEPsWiXlbJSFUU7KgmL/w+kS1Qk
         Xoz40ZBJl6WRqwF7cZjV6sWb8IbzqZcrFctXWKFMXwrZRtrx0RyDRwjEA32GAPhICZjW
         MQaQxgB9raqsmYBxkaP7PzkQnI5sX89vYUiv0DZuFdVs9fh4gndC7Z/ZAgGohdQcpiRV
         +IlqliYlhUTo7YEUzaeGWGEgvu/pIVHVtE9NKkTWWWXdySGqcXDMlZXy58QAKS+slkSX
         voyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203782; x=1793808582;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YZcts4qcYFLKUzeEZmCB29OAtaKV7wlY2duix3l+9sA=;
        b=ljo4Qgr3DdT4EmwqHuqw5wCFEqurm6SIBvcoWXobrZSwcurpIi3/VPaU/8mG3pl2bu
         PVltEy/g4J9sxD2D40IF7rSenlN0DwPxfu9gpweD4PFUP4+ygeBd1pUymAUPv5k89iOW
         PxqAzv/u7G4gI9U/Mf57zBEqGVkkZAMyzvaZxJ644hAzeaIjoBcJKnLVKkQD2KRvlMlb
         l7i5NSX/Xyv/AK7ovT1/L9BBrgC7K8oWkX80/o9y7iBmWefWlTSnY4yxxi9w1x5uE9kP
         gZTLi8wcGJ05/P7Mr4VhQXOlp161IEs4loahUhCt7ePaYenu4U0h7MC2G2c99rTAWNEI
         4vrA==
X-Forwarded-Encrypted: i=1; AKwUvBwy0WvLaqMLUGmOJ54qqRqRlS2LIeVNL5Yx1WYCMpERE2zhiZbD5YVUGMhESuCT7xKfFHaoicrQ4tk=@vger.kernel.org
X-Gm-Message-State: AFq9FYImiNwPmNMoRVyzH62mjl4QYfu1bK42PGQGGqE1YkdMQI3phvAw
	D3Mx+Q7M9XmCgf+h3UGD5suFZOStULKm6/UJh2MGNRm+XdqJqYqAVOsAymj2SsragLI=
X-Gm-Gg: AYBFou3aot8PyzRrckln4cBFVGeJy/yhEOGjN0BZZyGu1JsSOLkPqUUnqHqb6Ne68Wx
	t4jP1DkDGwQkday5o/xvM9G5IpmyC46AwPWx+lGUxM+0f7GdnyABjSI47ghx17quJvu3NtPKz5/
	o6MRBCgZdLEeZhq29XMDlMwWaG2ctRmM4kypk/fdeafmWbBrYb/NIrEFQme598TmNonEqepIX7O
	B+a1/OprhftgYorhOer5MUlDqtSPQ9xpYJh4ByZ/O625Xs0Sy9ApKzqDmBnJjM1XVdoGYguP+4u
	S/0nv2651dQarpYv5QzBhDuzB3dI1TJNN6mU5qQA0JyzEzDcsvh8iHOe+HLy5OThdTin0SU8Cok
	AFep7Zpr5LJjFnkvDgm+wpRmGFKBxn9vnNM7n5JSul3fvomxUZrOK+n3ozDe1G0XFQ5p1uSJazr
	bXffZbFYlGm1cBORMfvY6FFb2gm51a2ju+Jqarmm8oKsJhskr0ULqth9+l5wx26IEu06HPnBEY+
	LuSa+ytZzsvcwOpv5v7PoBdHfaUvUS5F3B1NBBLDX6DCMcLnJOIkTq4MZ5cliCE6NEnIc92g8zc
	KVHqCj5uvq00R4vFRUndH0D+2MzlAg==
X-Received: by 2002:a05:600c:4f89:b0:4a1:c6fd:4db0 with SMTP id 5b1f17b1804b1-4a966c41836mr68052215e9.19.1793203782221;
        Wed, 28 Oct 2026 09:09:42 -0700 (PDT)
Received: from localhost ([82.192.120.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa8213ead6sm1572025e9.14.2026.10.28.09.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:09:41 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Wed, 28 Oct 2026 17:13:35 +0100
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Gregor Herburger <gregor.herburger@linutronix.de>,
	Stanimir Varbanov <svarbanov@suse.de>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
	Gary Guo <gary@garyguo.net>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH RFC 3/4] hwmon: Add driver for Raspberry Pi RP1 fan
 tachometer
Message-ID: <auIfL4ZGdfNDUZxO@apocalypse>
References: <cover.1792748690.git.andrea.porta@suse.com>
 <0d2249a66732bfce38a2260bee08cd1ba4097e51.1792748690.git.andrea.porta@suse.com>
 <auGdsv0OVG4iLjZV@monoceros>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <auGdsv0OVG4iLjZV@monoceros>

On 08:02 Wed 28 Oct     , Uwe Kleine-König wrote:
> On Fri, Oct 23, 2026 at 12:15:56PM +0200, Andrea della Porta wrote:
> > +#include <linux/platform_device.h>
> > +#include <linux/mod_devicetable.h>
> 
> Irrespective of how this patch set evolves: Please don't add new
> includes for <linux/mod_devicetable.h>. <linux/platform_device.h>
> already provides of_device_id without introducing a batch of unneeded
> dependencies.

Ack.

> 
> Best regards
> Uwe


