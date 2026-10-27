Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793122368;
	b=V9gvUIiZKFz9qhJP/pAhiT69/QT4DKciB7I7Zi5d/RJ8XNGCYVjEDeJymFir/3rnJUah
	 gPDhcVzsbWAhutfRQ02vbSRTiMFwn0Nh5j69tiivQz9qoGlnSqSN6z5t39I05m12hiYPN
	 pFfo8WYnoz3Iq0yu1cO9+szwjTkESl0OAaaZCm3PLc3X7g4auG5Bxo3/DiVzOjhsh0k8O
	 r5KTMYhXhTOAoNrd1dNKW93O8Gt0ZkBwagQwa4soT6JTI8wPntXPOxLG/acXlxeUUL1ib
	 6EYE3mdhsbEHfgcre9uiuEUwz1QcOZh4f05SJT8AaWPJ7UoSAckWCGpaoLF4PUDrEIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=T7vpIX2c6I0fdln2Veyf9JYdJ3RICzbnThdpI2zJVAY=;
	b=W8R15aQtpfBNZZ0bYs22V4Q6s8YyRdqes9Uph3VDpDfQxHw3yRXW/l1PHa5GZfACQscm
	 TTD89kucV+b4tzIKwAY2XfIfYeur0ygJZywwO6j2ju1PnJ8PraAZA7JfzkkSJfD+ah3DK
	 sY8CubkebVqk+Bie3UlZM5dvzgk6lMVqEe+1tHgo58KWnnc1hUd8nesoNKYGCh2MVyMqY
	 ngVJrTLBYdds3obA7U+Yufaclia3RBUJ8bWkwfgKGYkgmuVOeHQ+sUWUibeBwmvLgBY4z
	 VS46bG8IpKVcxKwD0tsmFpf5p1OVclLMatJu++lOQL0N66dTo1ssqJyTNDeaRPV7OMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=IERQJ8SK;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D07606A320
	for <linux-pwm@vger.kernel.org>; Tue, 27 Oct 2026 17:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35D07606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=IERQJ8SK
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso1156785e9.0
        for <linux-pwm@vger.kernel.org>; Tue, 27 Oct 2026 10:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793122366; x=1793727166; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T7vpIX2c6I0fdln2Veyf9JYdJ3RICzbnThdpI2zJVAY=;
        b=IERQJ8SKVi7acDhRQssNKz1tac/IbKaQ1f3zM2O6OFxp7pR62BajqEQCEG9JaHuJ0M
         nQcwhrNTXW9RxyhteLIPA9LNKH3J8QG6lRhv0OL4TUC+apZBNfnCpD+BF0HWr/VmHLKj
         QLLQFq36t5Dn2Lbi3bALdp6V6iWGR0HV+f1uumVypHlLGv2yedaXHJ1JnI/oj9ZLGnjq
         QVjST8/BTNTCaXMtA8cSAV1xFORYJbiv1UzZNmsysoTn46/NG8HHUwfmp1BBp1TrWO6S
         RsL0VSK+XetFWxWIQrF+txjov/HPcyrMrdiw0sWqufM1K3ER+n4eY4ikpmfRoDWv53YC
         TSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793122366; x=1793727166;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=T7vpIX2c6I0fdln2Veyf9JYdJ3RICzbnThdpI2zJVAY=;
        b=ebqRg+7He9vV2PEMomZCY98HQXB24Z1zadP/6M5FcFfBCa/geizeW2rESaWUDvKQg/
         NFk1PHtpw9dUCVQyXLsk22Dh4lYqLfWDuLUUETXoZWQg9fTd31Erc1rKjXZ67i2v1vyX
         fEuh3DuPuw2JceM0GuAw74s5xspiBWq9TbA+iO9A714LfUifbSGYgmJgXGhGmk7RNzRG
         /YwTMGqAhPK9NtFkL/On8GwyX6nKQaULgJUS3gpdt3wqmhODztiFV0/GfvF2of2Snqrp
         ieB29V6A8NTAP6dSp2TPI8ZtHvIXxzE2Qnsru07Dc8v4I0QnDN8eaeAvjfu9QTxIgeJu
         0+Sg==
X-Forwarded-Encrypted: i=1; AKwUvBzUIxDniEnQhM6JEbblIFQLo+oieG7si6am3Fmq0dU9qndhX3YysW8KcWu7QzQguWVN9b4mAR2dXtg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDM8m54sLUEZjEoKsZ0gCk3H2OvVf2GGNKSVbiS1ajeRnA5Flt
	XCZj5oosYOQPfUbUqFi+gjNIEATKEL0YHO0InpKyWBWpuHUPSdiuDQVfipYJRxxnUYI=
X-Gm-Gg: AYBFou0kY1picZTHoUeeHOz5eJw1nAXvzBpNNGBVMQahP9m/+5hYIuW+OndnuaEELnT
	LDNt8j+b6rJxERNgjCUxN9EF42XRDWV0KpgSu8pPQfvCa+woo/RfS/nGoIvR9Ro6qKBVJw7zeb4
	ncVh9FBLo0Qdss8arzn5BN24MJXJajcHUGIAMATf+mVq3b1T1+bNxk6sdrS+4cxrjuKe5K2SDoO
	RKq+pB8W52qI1GBRRaBBz3XpqSw0h/4TvlRPsnnJlMTdZ54QaEkLpP4VdIh6XEN4l9G//YNMWBx
	Cr+V+itAO/SQ2rYXy04Qg6TewfhkYOu5ux9uoz+gxlYzSMD/QU5dWsVpETKwEwxpWhEfuEfdTOP
	HtO9FxKl8RsEHcIv2rEtlylcp7zc+haieKVWuckZg1Ma0Hw3QMav4DVgh6FgxrpaPzrxJmSF0KI
	RaF72pePiYiMuBOCUe/kLYFkDc8fum56Rz4vCMkaIld7f0DvRukaBQqLOaXvU+1CDg0jq3xMZpj
	v0puPORP8njt/+qHmm7EhNP475gYoY6OdW/BhLfzbm5+gM6x3zmKyg=
X-Received: by 2002:a05:600c:4ece:b0:4a1:fbd2:f689 with SMTP id 5b1f17b1804b1-4a35ac9d100mr198532065e9.7.1793122366508;
        Tue, 27 Oct 2026 10:32:46 -0700 (PDT)
Received: from localhost ([82.192.120.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a92b881f90sm5173585e9.11.2026.10.27.10.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 10:32:45 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Tue, 27 Oct 2026 18:36:37 +0100
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
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
Message-ID: <auDhJbMOQ-qAeBBs@apocalypse>
References: <cover.1792748690.git.andrea.porta@suse.com>
 <0d2249a66732bfce38a2260bee08cd1ba4097e51.1792748690.git.andrea.porta@suse.com>
 <auDRHk8eaYife2zH@monoceros>
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
In-Reply-To: <auDRHk8eaYife2zH@monoceros>

Hi Uwe,

On 17:32 Tue 27 Oct     , Uwe Kleine-König wrote:
> Hello,
> 
> On Fri, Oct 23, 2026 at 12:15:56PM +0200, Andrea della Porta wrote:
> > Add a hardware monitoring driver to support the fan tachometer on the
> > Raspberry Pi RP1 southbridge, found on the Raspberry Pi 5.
> > 
> > The RP1 PWM controller block contains specific MMIO registers that hold
> > the current fan speed in RPM. These registers are periodically updated by
> > the RP1 internal firmware based on the tachometer pulses.
> > 
> > Since the Linux PWM subsystem does not currently offer a framework for
> > exposing integrated hardware tachometer readings, this driver is
> > implemented as a standalone hwmon device. It parses the
> > 'raspberrypi,pwm-tachometer' DT property to find the supplier PWM device,
> > establishes a device link to ensure proper lifecycle management, and uses
> > RP1-specific PWM functions to retrieve the RPM values.
> 
> I wonder if the tachometer readout should be a counter driver? That
> would allow this driver to not be specific to the RP1 hardware.

I suspect the counter driver won't work with userspace daemons (e.g.
fancontrol) which use hwmon as an interface.
OTOH this driver is indeed specific to the RP1 driver: the fan rpm are
read from the same registers range and hw of teh PWM controller.

Regards,
Andrea 

> 
> Best regards
> Uwe


