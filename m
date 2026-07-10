Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05EF3E5598
	for <linux-pwm@vger.kernel.org>; Fri, 10 Jul 2026 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783670595; cv=none; b=hYLu7kSsetSb4j2cqTOOmT4gWp96baSnBLlMT8IO+nh6D01Nw4xmyNTBOv1piQ14m4jvKeBHm0DFd6soq4EEdAtCEiH3vUB7mhnp6j4oKobZ8vgJ0uDBmeoeITlT0VCAD3ofdLl8rudbGfqcXN6g9Kivyrz11G1iHkBl/MLfzvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783670595; c=relaxed/simple;
	bh=DWdfXN3BNh6HNT+0goMzdBpTUvzgP37bXlBu5ybAYas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqW/bLxdBxKut3eWI09otM+UN3OncsyA8EBJo3d4UwVONLDVXUKiJMa/nRgWWsolqXXCwyyJaZcxjtjSdE1NNOrZFS1HGo1vzh4q+6MqKq5sXhtGO+S9bEI6a1tu6QmFIovLsb/OgTWurx9Qm8lVo9jlb3BbHqQle6Ui1KQUYBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=hBSue8RO; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="hBSue8RO"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493c2c0b9a8so5191965e9.1
        for <linux-pwm@vger.kernel.org>; Fri, 10 Jul 2026 01:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783670591; x=1784275391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DWdfXN3BNh6HNT+0goMzdBpTUvzgP37bXlBu5ybAYas=;
        b=hBSue8ROIw7Gts7ojKMbAJZV1GhRInRJKhlm/PmDOUUVfTWDAud3Fsc9M4HQRrOcmZ
         qeR8JnINbed6yaV53MqYGj+D3tYH4zpMV9Qfpuvx/K9VPWIRsHvKaZCAzFAVmDpXNh3+
         kO1RWYrnGkxwHjJlhbfqfLPuJbUfyMgNd0v8kaUlFmbNkQkNdgXbUctHrCXp6FIr/PGQ
         Yj3/fGD+Ag/FRt1rQogk3xDag7xXmXsd7gMIDVcxikb9yLfAHjNSQyhXztobWPT2ATKo
         jpop/3W+OT2AZePNRa0w29lQU8T4pq7z6ztGrkm/pkYBXmruPKGK58RXj70vAWc9Zzyx
         vCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783670591; x=1784275391;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DWdfXN3BNh6HNT+0goMzdBpTUvzgP37bXlBu5ybAYas=;
        b=N6q4e0rLTMcozixxldLzyu8NYDcNPKgDHQKxC3OYFRGPeejT287qGrzugohoGw9DeF
         6TlqjT1ns0c+s8Bad6soF+MpaDLz/JU5pxK+xFncLSyxS7GNYoH9tzk1EwlB5W+VB0lR
         lJiQ4pcorefoNPbz0nBukCf7AkbCE7PI5VEJkZ0NcjcukrkWWBquWLjQkNRSw8gDYrIB
         vzoX59WwUB3d9hvoyAz2encbKmTSlzujclRdghCl6PtenS0Og8yhtGaX7pAdz49RNNfy
         23ZE3vA95wcU2BWVMNhRO7goifdaeXRRt8asNilxPF/RcKfwm6Z+i1+mw8Yd/7PeTC3B
         22xQ==
X-Gm-Message-State: AOJu0YyOfccFNBsIxPWXSsZ0dqKXIj4f2wLpoYITAcb360Nc9JvGoRL9
	OD3q6uWEtNqS05xwmH7zmY/zB8wlHEdpmM5cyl74Z7w7UkWCvcDJ6fNUtZG61ilr1FN7V3Ym5Dr
	kPlegLy0=
X-Gm-Gg: AfdE7ckUXH6mVkEXWvb8A9LrRIwvIi1Q6NLM02wrP/vZ4OJwj9ew0bPGQOrN2bGwW25
	OcU1cAlLMYPgVPNhq+VjE5WhI2SJQlouuwNOEttuT0wrqdI++I3sv9hWDP0m451IctcRtrV7UFs
	SUO0WLycTzjQTBgRcuz8htJzdjUfePELnJ1EfQ+cH/UkDfJl7hLlL6+eOTeqvw1JAtLtC3JRN5B
	gKrDCsXdYxGUMYYejs4Gujn3z5p3bhxNHdFLMvT0oET1ZLNeEPnvUGenN1oi012xTSMJOzVPlTu
	d7fZVZN/bqJqFcv1Z+ODTSn6Dgcu1W/u4TAWoRcjJVHC27wVMJJ9GsFfnMtzvSkYdRrjFbZOzqe
	ghsj2c2F8o13UQTSeesjkAsUjGrSXV36rhNMI3Ous9et0jPAY/bzUTPtIcSiQrzLFCg56lwwYVA
	Z1iJG7aK0dZmiWnNpH3/U551asseGwlYpcD0Ze4R40s32cEkieU7pPBJRRY9M9ixgR2VzVAiIp/
	jnh
X-Received: by 2002:a05:600c:e557:20b0:493:c0ec:9a5f with SMTP id 5b1f17b1804b1-493e68ddd9bmr75755495e9.19.1783670590951;
        Fri, 10 Jul 2026 01:03:10 -0700 (PDT)
Received: from localhost (p200300f65f47db04fbea22a44ee9ba38.dip0.t-ipconnect.de. [2003:f6:5f47:db04:fbea:22a4:4ee9:ba38])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47a9e4d6e4csm55102028f8f.10.2026.07.10.01.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 01:03:10 -0700 (PDT)
Date: Fri, 10 Jul 2026 10:03:09 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>, 
	Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Paul Cercueil <paul@crapouillou.net>, 
	Vladimir Zapolskiy <vz@mleia.com>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Heiko Stuebner <heiko@sntech.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Paul Walmsley <pjw@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>, Michael Walle <mwalle@kernel.org>, 
	Chen Wang <chen.wang@linux.dev>, Inochi Amaoto <inochiama@gmail.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Hammer Hsieh <hammerh0314@gmail.com>, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, 
	Alexey Charkov <alchark@gmail.com>, Sean Anderson <sean.anderson@linux.dev>, 
	Michal Simek <michal.simek@amd.com>, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-rpi-kernel@lists.infradead.org, chrome-platform@lists.linux.dev, imx@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, sophgo@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v1 0/5] pwm: Unify arrays of various *_device_id
Message-ID: <alCm-J1wRBnhoH0C@monoceros>
References: <cover.1783263835.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iuf5svn2mmf3pdwc"
Content-Disposition: inline
In-Reply-To: <cover.1783263835.git.ukleinek@kernel.org>


--iuf5svn2mmf3pdwc
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 0/5] pwm: Unify arrays of various *_device_id
MIME-Version: 1.0

Hello,

On Sun, Jul 05, 2026 at 05:14:12PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> this series is part of a preparation for changing .driver_data (and
> similarily named members) of *_device_id to an anonymous union.
> See e.g.
> https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre=
=2Ecom/
> for the idea behind it. I also grabbed the opportunity to unify the
> coding style for all these arrays while going through these.
>=20
> The patch series is based on pwm/for-next + "pwm: pxa: Depend on OF and
> simplify accordingly" [1].

Applied the series with s/iff/if (and only if)/ in the of_device_id
style patch.

Best regards
Uwe

--iuf5svn2mmf3pdwc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpQpzoACgkQj4D7WH0S
/k4qdwgAk8w911oLsA5aqycP2AV5trJAC5zx53mJ8LxbKoImqWjYyvmd9Kb5YCt2
LPeZPEPqg6LIhPMbDp91hBWArDL5UUUJ5OfgC8/i0zK1+zWS0B+UPtXUGxzQOkwk
stkrTAN5eVW7rhVy1AtT4N+EJVm4Y8958RVsmNi75/idP+gmhs7RdJg8zMdhrVVy
M7XB5Q1zxVcmhsx5TDStZ8tzeFMsDbMqz0s0xVECWSq50U70IwD0Scn0a1BN68kQ
+fZQMwGT3KhdqqmLJV44puWQoDqj8OwGeAuWJQykzluefOFNtRHtRhurlZQAUOrv
W4X++IXkqXbyyTO72ousttS/RpH5ig==
=4YUW
-----END PGP SIGNATURE-----

--iuf5svn2mmf3pdwc--
