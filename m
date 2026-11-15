Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.224.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794781266;
	b=im+clcC9lye57UOkEWzBJ+sbJmVcxnTTf7CBJPQAwnlHik46hxcHPKRi4sqYq5q+Q4g1
	 tZznuUKRPWol+UlHx2cyKju7LtatufNOkcZ7q/0W4B9YLtfqNQDZDNGi1DIVwLvJorZf+
	 n2tM56VeW7E1AWiPg25BLNPJkSMLFtBLWHI+C+Ww+4NiGIk8161P2m8oZYY4QUh6VMYB7
	 3t3ba443dXf8Fsii+XC3mLfAjSVTn85DdpUbAhFnskyU94NScp/VogFxoY27X0/v4K06J
	 iJ0ab5L/wl7ilAUSyEKTN8VHRG+vpVGXAlQp90EnEaeurK1f0tEVnTk4kz6UbdqlARA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794781266;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZAFY3cUder3qW+PINYFFGIewRXLP/J/NJFjtZaZIdPQ=;
	b=aHdKjmahGhpCFuM9yB6Ep0Qb7e5MsysSU5Z4HqZylA4bJd/hqbM1e+QmCDOWycpVzNiN
	 FFpKthffMc1urpXbXOBfe3JIhmVyP0g5ljvJA7nz2gU0lFfX1gDoJnwffhjlp0uGEx43/
	 QaZ24/5+clw+sF06ZRUAv7Dq+2jzaVA9mJvLi3FLLnY/Z+t1TevNYKBqmFXLZp3CogJUq
	 UIkS8BcC/jMgQjcYD4ox4QZCcKfrARFE/neB31UpCHl7kTaMVSWbVREwNp7pk5pW7bj1I
	 SOY3oqGbdwAZxJ/M4XrQUkR7kirAc3FcHp2MNphvD24Et0abRiCTLPrXJVSSzuc/WpA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=ohRWuzLs;
	arc=fail smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D293606A31F
	for <linux-pwm@vger.kernel.org>; Sun, 15 Nov 2026 22:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D293606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=ohRWuzLs
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-67db5e13b0cso340648d50.3
        for <linux-pwm@vger.kernel.org>; Sun, 15 Nov 2026 14:21:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794781264; cv=none;
        d=google.com; s=arc-20260327;
        b=mUMBL7J538vaO+fXCKYxTmUUVnIaNep10qAZg3AUje7wTWGMuQNOyQ6vJuQQhvCex0
         puf4o8NLjNSyJEjs6j79zEpbIXvD/+MC1i0DegMSBDOpWWFcTZRD6bs+Wt09tQEdrXRR
         bE4JTykWLREn9az5I4PCdQXtKFcGrThPyx5pJAzracdusqo+rlOdaD4ZG4fv4mWayXPX
         0BD7ZSOwy4ojOL1hiwfLcZ9Y5NpmbP7M5V8cfSVstvCO/+JEA4bBErB3Q15uTbo7/kca
         YShxNCxKD50Dsaqjx350cfxINCGagWPugycn90AyuCI7NiJW173nxjvrTx79EPpZhTed
         2q9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZAFY3cUder3qW+PINYFFGIewRXLP/J/NJFjtZaZIdPQ=;
        fh=EigPLqy0+XRFxHJeiysdZlT2xZnhyLawb0aWowrNVu8=;
        b=CIP8qh2AyozLjrii4GwJ1wAIO9h9C4cApO/TziowoC3bESv/oA3qgGwJPqOVAh/WEe
         RJdknm9KKecwPWrl6w9eTrHNA1zV5exF0/OXlGTamJ3BDiWRRHu0/KxuFVroC99Yb0iB
         0e6klGc+bTNJaap+IPHhLbJwFwk+oJVc8xVbgJv3nhllVf6qBFZxeriFdegT78dRTxre
         Bps2MWkZ07798D3ah/GY7FF2k6mfHdj4lL/JosgvHtHgWkGgDVWp4t8zz7k/c8WTAfea
         o7umyeAwoZnzySSkvw0SilSTeogFdVUpcqvc4Y6k53dgWfPoBpGDGN9+dnxMwz4LPWzJ
         9KPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1794781264; x=1795386064; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZAFY3cUder3qW+PINYFFGIewRXLP/J/NJFjtZaZIdPQ=;
        b=ohRWuzLskucdZexyQNJ+heplSWXTaJEIIm7suUD2DWYYOw3bnEfYiwHRYTQCmL/v3E
         xwwWqRiJ+eBb7u6IhQcghQVUllcYPsaVimvlgY2YtViPXRF14a83f8Bjd/3xDRDYBNhN
         TVIZ8Hr0BlNeaTbuAdwZpKqiPpAAhqBi1bLs/CvCjludvcbtIj9zZ1VdNoUt8W0SJJA3
         GBkVqjX6DJAHOT7fGd9fRQcmI+yShx/YpUiWjyImkVDlCzoW0hSM/eaJVZIrdq6T5ScQ
         wMrz5zB4WQX2HfdLQlBr9kqUa12qUbNMbA/VVh59+oT6rDVABxNJxxVOaQZXOMOmQ1h0
         HrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794781264; x=1795386064;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZAFY3cUder3qW+PINYFFGIewRXLP/J/NJFjtZaZIdPQ=;
        b=k7UKL7iwGs6wsPzgnlQKLai/eG4Xui5qnpuBQ37EFjtnX0qlBWpd3dkeEhtuQNMRlC
         IBDchbEA0gXGRFpZMsrCvvHNt1bGqva6AYH35MhlMpVh02v0ITcPteJwoR1XwwH6o8+X
         3v6ZlOq2uLIdDNsaT5MEiFuBRlS5GFYF+b1pCtb5s+SL8gjnETYzRw3Kmki5McQeWuPq
         sa2BjJu4ZCdJ+O43kGoi2IQJ7OVXBc/wjl+w0f+/gJUcHHsOH14GDC+foBay2o307vhZ
         0ulZoUPS5X02s7fsBAay8rf1ZHoVyH33K0CjWPP3p01yojuK4kqNqk9X0AVLkMTbOvC2
         FeAg==
X-Forwarded-Encrypted: i=1; AL+hErGq6fzvwezKWMvkZYwXiv4HR6rqQIlGkWqBuVnO9jaYQ612MkJOQM8z2A758BcD4H54qjodadkFzLE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8l4DOF4M0G3wy49xxGOWk8EhkNR5O29lHs35dvGubOw/CMObhm
	VOynnrS/lTfWM4RIPwS6bOwYeepL9X0QcT8V2+VfHixM/smRkvAVesLbNy7u5UcbrDSLB67fBuu
	FB56bZKEA9CIBWfpXj9gbzIZXsX4cjtGayjhX
X-Gm-Gg: AZFdTZcxMkS/YESuh6KRoHe1nsA53/PQ4KgeOBgFdEYoPLodvMvg9ZUoJCGn3bkMbWZ
	veZ+Sb0n+xBNn4qIt4wWORfTdWtSFNp9O0MHnZcyjHeJrApmIc0mzT12t2bDokOGKPpRdnyM58s
	Tf7yoT84LuZnFIm4Q+SRKtuFqig5Hlzvq2VeY+c2m00QA14qroYOBBMevY7HihFaOKHwh87g2An
	M+XMijPbO5PfS2dYm1pFGMZhCspMSNXJB5I/cN1PcqIBt+ts4P1XXv3kmjptgRaHDYZM910OazT
	FrhMjz0cAq8odxbOvJVB48iCucUMxuyHnNZ/bwnNg+P/umSLVZoIXQMVyRyzDy3EY8Zet4i2/Zq
	ZUJyDYWO1JMi6WbSJytCFkp5eVrDG/L5LRKaEQi1ILP+SUwFuEXUlZjCp9qUej14aNb8eO7LeYx
	1kqziNBDDXpmTIjFE=
X-Received: by 2002:a05:690e:4086:b0:67d:a3f0:7dac with SMTP id
 956f58d0204a3-67da3f0917amr1936855d50.14.1794781264626; Sun, 15 Nov 2026
 14:21:04 -0800 (PST)
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261001-add-t7-sys-pwm-clk-v4-0-8ed2b1e0cdfe@aliel.fr> <20261001-add-t7-sys-pwm-clk-v4-3-8ed2b1e0cdfe@aliel.fr>
In-Reply-To: <20261001-add-t7-sys-pwm-clk-v4-3-8ed2b1e0cdfe@aliel.fr>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 15 Nov 2026 23:20:53 +0100
X-Gm-Features: AclHuK-51aJAWSj3WTQV4S_5nCaT5gjYIQp2CQlsLrogi8Dpichyl4UfpyRzP20
Message-ID: <CAFBinCCf2x3Ear_iOg9=KYXd5jbvAh2LdQb3uOME=Lry8Wm4HA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] arm64: dts: amlogic: a1-c3-s4-t7: Add bus clock to
 PWM controller nodes
To: linux-kernel-dev@aliel.fr
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 6:56=E2=80=AFPM Ronald Claveau via B4 Relay
<devnull+linux-kernel-dev.aliel.fr@kernel.org> wrote:
>
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
>
> Describe the system clock of each PWM controller as a third clock,
> and add the clock-names property expected by the updated binding:
> "channel-a", "channel-b" and "bus".
>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>  arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi | 28 +++++++++++++++++++++--=
-----
>  arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 28 +++++++++++++++++++++--=
-----
>  arch/arm64/boot/dts/amlogic/meson-a1.dtsi   | 12 +++++++++---
>  arch/arm64/boot/dts/amlogic/meson-s4.dtsi   | 20 +++++++++++++++-----
note: a single patch per SoC is easier for me to review but we don't
have a strict rule.
