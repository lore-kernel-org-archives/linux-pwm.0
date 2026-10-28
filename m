Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206222;
	b=kEMiLnPquALuxSt//AZHShpl5KJ5uHQdvHHl4MJOOKjfDkw384g7Dh0jGMWBLfC9TiA2
	 dhHiixNlN7q4GudJjwIw/uOHYNwS7EhJCazBNZzyI6H0rmH0AI1g/6uxpIKrchpgRDmyD
	 GtkGQ8ONPzJV3vporOVAgn8OdmF0dGdI+udpMvpUzD4ANn9NbWxtqzPAg0R+w6L/F1fEe
	 qLdGfyxFdK8uFVVTENCPyqJjHDHJVUzHevJ4OgRZve1uRbEDXmHRSY8l4juEyTqrzIvli
	 P782QSSsHqfbeek+KrURTcxuXoCcbHQP2WkBCFGfGxLTTyLJxDQn4Faf0ggyQyi3Tbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rmtUDKQ0yoNlGhv53ScFwXXOWxSmXa4pTOke6+QnPrc=;
	b=Ts3kcuK8L55RPcNhQCFgGceC4x4x8ziAtfYbPatAL6o1c+DNYYz3wjlRfEx5Fkr/fSNs
	 hpH6hLLy4sj0edH+Bbls1oCgw21P8Rmuo6yMmKfS2Fa/GteUXVVAM/r0LQeLPiL4DjWoc
	 2U9KcmGoaNboLiYrAavC91IhRKptBBZavJSDPUVOT1WRWnoEmh8ExKTpR89pb4/MTbwVx
	 2upoYDR2zL2KV5qftU7qNmXVL2C1UTZ1xNYN54rC8fOYtaprAfSHHhliG3hrAYlwNK5Jd
	 qi+/oYFmRYXRepgmJNINmR7o5g+aQuCXMhxLgXqayZZx/9k+AltPpQRdZCnBzdot2SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=gXgEqKbh;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DA7606A31A
	for <linux-pwm@vger.kernel.org>; Wed, 28 Oct 2026 16:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96DA7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=gXgEqKbh
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so9858995e9.0
        for <linux-pwm@vger.kernel.org>; Wed, 28 Oct 2026 09:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793206220; x=1793811020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rmtUDKQ0yoNlGhv53ScFwXXOWxSmXa4pTOke6+QnPrc=;
        b=gXgEqKbhWXg0LLz9FvWn6V2M5RTpYqWlHjLH0NP+RzhxzISPz7BuGBUwie7l/s0pC0
         dOwOBNbVtUx+iHm3MIQFrm0Q6B8YArSlQrgE2RjwCmAeHjH/rbC2Ago7GMPFouoQ6/Ki
         l5VpdHIlZEAmEJd/hd6iBVSFe7YFraVN9uwKzuPIZY0xxhlmn5iKPXeboEDishSTZ1NR
         kxAs+/bXVi8UcA9VkCQboWB3250MXxYFPGAybyrY1stsxVzdDhdKlq4ix1NqVrhMkKw1
         +0/Ip1FdOvXwVyjfEdFth/TNwiS57iprsQbLE7kk7Ljjlnd8LVfmm4UX1+3z/GKZWwxU
         GfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206220; x=1793811020;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rmtUDKQ0yoNlGhv53ScFwXXOWxSmXa4pTOke6+QnPrc=;
        b=rY88ZSyvsQ6f93AEtRXCjak+637dEFhk59MGHsCj8Lgjnl6+yGEPHEzcme9DtYuPz3
         S8eUwgXjByZG4bBhm3obwsZJfIx618xnCKLMWXFpS+z5Tq/YLfjoTtH5MpyyM8grSBaf
         2NW/wt+mokTlfIYfQH8VEA80C5HOwnIFA9WY9irqBnEbdvwtcQs074qLalFM79JRxMm7
         d6t5J87OaHzV0ZEjOcmkr0NpQdU5iCUYBdHvgVmHOyOcombXbd9k50/ImnD8kPmN2WDt
         VgeD9Bq+sS49cJmQdRXLG7u72k4GBa5U0QuGjfa0O49hK4IGI1Le04QqJslccAurj9eB
         9whg==
X-Forwarded-Encrypted: i=1; AKwUvByBMXGavJWLEMAtGeh+B1rCCDVmHTsSqwXh690zGGMekJAgQOfzZmdD1b6DHsEJvpAfOC9effDzD70=@vger.kernel.org
X-Gm-Message-State: AFq9FYLVUUTgQXAD2nZ8YIqDmrzXrk46/vSGpeLltOW3DMhU8NnofJV4
	NfLhBwMRWNc7kiAMtF8qoJ6PqyZ+IjTp3WpYR76DtYY/BcoHi9omKJezdfdvvb3k2OM=
X-Gm-Gg: AYBFou2Roaaw5KhpMfeoViBvRPzGZb11jCNW9BhyhhXzRBcsfG6ofAeDPVfshTPD9rD
	M42M+BM8z3CZl+kxSoLnwatO03gbZnPjej6+zwilQS8g4mCIGRJILWibIffgmMr9XADRxsXzaHQ
	DUgf+Fvict7oRJOKCEDs/p+QQB5Z8Wb7K0b3NLYRqJgou21yQPuHDNT3NNPVA1gbjFGU8B2/p3b
	yDBVCc1hdflTma0cbnmXnfiEM61mVgaQtQdsy4jJlDdVPlwr1seejtVAuCljaUf1Uk1EjsNoygQ
	hWaB+d0ExiJ1EgT5ClL5qlBUvFd5QYokd1waJIjorpFgKKO1/OZOQY2VvnWrE/XLdFd49tsH6g5
	me/mgv5en9fTfRdaf0QPN17RuUGf5sqqTb0q/5rfQh66pFotyL1CTsNqLChAWP6ELH/bdxShxFb
	wStXvouq0Yw3dxydvVf5BwRsH56WgeScnaniZD59TvASvScoI22yVuKiVohV77p6sg+clc8+6Jo
	f3PK03NFo91MtXfBHZyRVO2oTBhUGuI3LsH25qrPuHxHoaIH8Nrel4SuI1GEAgxnBqqB0JdFEOP
	UdCUSxVgJ1FlgtD6f5OTNsAo2Le4
X-Received: by 2002:a05:600c:1986:b0:4a1:fae5:f2e2 with SMTP id 5b1f17b1804b1-4a9643d5154mr61518125e9.4.1793206219964;
        Wed, 28 Oct 2026 09:50:19 -0700 (PDT)
Received: from localhost ([82.192.120.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a94e4be4b2sm38091265e9.2.2026.10.28.09.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:50:19 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Wed, 28 Oct 2026 17:54:12 +0100
To: Guenter Roeck <linux@roeck-us.net>
Cc: Gary Guo <gary@garyguo.net>, Andrea della Porta <andrea.porta@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Gregor Herburger <gregor.herburger@linutronix.de>,
	Stanimir Varbanov <svarbanov@suse.de>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH RFC 0/4] hwmon: Add fan tachometer support for Raspberry
 Pi RP1
Message-ID: <auIotAwnOWKNApjp@apocalypse>
References: <cover.1792748690.git.andrea.porta@suse.com>
 <7df58d42-517c-4936-88b0-9d044d30882c@roeck-us.net>
 <auBzvB8TsvIK8Hik@apocalypse>
 <53a4b4bb-271c-4d2d-a9e4-cec4e0ce214b@roeck-us.net>
 <DMFPE71J8205.3FZKD5BKW3U7C@garyguo.net>
 <b02b4f0b-ad2c-453a-b69c-a0865a333d62@roeck-us.net>
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
In-Reply-To: <b02b4f0b-ad2c-453a-b69c-a0865a333d62@roeck-us.net>

On 09:13 Tue 27 Oct     , Guenter Roeck wrote:
> On Tue, Oct 27, 2026 at 10:51:15PM +0800, Gary Guo wrote:
> > On Tue Oct 27, 2026 at 9:48 PM CST, Guenter Roeck wrote:
> > > On Tue, Oct 27, 2026 at 10:49:48AM +0100, Andrea della Porta wrote:
> > >> Hi Guenter,
> > >> 
> > >> Yes, I also proposed that in the cover letter because auxbus seems also a viable
> > >> solution.
> > >> 
> > >> The current implementation is a consequence to the discussion about the companion
> > >> PWM driver, from here (and the revisions that followed):
> > >> 
> > >> https://lore.kernel.org/all/cover.1775223441.git.andrea.porta@suse.com/
> > >> 
> > >> To give a short and hopefully coherent view of the decisions, here's a breakdown:
> > >> 
> > >> - first proposal: PWM driver + fan hwmon (to read the RPM), all in the same driver
> > >> 
> > >> - V2: Uwe preferred to split the PWM driver from the hwmon one, so the hwmon was
> > >>   dropped from teh PWM driver in favor of a future (fan) driver. To accomplish this,
> > >>   I moved from readl/writel to regmap + syscon.
> > >> 
> > >> - V8: Gary proposed to export a function to read the fan RPM as a viable
> > >>   solution. As a result, the regmap/syscon was dropped as it was no longer needed
> > >>   and the function has been exported from the PWM driver
> > >> 
> > >> - new patchset for fan driver: the now independent hwmon moodle just call the
> > >>   exported function from thw PWM driver.
> > >> 
> > >> If the auxiliary bus is indeed the preferred approach, I'd like to ensure we are
> > >> all aligned, as this would also require refactoring the PWM driver.
> > >> 
> > >
> > > Let's say it that way: If you don't want to implement the auxiliary driver,
> > > and you insist using the exported function, I would prefer for you to go back
> > > to the first solution. The one thing I really dislike is conceptually broken
> > > code, and I consider the current approach broken. Your call, but the one thing
> > > I won't accept is the code with the exported function.
> > 
> > I agree on the auxiliary driver part. However, I don't think EXPORT_SYMBOL_NS is
> > an issue, and regmap is not the right fit here:
> > 
> > - Previous version of the PWM1 patch series publish regmap using
> >   of_syscon_register_regmap, but this cannot be undone -- which needs to happen
> >   on PWM device unbind (the RP1 PWM device is itself platform device, but RP1
> >   chip itself is PCIe device which must be removable).
> > 
> > - The tachometer register is not its own separate register, but rather (re)using
> >   the phase control register. The phase control is not implemented in the RP1
> >   PWM driver on the list yet, so this is currently a simple register read -- I
> >   can see that RP1 PWM driver need to take special care to about the tachometer
> >   reading if the phase control is implemented.
> > 
> >   For the two reasons above, I think the way that tachometer is read should
> >   really be an implementation detail of the PWM driver and not for the hwmon
> >   driver to worry about, so I suggested using EXPORT_SYMBOL_NS.
> > 
> > - EXPORT_SYMBOL_NS is the documented way for exposing functionality from parent
> >   device to auxiliary drivers: https://docs.kernel.org/driver-api/auxiliary_bus.html
> > 
> 
> Let's agree to disagree, and keep the code in the pwm subsystem.

And auxiliary bus it will be. I propose the following:

- drivers/pwm/pwm-rp1.c: create an auxiliary device for the fan. The function to read
  the RPM will not be exported, but a function pointer will be passed through the
  private data to the fan driver. No need for regmap. To be taken by Uwe.

- drivers/hwmon/rp1-hwmon.c: The auxiliary driver is probed against the device registered
  by the pwm driver. No imported function. To be taken by Guenter.

In this way, we decouple the two drivers and we leverage the auxiliary bus paradigm.
Also, no DT node needed for the fan.

Do we all agree on this approach?

Thanks,
Andrea

> 
> Thanks,
> Guenter
