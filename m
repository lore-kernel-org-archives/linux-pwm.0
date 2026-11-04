Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799519;
	b=QRhSpPmkJDrPP64rlNeiWMNgINJ0+kjSfQCxagDG9hxNLh1NB4FRhM6hWbGC7m2Xehm8
	 GXXbagSoK4SFSK8XmqkpndLqamudmd0LKasHC8EF3cXaTUeMOcswF5KOoR80Nb8Z0yNjW
	 bAGRjYwOITykKEMoms/9j9XTiGFMZJoCNwgpZTzcge41T+P3+jM9kESjexGj3Rhng8tNy
	 mqDAjlAMe65/attuNNiBYa5CAYrpC+5RJIvGowIcqEKQ020U61ZoC/hChPTcBy8sTC6rs
	 HtYeQKWpmLhdKVm6TBmclfj2/EGr2WwORHQNpazBL3QCqMcsOrd6HGmBHUjq1lrFX+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799519;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/ACB8f2xH1rEkjmG+UvGKZpwz98xJh2FSOOsD44xzng=;
	b=SW7ESqMGn521scMomtVjn7JIX7xd6eQxmuj+SoGfa2Zhxa3QSK8+0lpcvzrIvyH4psbs
	 /XQ04Y0oQWY2taMEweD84061Q7E75kWdsje0F/TUxCUmCExzzyE6Uoq5Op8UQOQtnHs/R
	 bQp3leGLQCBhoYbrxz+McUnG8CkClHEJio9x0UQH4QS683m3/czJVUIMp/MheE4gVtgAA
	 1MJVshA3hf/oHPHPsMN6Vnn9wBMJ7d2kd8g9N330vdWFjimHC2t7IZfMiRqovDSx4Dltq
	 Ce3h8VAvuxGubVzWm2H5ENfsTef/0uaqueLSxq1PFeDzx93StgIlDrhlQpuZelIn6hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=fhMbzwx4;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62961606A333
	for <linux-pwm@vger.kernel.org>; Wed,  4 Nov 2026 13:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62961606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=fhMbzwx4
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso629066f8f.1
        for <linux-pwm@vger.kernel.org>; Wed, 04 Nov 2026 05:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793799517; x=1794404317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/ACB8f2xH1rEkjmG+UvGKZpwz98xJh2FSOOsD44xzng=;
        b=fhMbzwx4Iq3YFHIOVMV2AgcTVSX5bUIm88mP+/GXafUHINhjR0DYO6dU7UajUYaLNv
         622SV3vWe2gVwtnM/S4TyrixZynQTJd990ccLsFi+iKL5m3KUuTfnetJpBvFVrgDR9//
         QZ8wE7FXI45OO2kd1I22aQgTNsNCarR3pgZmoYbY7z2ICyVXmK9V4QvTmytgxfNZLusn
         kjD34hr6y1GrE8O3mCCvKyVzFHNqiCC4FJqjYk4RvqAB/s6K/KgJoYdL7jpZW5+d95Ha
         iwx2i7fpT/3Twvz7KWPXs3ZVe5oFYcZg6xsyEcgvCz4H4S2N2JkotapGLoTOHmYFUw3x
         6NYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793799517; x=1794404317;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ACB8f2xH1rEkjmG+UvGKZpwz98xJh2FSOOsD44xzng=;
        b=sY7eN2d8NhXuiCHa5V67EIpR+i89L7/r0KP93XBTJ0PBmmz/CWJFyFSwqwiS2TMM47
         8ePDIrpFDDE0EkXJtVUi93CLYuzIgUVn9UfHRDSE1TLM01s3XVq+jYP9sZp2pmW20/Ub
         STsnq8xsCESGuFJwlDZKpo1Kp6EnHwVzo/M/wisa/CpV/9WQ1ZYbznF2JTXcF4a9pSHD
         BrILalcCjqAP8BiEw/ggBkbKlySXI1f7kRvRl7W9yQeq9bfLMP1uULxN7wg02Tg8tiQ7
         XQeNybde4g4F8H114SXGttjXXgq/qf27FONUodQ/FygODQwyhHslmVQIBxcIRt3XP7Wa
         V/BQ==
X-Forwarded-Encrypted: i=1; AKwUvBxLOokmgBxxBhXxbyTHWvvosgP3f2rQpmHARPZnWkUzhLqCOnyMuTk7caCSDPaZQUcRjZlsXNsWToU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8rzWlnJEPeayavjue3hcKTAKJAGLOHI580M8BwbdD3ni8lJTts
	H8QPL/dUUoKGnrr03fIIsX6yfLPv5t0dzNMPotXwjiFFLJgEa9PRCghNfy6nZyKQdz8=
X-Gm-Gg: AYBFou3ZPPwQbuMlxU5ebki8RPVGWKImR0L2bLm1Z6pyhAeF0kgd7CUSI+keNb/d9xk
	2qUYN0M7+orcgEhZ0eYXHCPj5vetEEWcUI3IO2aZgfsu4plG+bOkt3XS5Oar41GRUykA4DUBS3A
	zXQzWGhR5c2hEEQeU+r8cZhJY5nLsq5AQcNzUOredbMnQMDVK9U4nhBgzTHdQia1TfTuOE21W04
	em7nW3WHjipKc/uW2D9xj4qW4GiTqLsF397sc0sLwPcuz9/pTdXfs9/ZrppKkWXEZ/AI7HsVHu1
	otHBBIFBF1n2Vz3MTl/m9oCmgxzfocp/xKrf3HIwCvoDzegRdZ8JbYbE8/DCF0cUd0Z2uaYrIoK
	L3Z+g9kfPVWweJPYaltJYrqy2XoR8tCQ53ZYxnH6caQcvoSlIpb8gvNbWStvB60RvunyaPZfUeP
	wTqkRaPmfq2RZXvfqF5GTQVu5hwv/3dVEl7BnfV6mltxGApsR1ljB0R4hegoVIsP5Q8xSDQcr5E
	ekss0QDTMhwUYdaMPfDQtmIahRWQyCGn3zWrug/gNBOixOU5Dw1knBcrWDkQBbxm18YPHduXpyt
	384XjTBRdZdGXDSiLnqkY9uSvIJw8vQFVFBkvBw8ELZr7Wg3
X-Received: by 2002:a05:6000:4026:b0:48b:4a2:8175 with SMTP id ffacd0b85a97d-48e6e501911mr37072969f8f.43.1793799516428;
        Wed, 04 Nov 2026 05:38:36 -0800 (PST)
Received: from localhost ([82.192.120.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed552afcsm3985293f8f.41.2026.11.04.05.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 05:38:35 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Wed, 4 Nov 2026 14:42:29 +0100
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Gary Guo <gary@garyguo.net>,
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
Message-ID: <aus2Ra_sLySMZU1i@apocalypse>
References: <cover.1792748690.git.andrea.porta@suse.com>
 <7df58d42-517c-4936-88b0-9d044d30882c@roeck-us.net>
 <auBzvB8TsvIK8Hik@apocalypse>
 <53a4b4bb-271c-4d2d-a9e4-cec4e0ce214b@roeck-us.net>
 <DMFPE71J8205.3FZKD5BKW3U7C@garyguo.net>
 <b02b4f0b-ad2c-453a-b69c-a0865a333d62@roeck-us.net>
 <auIotAwnOWKNApjp@apocalypse>
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
In-Reply-To: <auIotAwnOWKNApjp@apocalypse>

Hi,

On 17:54 Wed 28 Oct     , Andrea della Porta wrote:
> On 09:13 Tue 27 Oct     , Guenter Roeck wrote:
> > On Tue, Oct 27, 2026 at 10:51:15PM +0800, Gary Guo wrote:
> > > On Tue Oct 27, 2026 at 9:48 PM CST, Guenter Roeck wrote:
> > > > On Tue, Oct 27, 2026 at 10:49:48AM +0100, Andrea della Porta wrote:
> > > >> Hi Guenter,
> > > >> 
> > > >> Yes, I also proposed that in the cover letter because auxbus seems also a viable
> > > >> solution.
> > > >> 
> > > >> The current implementation is a consequence to the discussion about the companion
> > > >> PWM driver, from here (and the revisions that followed):
> > > >> 
> > > >> https://lore.kernel.org/all/cover.1775223441.git.andrea.porta@suse.com/
> > > >> 
> > > >> To give a short and hopefully coherent view of the decisions, here's a breakdown:
> > > >> 
> > > >> - first proposal: PWM driver + fan hwmon (to read the RPM), all in the same driver
> > > >> 
> > > >> - V2: Uwe preferred to split the PWM driver from the hwmon one, so the hwmon was
> > > >>   dropped from teh PWM driver in favor of a future (fan) driver. To accomplish this,
> > > >>   I moved from readl/writel to regmap + syscon.
> > > >> 
> > > >> - V8: Gary proposed to export a function to read the fan RPM as a viable
> > > >>   solution. As a result, the regmap/syscon was dropped as it was no longer needed
> > > >>   and the function has been exported from the PWM driver
> > > >> 
> > > >> - new patchset for fan driver: the now independent hwmon moodle just call the
> > > >>   exported function from thw PWM driver.
> > > >> 
> > > >> If the auxiliary bus is indeed the preferred approach, I'd like to ensure we are
> > > >> all aligned, as this would also require refactoring the PWM driver.
> > > >> 
> > > >
> > > > Let's say it that way: If you don't want to implement the auxiliary driver,
> > > > and you insist using the exported function, I would prefer for you to go back
> > > > to the first solution. The one thing I really dislike is conceptually broken
> > > > code, and I consider the current approach broken. Your call, but the one thing
> > > > I won't accept is the code with the exported function.
> > > 
> > > I agree on the auxiliary driver part. However, I don't think EXPORT_SYMBOL_NS is
> > > an issue, and regmap is not the right fit here:
> > > 
> > > - Previous version of the PWM1 patch series publish regmap using
> > >   of_syscon_register_regmap, but this cannot be undone -- which needs to happen
> > >   on PWM device unbind (the RP1 PWM device is itself platform device, but RP1
> > >   chip itself is PCIe device which must be removable).
> > > 
> > > - The tachometer register is not its own separate register, but rather (re)using
> > >   the phase control register. The phase control is not implemented in the RP1
> > >   PWM driver on the list yet, so this is currently a simple register read -- I
> > >   can see that RP1 PWM driver need to take special care to about the tachometer
> > >   reading if the phase control is implemented.
> > > 
> > >   For the two reasons above, I think the way that tachometer is read should
> > >   really be an implementation detail of the PWM driver and not for the hwmon
> > >   driver to worry about, so I suggested using EXPORT_SYMBOL_NS.
> > > 
> > > - EXPORT_SYMBOL_NS is the documented way for exposing functionality from parent
> > >   device to auxiliary drivers: https://docs.kernel.org/driver-api/auxiliary_bus.html
> > > 
> > 
> > Let's agree to disagree, and keep the code in the pwm subsystem.
> 
> And auxiliary bus it will be. I propose the following:
> 
> - drivers/pwm/pwm-rp1.c: create an auxiliary device for the fan. The function to read
>   the RPM will not be exported, but a function pointer will be passed through the
>   private data to the fan driver. No need for regmap. To be taken by Uwe.
> 
> - drivers/hwmon/rp1-hwmon.c: The auxiliary driver is probed against the device registered
>   by the pwm driver. No imported function. To be taken by Guenter.
> 
> In this way, we decouple the two drivers and we leverage the auxiliary bus paradigm.
> Also, no DT node needed for the fan.
> 
> Do we all agree on this approach?

A gentle reminder about this inquiry. Before refactoring both the PWM and the fan
driver I'd like to be sure that the proposed approach is at least acceptable.

Many thanks,
Andrea


> 
> Thanks,
> Andrea
> 
> > 
> > Thanks,
> > Guenter
