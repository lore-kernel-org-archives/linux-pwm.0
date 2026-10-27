Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793094358;
	b=Q94CHxkBFYoNZLEgaAL3JYkfz1rlUjKLfY3ipYsu8nl8AZmwkU6EVaZ5oPBupKJlNbSQ
	 gOCexBKfWSOkYXsfvQf/K4lkfZDV7wnYJROil4MZrnhYf8SC91m2Cm2HG2ICq7p9EVBL1
	 JaR+AS1EYoudggOyBttn0zrrlCEGpkl0kyeLyeeKoYx/xM1n4wzWUy1abGWPflfsn83cS
	 nx6eZlbAbYu46Yve6MzKWtb5BOfvaMpn02g2as2NLvHQbQF9Wfyr6r05elcajQR/VYlsS
	 UdWUrL+jIbbEQ02dpi6CqJRmBX0BR9yoMuo1Ou0QgEzQzdltFro/ecEqGFYZ/3wBZ6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793094358;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=kxDEiSmJOiwfSYua1Zz9+AGsc9tKlOqwY2WHmMR/V1I=;
	b=FvRFi7c4lpFQZgHvYHrL0QFKBUJA8yDbU7SbyzvWRREV1f+Cw0yTStT8CgxwlIWRrzDd
	 ag/coxmx0SqYpejpnClzOFX76SvxJfwdvnuMJLfDBv/DpLFBCCXjzaGBopF+Lj/5kpw9y
	 nCzaGUm2fCznUGkKdyAREFZKvY3w75lgm0n0ph1+Ln5DEguG0AYCMbuKinTze9OcFWDq/
	 6yos83bfcismahaNd/fghtib59kIcbwHf2UB82cLT2BAGluG2yyoKi4k9LLieTHgwO2g6
	 0s+/kgK9l5/nnezKy4DQnikkXh5is/0eNMgnKHXe0Xj1vRUYVAV8F0Ut8vs6CQENTtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=foXTMIMq;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC606606A31B
	for <linux-pwm@vger.kernel.org>; Tue, 27 Oct 2026 09:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC606606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=foXTMIMq
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a208d93758so44925155e9.3
        for <linux-pwm@vger.kernel.org>; Tue, 27 Oct 2026 02:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793094356; x=1793699156; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kxDEiSmJOiwfSYua1Zz9+AGsc9tKlOqwY2WHmMR/V1I=;
        b=foXTMIMqZgAtLBq9U6Ye5Y5BEyzAFblKZjMqyPIiGxW0GYSUWzFinU/uKs9vprN6Ye
         Hz/ClFy9OizHTRH5VyRnVcxo5LRCHq7k+nDdzYf3BcrgdxoIMjpDLN7sR8P1dfxW8GlM
         Prw4tjEQSlDYcv+4KVQ/R+2qfvyN5r93DDysB+0pt8EoK+BXRwBx5nWWIx4bq3Q7lXB/
         5U0pymYRzO/nQFKCWbevF/E3kqjzK6yxzrphZXdk0iTzLuEZiWNuQhxk3QDJC9HMyEEa
         YBRbtfB4dfeU5rHkUnSMNO4xtvfkAh7JjrjmBtJxPlgn7QIzfkhgXHrwW1f9OrBppYAR
         toyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793094356; x=1793699156;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kxDEiSmJOiwfSYua1Zz9+AGsc9tKlOqwY2WHmMR/V1I=;
        b=hLo6o+GaU0paaUGdiQuDtRp8PCF/gccXf/k2DVgXcV3pbmNkO0nDSSNNGMz+iHmcsY
         CcrGfN3rX1mlIvC8ZW2dj/IgLLA7F8ty0CBFgKTwA5l3jjcLOqMoH2FZ5gZ8r8CeUQLf
         5mo1PgrpOCo0Nts1YWV2AfZN+MVaTv8OkRBKJMvtaqowU962RCeO9YtJr1vEmcguNTn8
         XAMZpnm6Ka6HHmoZQP4nSluzsSm6TMEF/6E8vAS2d4dt1aTVRboWagbdkUKN9zi3LO2S
         hrHirradgEN26fpdi0ijw7ZXYtDQEsBzghkDVz88drTeMZr3ImVjQRiCS4YAEopgKDzH
         bDOw==
X-Forwarded-Encrypted: i=1; AKwUvBy50Cs/TX85WFNHjYE9RgGhO+nkqqM1AmW/XHTm5qf+sk+aIHfdB1dM8Ju6lSz/cyY1UzhuINCH6VA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIW04TEv7rikBQd/SQ1Slrglc0qCOg5u47/dyrY1Mjj8/IjBAiM
	ESSeBVGJBBqJRtYe0sEl2Aj7t2AKEcedWtwMyxMb8JBpBxHb6+X99nH5Kmu9thKLzq4=
X-Gm-Gg: AYBFou2d1CUCRaGo2Dca9iTQCj8tRWVv0wawMNqIHLdSX8kCzevhKWot3qawXrYfPjS
	t9IkcseOsw5KDBIBOKLIt/FZAgasUFQV1LtjYHbR/KYHkJ0nAxQJuQy1xG3D/p7vuHrO7BopaTf
	uFFYtzunw2HCDuwfWrrqUKUB3SVcKjp6ABnIIAm2bvim0e4aCGiPMKhNKMhrdADEtLB0FiGBER9
	zbdrnggn4C3bwQnoFgRpOO3JiUCDozepbZSeLQ4hY0VqcsnVAWUdst3OSGxqK+dbAPmEErJdSTU
	aFrGgMmw8UuB7e2YrO+PzJnEY0SkSNn7m+tu5OvqSh10KKLcr14h8HMYtgmQQg2zqjwM3F+BUNB
	Vjap6kKqdrFRBG5grGak9fKRZDTjP2aroPtEwNqH87Zk8jRr3ekOcsy4AlkZdszSl68GfIHZx6S
	nq+PLd6FQWdIp6tlQTHMKJ5RJL1EFADyFdhgH3+Hb5cEZj4CLkO/Abk2AFRRMfQfVYlB2hKVXdg
	bhFoyHu/9+iOPwyUJouukTbbxyf60vJt00/BT43HXgg7/0qmiy60ko=
X-Received: by 2002:a05:600c:4f0f:b0:4a0:27eb:49b with SMTP id 5b1f17b1804b1-4a35acba87fmr202982885e9.30.1793094356233;
        Tue, 27 Oct 2026 02:45:56 -0700 (PDT)
Received: from localhost ([82.192.120.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a2d9280sm251609365e9.13.2026.10.27.02.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 02:45:55 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Tue, 27 Oct 2026 10:49:48 +0100
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andrea della Porta <andrea.porta@suse.com>,
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
	Gary Guo <gary@garyguo.net>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH RFC 0/4] hwmon: Add fan tachometer support for Raspberry
 Pi RP1
Message-ID: <auBzvB8TsvIK8Hik@apocalypse>
References: <cover.1792748690.git.andrea.porta@suse.com>
 <7df58d42-517c-4936-88b0-9d044d30882c@roeck-us.net>
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
In-Reply-To: <7df58d42-517c-4936-88b0-9d044d30882c@roeck-us.net>

Hi Guenter,

On 09:24 Mon 26 Oct     , Guenter Roeck wrote:
> On 10/23/26 03:15, Andrea della Porta wrote:
> > Hi,
> > 
> > This patch series adds fan tachometer / RPM monitoring support for the
> > Raspberry Pi RP1 southbridge found on the Raspberry Pi 5.
> > Please note that the patchset in [1] is a prerequisite for this one.
> > 
> > On the Raspberry Pi RP1, the active cooling fan speed is controlled via
> > the RP1 PWM controller. In addition to generating PWM signals, the RP1
> > monitors fan tachometer pulses. The pulse measurement and RPM calculation
> > are performed autonomously by the RP1's onboard Cortex-M microcontroller
> > core, which periodically writes the computed RPM value directly into
> > dedicated MMIO registers located within the RP1 PWM hardware block.
> > 
> > During earlier discussions, Uwe Kleine-König explicitly indicated a
> > preference to keep the core PWM controller driver (drivers/pwm/pwm-rp1.c)
> > focused strictly on PWM duties, rather than bloating it by registering an
> > hwmon device directly from within the PWM driver (see [2]).
> > 
> > Because the Linux PWM subsystem currently lacks a generic framework or
> > consumer API for reporting hardware-calculated tachometer readings, this
> > series implements a standalone hwmon driver (rp1-fan) using the following
> > structure:
> > 
> > -  The PWM driver exposes and exports rp1_pwm_read_tachometer() within a
> >     dedicated symbol namespace ('RP1_PWM') to read the RPM value from
> >     the MMIO block.
> > -  A companion DT binding (raspberrypi,rp1-fan.yaml) introduces a vendor
> >     property, 'raspberrypi,pwm-tachometer', to link the fan node to the
> >     PWM controller node without overloading or abusing the standard 'pwms'
> >     property.
> > -  The rp1-fan hwmon driver parses this phandle, establishes a device link
> >     for proper runtime and unbind dependency management, and registers the
> >     standard hwmon 'fan1_input' sysfs attribute.
> > 
> > An alternative architectural approach to the DT phandle + exported helper
> > method would be to model the tachometer as a child device using the
> > auxiliary bus framework (drivers/base/auxiliary.c). In that model, the RP1
> > PWM driver would instantiate an auxiliary device for the tachometer, and
> > the hwmon driver would bind to that auxiliary bus device without requiring
> > a separate DT node.
> > 
> > However, adopting the auxiliary bus would require a more significant
> > rework and refactoring of the existing RP1 PWM driver.
> > 
> > I'd appreciate any feedback on whether the current companion driver with
> > a dedicated DT property is acceptable, or if an auxiliary bus-based
> > refactoring of the PWM driver is the preferred upstream path.
> > 
> > Patch Breakdown
> > ---------------
> > Patch 1: pwm: rp1: Export helper to read fan tachometer RPM
> > Patch 2: dt-bindings: hwmon: Add Raspberry Pi RP1 fan binding
> > Patch 3: hwmon: Add driver for Raspberry Pi RP1 fan tachometer
> 
> This seems conceptually wrong.
> 
> Have you considered implementing the hwmon driver as auxiliary driver
> and accessing the register in question through regmap ?

Yes, I also proposed that in the cover letter because auxbus seems also a viable
solution.

The current implementation is a consequence to the discussion about the companion
PWM driver, from here (and the revisions that followed):

https://lore.kernel.org/all/cover.1775223441.git.andrea.porta@suse.com/

To give a short and hopefully coherent view of the decisions, here's a breakdown:

- first proposal: PWM driver + fan hwmon (to read the RPM), all in the same driver

- V2: Uwe preferred to split the PWM driver from the hwmon one, so the hwmon was
  dropped from teh PWM driver in favor of a future (fan) driver. To accomplish this,
  I moved from readl/writel to regmap + syscon.

- V8: Gary proposed to export a function to read the fan RPM as a viable
  solution. As a result, the regmap/syscon was dropped as it was no longer needed
  and the function has been exported from the PWM driver

- new patchset for fan driver: the now independent hwmon moodle just call the
  exported function from thw PWM driver.

If the auxiliary bus is indeed the preferred approach, I'd like to ensure we are
all aligned, as this would also require refactoring the PWM driver.

> 
>  > Patch 4: arm64: dts: broadcom: bcm2712-rpi-5-b: Add RP1 fan tachometer node
> > 
> > Thanks,
> > Andrea
> > 
> > 
> > LINKS:
> > [1] - https://lore.kernel.org/all/cover.1790686331.git.andrea.porta@suse.com/
> > [2] - https://lore.kernel.org/all/adLTwOTbkJ0VQXy6@monoceros/
> > 
> > Andrea della Porta (4):
> >    pwm: rp1: Export helper to read fan tachometer RPM
> >    dt-bindings: hwmon: Add Raspberry Pi RP1 fan binding
> >    hwmon: Add driver for Raspberry Pi RP1 fan tachometer
> >    arm64: dts: broadcom: bcm2712-rpi-5-b: Add RP1 fan tachometer node
> > 
> >   .../bindings/hwmon/raspberrypi,rp1-fan.yaml   |  39 +++++
> >   Documentation/hwmon/index.rst                 |   1 +
> >   Documentation/hwmon/rp1-fan.rst               |  41 ++++++
> >   MAINTAINERS                                   |   1 +
> >   .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |   5 +
> >   drivers/hwmon/Kconfig                         |  11 ++
> >   drivers/hwmon/Makefile                        |   1 +
> >   drivers/hwmon/rp1-hwmon.c                     | 136 ++++++++++++++++++
> >   drivers/pwm/pwm-rp1.c                         |  27 ++++
> 
> Either case, there is no such driver in mainline or linux-next.

As stated in the cover letter, the pwm driver comes from the prerequisite in [1].

Many thanks,
Andrea

> 
> Guenter
> 
> >   include/soc/bcm2835/raspberrypi-pwm-rp1.h     |  10 ++
> >   10 files changed, 272 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/hwmon/raspberrypi,rp1-fan.yaml
> >   create mode 100644 Documentation/hwmon/rp1-fan.rst
> >   create mode 100644 drivers/hwmon/rp1-hwmon.c
> >   create mode 100644 include/soc/bcm2835/raspberrypi-pwm-rp1.h
> > 
> 
