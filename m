Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792754121;
	b=Psssf4YZpMSNo8aCLiv4porRTHv5DQ/3VIm1dEOSF9qDyJLkxCIovU1Nh2Wh1K6HQOZr
	 1a9ZXsFtvwGgTnVW3XVzDi/3Q79sHGRr385jYNMUf/dh4MOuCUlcG1gimbxB9Gy63uDU/
	 r/ZB6V6axUZoLCoVZwJMpV2/cTQUs25mMD7sWnpDRYbnqQ4jcqjJlCAD9d0qSESYUd3YO
	 uB0HX+0guo+Wbpf1wAVAPTuTaTno9cE2qBYnACyO9kfj+RHiFU0xX6rO+1XCpwflu8vmC
	 MCdmqhF9G0jqW3gdqdNB2kgTR5sBrXSzuE6k6LzSISOTHiLE0O95EdiRzwa2DA4xL6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792754121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jIxHZGuZV2ahnY6L2CqzTw2j0WYDDpMIbxX1aENaO+s=;
	b=I1eGSyVE3tSdnxuXbiQH2VhUhsi5bnHNKVcNXre4pIaL9dyYgGPJ8xOdDidi8j9kMTm1
	 7w6kDRInxWLBPvdxK8b7VYQAypVgou8o4J2CDi5Mycu7binv61sX47vx9IgQa4+AQC/8r
	 Y7BPfDNfZ8N3SCNMPbdin6osg8xtzitji4DVLJBRs/Nr51+B9k5MejJH5XLLHCNp7ijtK
	 fat/Mb5YljS/7CFLrPVTGKvCtHpiHNF/L9LEuWAkoxbTcOlokbAutpuZ6sMamz0lFTDh5
	 AgTxwwAG9fcLn2zzgYGgDm1kJYjk/edEggilzcgdfP2LVThTzVO3eyW943nkV1jZMBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gB7ZU72T;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AB7606A326
	for <linux-pwm@vger.kernel.org>; Fri, 23 Oct 2026 11:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26AB7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gB7ZU72T
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3adc0fd0299so573701a91.3
        for <linux-pwm@vger.kernel.org>; Fri, 23 Oct 2026 04:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792754120; x=1793358920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jIxHZGuZV2ahnY6L2CqzTw2j0WYDDpMIbxX1aENaO+s=;
        b=gB7ZU72TlDrjtJg2VoknUpiMrc5WLYdiqf4lkuMe3uifTtYoe7UpNL2lsmXJmD9kvH
         SsLAi0bz0acbuZguvc/MJxABOwXflROvoJ8fXKuCex/V5dfSWnupFH2RRwK3EOJ/0Bge
         6F4Y3MDGJP6oj474/IOPZ1XnA9Bd43ACAeZzQ9CAx/aKusmx4s3DpnEIg1st86GSMR6o
         S2TXN+ak0DiSPieJLTyV8uyQ3co2B/kCLvqlJA3wcwQFQFtCjjXuv6dX1SqYeofFleQD
         vgTpIYXMp/KtAvZtXa3YCiB2P4VG66t2hbESu+Ea3WYI63IPpSbD6lJiuDhV+6rcB48z
         AkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792754120; x=1793358920;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jIxHZGuZV2ahnY6L2CqzTw2j0WYDDpMIbxX1aENaO+s=;
        b=t0etCkMAaq4pgH0bsJEToH2S04Vulk1mV/IgsPFYiFuYqPALTnctGLrNbSjGtS83kO
         SYtjUZ2U+ZeAFAggU2HHh6/MazK2fl78jI6boKnAuzsdQBlrf9o58BQ9745jVj1EaxFl
         mI6i0+nfDq1m1oY3tyF5ZBmB+sQ7AIffsIc/IrZi3eb2+yQj7/1nFPOGvpbUjXucsFaE
         pKumRyjUM12KuzLccU+k+3hYcq8wvEWjD/4VwWbzpi7zdapeDoY1OTFl40hsfZ02yiAV
         npC63AUzzWvocQQYUmeKTk65a0kMjQK0zdS0wQGdKjgUp7URK3iV4beFfW2njXlIOSZp
         kh3A==
X-Forwarded-Encrypted: i=1; AKwUvBxMK4Sg5/MUkZokaVDC8kzy9d+cmBlgLQGglYdXlYxd1w5EjsQbC5etPFolq97nhPJHJO5wZUt9yqs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJb3ctzsgJopuNf0If3dO0sSDjQAI4L6QC22FYkJ/KeqlShZycM
	LVJuthsFpBmF4ZMzwwKibyLUaN22ytocpmyY2wMlgN4BTX9AVxlT08YS
X-Gm-Gg: AYBFou3dJyKGi+aUJ+UqZNOyifWIThPHvuSjr6wt1hHwOy6JhlQXzKYQR3MQG+cXAVN
	P8xrs81IsYX6sBrQBKOCAO/7PMoIYa7GgRkCaCO4sq7DQrJe4lxrBkeYycNaL8KzHehFYN237lO
	5gd3B9et9HAlajZlFlIGvPSwb7oaDT5/oUpas5HDbcu3l0bfYDCUXJ/oQUN7BFnxA5VsRVrp3Ej
	X35H3fdoZXFBUNAc6pZnbkiyxqWPoMHLK50QeCTDy9P+Cj8WJWWDpfzOZGWkICgifEO9iAuXV/o
	CPyg2RtyRHwHIqcAmFPwqIEa5yxMZK6qgnOUA5fmNfFNOrrQEbf7Utrukmi8jBsstt3ML5hwmMc
	HWvGhQd3lI0trC2Qah7g8odkm6zdrwV3dzQaYP6ciDgpQGEeCV+jvzofVjaXfKrgZacct1cbrDR
	kCThvnW+c62mR9fL7NTPZV1XL3/IJrUyghUPxfa3EEuuMougiLx0HEmN9+hnfEWxCndo1PwciWH
	6gtPSxB67Rkg2t6RV9K/MMF5+tcG9rTkotTsCYTqVpl8N6Xbb5w5iTyAzBQ0PMr9FJMpKo9KgAy
	eEbe8soNEBRrBD4UbreTk+f/1I6MKqsQ2S14wcsEuB6i1ESpCfQ=
X-Received: by 2002:a17:90b:3f8d:b0:3ac:7556:8ee0 with SMTP id 98e67ed59e1d1-3adce7a5a5amr1475790a91.19.1792754120415;
        Fri, 23 Oct 2026 04:15:20 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (158.95.44.30.netskope-rdns.com. [158.95.44.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3add2ae880fsm1037959a91.3.2026.10.23.04.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:15:19 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Fri, 23 Oct 2026 08:15:07 -0300
To: Conor Dooley <conor@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@analog.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-doc@vger.kernel.org, Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 03/10] dt-bindings: iio: frequency: add
 adi,ad9910-axi-backend
Message-ID: <hx6lt2u5j5yh3iez5zimolukip4a6ak36rdqridrvaz7bb25hw@6blwtzy2iuat>
References: <20261022-ad9910-backend-support-v2-0-0ff7f0bff326@analog.com>
 <20261022-ad9910-backend-support-v2-3-0ff7f0bff326@analog.com>
 <20261022-banish-scenic-030717ca503e@spud>
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
In-Reply-To: <20261022-banish-scenic-030717ca503e@spud>

On 22/10/26 19:38, Conor Dooley wrote:
> On Thu, Oct 22, 2026 at 12:19:01PM -0300, Rodrigo Alencar via B4 Relay wrote:
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Add bindings for the AD9910 AXI backend IP core. The FPGA IP core
> > interfaces with the data and control pins of the AD9910 DDS, streaming
> > data from memory via DMA into the 18-bit parallel data port (F[1:0] and
> > D[15:0] pins), which is clocked by the PDCLK output of the device. It
> > also drives the PROFILE[2:0] pins and the DRCTL pin, which controls the
> > slope direction of the digital ramp generator (DRG). The DRCTL pin is
> > driven by a PWM generator, so the IP core is described both as an IIO
> > backend and as a PWM provider.

...

> > +  '#io-backend-cells':
> > +    const: 0
> > +
> > +  '#pwm-cells':
> > +    const: 3
> > +    description:
> > +      The first cell must be 0, as only the DRCTL PWM output is available.
> 
> I was about to ack this, but the wording here caught my eye. Are there
> other PWMs that are unavailable?

Not for this version of this core. Other signals to control the DDS could be
modeled as PWM, e.g. DRHOLD, PROFILE0, OSK... but that is not being considered
at this stage.

> 
> > +      The second cell is the PWM period in nanoseconds and the third cell
> > +      holds the PWM flags.

-- 
Kind regards,

Rodrigo Alencar
