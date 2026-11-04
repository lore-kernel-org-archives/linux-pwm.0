Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793782459;
	b=FjuAXQqdBSPnsuRpRgMIvsjqDd3Lzk2joe1R9uqG6xPqHtdiJZH8XkEWrTZUy6g+fpaH
	 fBGpIqvTW92tE3IOcdEfOD1C/BZ7AnhGCie2CADwRRkV2UXe85jhbv1Yg8f4UjbD1eMzj
	 Qoao9I+ZLYB7D2vWGjxO6Ht87/wPsJFaEIW/BmvQoMX2EUom7KcVPqhwLksTnDcyywsm3
	 0Nzr8Yk63UvppljTovg5C9Ti2ChiRFTkueepcQIfAehYZ+XgzkFB1RMKJOLcvs2+QFSJt
	 z/oNdOJp80Beb4xYAGXQ2igl3ciiugK+IDZ8XPmsnUIk15eHFlG3JWQvtjaghFcydfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793782459;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=995SOgcWBB026Ztcaii7kwHRKn59ipdNGgwbnoFQZH0=;
	b=MAz5zsKZ1J6T6NDgCp6aHt0KEBhHThApsufHB1us80iJQ14nxWdOnDwEDFI3HZEWhlss
	 99w2Zmnm3UkvNOPDfG9J+u9dp3bK213u2+C2vq+cMF5gbl/Dueal80qafR6Q+ct9aQr8q
	 5dvwE3Y3En9ldZ1EsY6Vd6Ek5qAQhT5twV70oRkNYtCJbagFkd0RhqtMzo2P7c7a+X5If
	 /mZP08yz0Hg7s4HQShh7VkfwV291g7AqCn924UVu1zNwkKldfE9WG2WUiwjMrtahCWk4H
	 D4+riCCKJmwaCnD03rzdF85U3jV//R/Kx0LEEpH+zIXjSasoVP0GMAf7cPd1mYA9HHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hxZ0G9Ms;
	arc=none smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192C2606A339
	for <linux-pwm@vger.kernel.org>; Wed,  4 Nov 2026 08:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 192C2606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hxZ0G9Ms
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b0d63f60bcso6641947b3.3
        for <linux-pwm@vger.kernel.org>; Wed, 04 Nov 2026 00:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793782458; x=1794387258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=995SOgcWBB026Ztcaii7kwHRKn59ipdNGgwbnoFQZH0=;
        b=hxZ0G9Ms2bXEh5gQJZdNqjnx2lpt6R1XWLc8qWOrdhhjkK+LOEjyXqIOolu6ay0jTq
         GyZrycPkfvSjp3XlXU2LmYduWVgjHEwJfeVAPEtyyGOB6mgJ8UakSs7StUoej6/oZ+6L
         tGV6+SkSg5NZOvGBXbC5dZQ39prmruKSPmBQX0INnv0KscvaGOSDkkaYre2oZZ+MZ2Is
         ywu1wQqVelzsnzzG3ZrnvNx59HwAHvMlSvpIniWRyNP/y42RtWYToDxN3KHfao8vzzC9
         kSX/XpkllP4D7BRvdqFTAqnwzVBatbteWhKGYI2d/7Kyxx9irXthmzRlMFDpycX9jehZ
         xw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793782458; x=1794387258;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=995SOgcWBB026Ztcaii7kwHRKn59ipdNGgwbnoFQZH0=;
        b=ME0TVaAi4AmE1MhZ1ncqU3SRnJy6yBJNZ/Vk1fLmKZdW5vqYHSLlRB0aoH3QtQyORy
         fx5Xa/ieNp8olGdI3wxrqgCba9upBvr5S3eVcvk6CJuQZdhCXanPDSGEEWwcshnic/z9
         27rDpmgUyOuifALWnD0TL+aEMW573NVe01TzYwih9IaAXOiN+SmewUFEA3zgudMXK9lm
         lx9LAE9A7iiB007tiKO01XSuhRC/30EQRBnkgTgIpzBe7/qhbc2gbStLmhS4DkimUo8x
         UsD8DS3pxBT5q5rx98L2Dxd48Opdbd1WMZLcCOZTilhB7bYYYo2QNOKko0Mt8kOqjxax
         pH3w==
X-Forwarded-Encrypted: i=1; AKwUvBy/I4p7RMfx6POe6VVW//+umSpB1qJtc8RiCWzNluH1sZ42mzGWMSqHcCjnVd0hFOa4YFDBKdtVVJc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Atc5/58UwlocunvR8O7QBKDhQuCzAAQsAQyxnwh51xF2JUhDl
	XumSU22rss0jEGcfxicrAKMSkGRlVSZWXQ3sHqxaYyBzQQ6uov0H4RWr
X-Gm-Gg: AYBFou1aUbG/lS/PHDcehJPGT8DQ5RgXKB7kyfywLd/XkV6kNc8VGifc8RU5QzRx9N0
	pDr2VzCJBF85zxhwLR35eJBnnNSaWvazg4bvYnYLN3bMXORhsECeLuJl/CPSfj1BHOmN5hlnuXR
	KHbKmGBvRpkvbGslpEsV358c9r/o9DeuFivDSysyiMPawbzdI8heP1Ir50PLvy26gQnFVCg3KlG
	MKCkxXUpdTkCyxIJ7D1THUduTPeyMq1QBXFwcZUKcnvY3bzpT52wsnL2keDoH2QEltNTCS5C9R5
	2NZu2GStwpeOhW0l9cniETSqRsSFU8o1uHzZcpFRzOfQsiu/ztGqHApgGpRaQIwZpoQhIVN+QuZ
	jx7vSf7eSMBw8TOK7pXSul3U8wcmYtZasYZWYH1K0M3BqEtlqbHsB+mcxq9DQwhD+fapQL9WIhj
	HhxCcWs/CDzieNZSl9qkDPEvBVrOStwmyB4kyF8WWfCGOgWIXx2CgtiK1nIAgElNiy/Gdv1vKm/
	5COnxJzH91r38vT2ZG4XkpGJ2TKUabkG6WS3IYz1nVgFW6OnpV1AA5pNtWCn0qpwhdNLxQlm2ac
	h8hCopy91bZvZzltmhZBhztElFh0MUdQ8GctJORXiZvzfM+Xq13XHUhGo+xc0NaWWgs6Ar7zQq1
	vzmrJZGFq9pJV+bfCCpdHKMQD
X-Received: by 2002:a05:690c:dc8:b0:8a8:7fda:15ee with SMTP id 00721157ae682-8b2b676a6e5mr116717537b3.50.1793782458184;
        Wed, 04 Nov 2026 00:54:18 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com (158.95.44.31.netskope-rdns.com. [158.95.44.31])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b3098c3174sm14420647b3.12.2026.11.04.00.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 00:54:16 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Wed, 4 Nov 2026 05:54:07 -0300
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@analog.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-doc@vger.kernel.org, Olivier Moysan <olivier.moysan@foss.st.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 01/10] iio: frequency: ad9910: powerdown fix
Message-ID: <ynwpqktxxbunqm3ee3q7iogrjynlz3egrwryfb33vsp7x6wcqr@uhfsxwrpsyhu>
References: <20261103-ad9910-backend-support-v3-0-0e9224ddf7b7@analog.com>
 <20261103-ad9910-backend-support-v3-1-0e9224ddf7b7@analog.com>
 <20261104002042.10064e8b@jic23-hlaptop>
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
In-Reply-To: <20261104002042.10064e8b@jic23-hlaptop>

On 04/11/26 00:20, Jonathan Cameron wrote:
> On Tue, 03 Nov 2026 11:52:57 -0300
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Enable the software powerdown on all the applicable CFR1 register bits at
> > once with an IO update.
> > 
> > It turns out that DIGITAL and REFCLK_INPUT powerdown do need an IO update
> > when enabling the powerdown, but that is not the case when powering it up
> > again. It is an asymmetric behavior, which was observed while profiling
> > power consumption in the lab.
> 
> Just to be absolutely sure I understand this right... The bug today
> wastes power but otherwise doesn't break using the device?

Correct! 

> 
> I'm just trying to judge urgency of applying this. Is it fine
> to go with the changes that follow later in the series or do
> I need to rush it in, potentially delaying the rest.

I'd say that there is no rush.

-- 
Kind regards,

Rodrigo Alencar
