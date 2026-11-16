Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794846523;
	b=f78fYWXA04KOT9tAQ/vORaT/P3yJQgGuwOqWHu8F0bBXsZf35LmI/TARACICk9k+/uPn
	 be2JiBO0hBjL8Yw6y9Ry5mnq9oR/S2tAPmukTLf5iHDnzCWFEc3Qimr+AuSKhIh6o9hQx
	 Tsggva4U0h2K4vMLFAY3FYN97iPD12JVZxwW/Jz0inj2nMetB5C06VsNvLsa0t3d926ls
	 3au5MGZ6F6RjzPD7g6c4lAnULZBVZ5Ii1FIb54iatomqMptb5k10Hqubec3D6xJVkqBRQ
	 vvIPK3znzYoRRrRUNVdECSgtLZLMP3z/sbLMONfYjgyjH70K3TSMpO6ng6LpMteV5EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794846523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2+nzMcVP/+P9vG+E1zkKZ9XZsaAgRds940lbNhNpcpI=;
	b=2YSNAwfD/ZlFY/qIBh/VBkAD+Mn59xNs0b2qh74797CalbrfKlGASZAoHrlNnR7atPQ8
	 QHgoPIh9Z1uFLpCqmQxobtQddOP1hdT63/V9uJprmrPQh8Yt4QFmukwIEAqQ4HmqQNgmj
	 3k+OQ+lsuIflD0tT0GE2C7Pu3nVdMcocFRjY9IaSIxUrzSPhAw/uT8RpcgmF7Vq+i/6Ug
	 KtbVZAz3f0TFJAUv8u92xuiUT/kKj2pErWNkLzTAaaDURXMqdw3FmHt10lEfGO2I24UJ+
	 sml1diH9tMYG6dU27Zkj+AUe/wV0M4zx2kqDCnu+PIIZV0lKNi8umrQjZ73TnBJgw6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DgGsa1h5;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABAB606A322
	for <linux-pwm@vger.kernel.org>; Mon, 16 Nov 2026 16:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CABAB606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DgGsa1h5
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4b467581b98so31823455e9.0
        for <linux-pwm@vger.kernel.org>; Mon, 16 Nov 2026 08:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794846521; x=1795451321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2+nzMcVP/+P9vG+E1zkKZ9XZsaAgRds940lbNhNpcpI=;
        b=DgGsa1h52Rts8iMQsAM4EJfolE1WumuJFMv+MANoxbtXJXUOJKjkXxqF7F52ddwi4B
         igJl8Rh2ip7GVy8wPhlLKhruAujaQotXx1zhJlK/t1l3kKd7ciRnftPamiLQwevK64Bt
         k8APXM+6MHR6p9gPx61Vp76+p/B521PwanYfwN3htVEnEoonaZ23QL33BIDUw3R+yf4d
         h4IbGGGBRAapLvL8Rlc4TNDPbcyxFICIxnJoPuMIWyJ/Ovt2fCzL+Zl6ikJ+w7CHqluQ
         Ayy4mBCMc8Z7wwVKi76I1WC/0L03NnAnS2aMKpMAIs0mwzZilY4SpSvU/4y2CBxtQROJ
         IW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794846521; x=1795451321;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2+nzMcVP/+P9vG+E1zkKZ9XZsaAgRds940lbNhNpcpI=;
        b=Usm7oQWgaVqpnK/hlYNM1fADQGjrCdo7IfCXF6Xvbe6k+Rr1qDmCDk2nJGjbWVFNjQ
         ib/czqk7GNPWNdMC0mn/XlWbl7A59pz7eMYzBk8KDW0TwTjkityHDWsMbwAGtt1gVVvS
         EiNLzsG+7C2lAKrjFHpvztysxICYWJ8MxwdhsgCUAeyGVd6HH3Oj3ywfWAT1AmwQ8ZXA
         xaS/whWFM59ZNWAXEpPspeDQNL98htAck+EL8WR9RhFip6Lj62ggMZnOWJ2UaH+ekwxe
         EvxgNAFKNg0EE1VMHjz7B00X2uny7XSjhQaUQT3FbbDiLmG0jAlI05PG+pyNpmVB9AjD
         TI1g==
X-Forwarded-Encrypted: i=1; AL+hErFs0iqx92r4yNN96xHXY6hmHq1imrmYheANfG+zO0BNhU+uBYTL7q0mgtCR1en4sVaQl+aJSFoOBB8=@vger.kernel.org
X-Gm-Message-State: APuU4Z//d+2l2qWp67EUM9UEhwKCl+BXSkrFB1ETgWHhqukusX4QPEg9
	IIWBjhdXMd740WErg20eZEyJpGldjDvNcl/68N1CYDk0ZG1nkv+drLq3
X-Gm-Gg: AYBFou3+eD/eJ+E6q5/kuxKcsLj5tZOxQSGTmYwJN+xBTDQISN0jW0iHZBFdIuxoJyN
	lfKInnDHJhrc26IBoNnzEYmMUmbd5CuKpuQoN06dX70IGhdY30WI2KG8NV+gTqtmBSEzmY8CGTy
	KoG+WOUT3g/d5GS0Yf9voSWR5a4Qei3VScXj5gLHmw+E1TljL1aK8VlMmH2XEdWrL/tIAN64TPh
	5CUB6m4HBYxTpEgKCfprS6G1asukXFwIqI6PypDQ1N/jyUnW038Oie3OCLPWWa4ulW7sjAf7zxy
	AP5enUcGGQK78f5BcuTtOaSe5eHWkssTNTF5/U2miFGXxhwgo1akuu1vrpH4SoL3alPKYZxrqDG
	CglhWLrFNuZodRYcSrlA135CiqJdZ9Du2A3Mt0+EFpSthOHYjM7fQkzfu9ruYn5sRf4uig7SKKj
	4FG8e9cFGaZMUGA5d7OPjFwLa+yv//wBqb+pLdF58oVSj6LN8l4M2dvPgh366HWJxdMBQrGD1lN
	YBhMhdOlcsCph3UBxwdk3m+1vzKDVgyn/oiz2sLPvC3R56HIP1AGdROSfJZ+3g1KeaRK8ea8roX
	SfvAjDwC7dNgfNFoG4BAnq8iB6nDonq6HnV+WcG12O9S8SvGa4xhS3mV7O7oQieIoDylwKDNR2Q
	J2wd+Rn05d/iE6Z1prpGlwzWeHZxNAa7ax2pCiLvHAvfyQG+0jUw=
X-Received: by 2002:a05:600c:3e06:b0:4bb:6947:3e1d with SMTP id 5b1f17b1804b1-4bb6947426bmr119351755e9.20.1794846521012;
        Mon, 16 Nov 2026 08:28:41 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2adf53sm412165885e9.15.2026.11.16.08.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 08:28:39 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Mon, 16 Nov 2026 16:28:32 +0000
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@analog.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-doc@vger.kernel.org, Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 08/10] iio: frequency: ad9910: support iio backend
Message-ID: <ika7dmfhhue7il5xgbgx434vjxdwj57dz6kebaossw32vym7nt@gmpxjkkqirgz>
References: <20261103-ad9910-backend-support-v3-0-0e9224ddf7b7@analog.com>
 <20261103-ad9910-backend-support-v3-8-0e9224ddf7b7@analog.com>
 <auoRUS-tsK4X0KoU@ashevche-desk.local>
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
In-Reply-To: <auoRUS-tsK4X0KoU@ashevche-desk.local>

On 03/11/26 18:52, Andy Shevchenko wrote:
> On Tue, Nov 03, 2026 at 11:53:04AM -0300, Rodrigo Alencar via B4 Relay wrote:
> > 
> > The AD9910 parallel data port allows modulation of the DDS core parameters
> > at up to the PDCLK rate, which requires a high-speed data source. Add
> > support for an optional IIO backend that provides such interface, with
> > data streamed into the device through an output buffer.
> > 
> > The parallel port channels get scan indexes and scan types according to
> > the data destination: 14-bit amplitude, 16-bit phase, 16-bit frequency,
> > or the 8-bit amplitude and phase pair for polar modulation. As only one
> > destination can be active at a time, this is enforced by the available
> > scan masks. On buffer enable, the destination is configured in the
> > backend and the parallel data port is enabled. The sampling_frequency
> > attribute of the parallel port channels controls the backend data rate.
> > 
> > The backend is also notified about profile changes, as it may drive the
> > PROFILE[2:0] pins, and the debugfs source attributes now consider the
> > parallel data port when reporting which channel controls each DDS core
> > parameter.

...

> > +static u32 ad9910_buffer_chan_idx(struct iio_dev *indio_dev)
> > +{
> > +	unsigned int scan_idx = find_first_bit(indio_dev->active_scan_mask,
> > +					       iio_get_masklength(indio_dev));
> 
> Split assignment.
> 
> > +	return ad9910_scan_chan_idx[scan_idx];
> 
> Who guarantees the scan_idx to be in the boundaries?

ad9910_available_scan_masks constraints the possible values here.
will add a comment.

-- 
Kind regards,

Rodrigo Alencar
