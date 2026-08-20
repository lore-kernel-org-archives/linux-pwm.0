Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB97738736F
	for <linux-pwm@vger.kernel.org>; Thu, 20 Aug 2026 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787226485; cv=pass; b=Xs+Q+XdVNzZgHRKpsCCjrNFNsFE1qm86+q3ps2eT5h+4IzHdH2Dt2YikfLh8L+dbLeoqG0Ez1zsD/IDnFlfBfWHJerSQ/JcjmRbVHH3b2U9b7cNzEoQNov4JJzpXihFmqB+5WyJQCR8tKPYPAPLK1y1KRyQ3gSJbObu+z/tXVfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787226485; c=relaxed/simple;
	bh=N3XcxuvKeFv0jrHZq7jORW96HDTgTe/U58U3ymleexw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/prqrJg1YNlHNsG3zZ80YHriTsjQObcuZLqvfkbWTEb/kH3a9dOEfmfARogo5JIlpFfWdzRkxSrmU2mbZr6aO0IEE0SZjPqVcDPD3UKiEyRbIuIPR5rk4h7QY0dtGw7BT9tj3aqu7vUV8pWRe0l2tlGokwpDp6VqagIJcCgd7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h18HZxoa; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h18HZxoa"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c2055f5a993so226722766b.2
        for <linux-pwm@vger.kernel.org>; Thu, 20 Aug 2026 04:48:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787226482; cv=none;
        d=google.com; s=arc-20260327;
        b=saOnYZeFZdjYDJR/JoUNuORWwLOU5pTxVAWh9q9WA/QqBOf6DJy5i8yhPb7sTlxyFs
         Z2ZmIoiJOU7QU8NBH2VCzHRAeC3T8gcXU7UnGyrbPntvLlAUG2mT4mspKJJU2tOGgXcx
         029mM3iqRwZrEJRL8FaQ00LwGtbL+drdgOyzSRghNeFDbuswQT9Vo3DH04+ASx5/7UhG
         HnkQoqxD+hosHhvw3PdsPxELVyv+Y+KRM7QUO/hs+o9S3d5RfqjkWy9W+EF2czOJyeg6
         NYRKRgblYdpMjE2HEUkAuzTnucyCdSEfyjo+snvWe1wQoZ9Iea3ikXMDy7/jmLU35mKp
         f2Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=M4ykTKD26brTAJUSy1BqDUBmv6bxfPzSIe8lWvsCYHQ=;
        fh=Jc17HRWJc/g7AmF5jaqHvX2IM/ruIr5be9Mt8t+3ADg=;
        b=eCLB6O32UMcQU/GRUOsMVTvaaJOtEyV2UQuCGSFZ5HAUlnMGPu++Cn0cdFLcqbgmd6
         krXUTk1Mae5My3JL9bK1hPmRHrEwrWIr7V3picq7Llz5X9OjuDNHRAZ0ohBhScIYQ7hT
         Y7JcdAOELNtTIauYAJZof0bfPtHzcRQz9ib3xakUE8q18gqtMB1yUS+Lm3X16T5pjFgh
         Wn0/mgtbtuic4xnOsGo3YfqyG5hphlEtWWiesxffg9ljxI43oSvih8pleybaSzsYE80B
         OsrsXSzT2iAnYEoQ2gtEfeYRDkNebuJPDbdBdtIsJdizQXzpGYyE9xldTm5TzS/2NaHo
         dNPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787226482; x=1787831282; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M4ykTKD26brTAJUSy1BqDUBmv6bxfPzSIe8lWvsCYHQ=;
        b=h18HZxoabvn9m/ScdqEyw2LXvAVg3a8Ks6k+ikg3eexYdUFCrjL54D29ghc9LxQC69
         x9Ih6lttJ/t432qM1uJYNSoVDUi5ARvRmIYuJceIXLw6Vh6PzGybvqvjvr2KFqWwYwak
         J9s7mTgxn3cyEBGN8r+9ztQuC8DUpUagH4QZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787226482; x=1787831282;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M4ykTKD26brTAJUSy1BqDUBmv6bxfPzSIe8lWvsCYHQ=;
        b=sK1pFBjKRil2rXS02BadeioH9SjULXI+HNEX1d8IfifpHW3f+OWSMpdpjbwKY8rzqA
         zoQqh3CvyMPg9pRFrz5MUd+yRxiXL7LBMOAF0NQcp0XHu9LMZiYgBVlmU1DsihjDRl7b
         lnElGXOkx5p2i0LJUduh4ldioCpv+QbG6p92HopSrwFBLWB2hhCxuC5cnx+ml/VdZtNa
         mD6TdFpuS33H0WPC2Reusu01jLrEW6oUP32apOe4qk9JNQLnIHvwaI6NcRDTPOxtS7Zb
         PDRA6P7EtJoJJJf6JyEAesnADPdICEqTtUWPt86ASyCxetIXaerrBRB9P64dwOUG/j5+
         SH6A==
X-Forwarded-Encrypted: i=1; AHgh+RrEySox6PodphAUDVZnuHWSjdZdoj24wL+eGKX6CPrxkJiLc2ljZdDoqtBJS7UPGAmsSZu5piQGaE8=@vger.kernel.org
X-Gm-Message-State: AFuF++ltw0Wya8lJT6v35BtcPmgGESgUo1OcAzB5ekTYd82PHjo9fu23
	6qSOPiUPqEugPBsFveVrpPFV/O4T2IaH0SW6rKbMWj8HPA01W+DN2PNBlSfFWuL9TbDrhklj57z
	eDJK4+2JMWEu7ImPFKGaTknT4wSorz5KKI9DAekGO
X-Gm-Gg: AR+sD131dQBaNH9KDyFwc57ohU/TKLKyTegak04+Cv8NwCMJ125tofYfbtJ+Sw6wqpd
	3JNcFMI5asFrtefLHsmM8n2WSXzAnCaDXNwHeRdZB5wleCnuvPzfD2ZZAn7ZJ4P30gLinQvi+K+
	rQ9/JKrCkqM8k3Jqwz6KHLWCeUVbh/1WuYKoQ7hz2fQDXYpjJq+AQsH0fxuB0O6lgdJchlaxkpl
	RgCYNVpmwF30/IosU1AKEBtyXEaNkD1x5xgzp8Wa2W34Lb6QrGmLqX6LwdtyOHJsm9Vm3Ao5hjN
	+eNbp0qHXAH3kfVvpNDqDcXQT+zYCJMpze/B4rInsZQ=
X-Received: by 2002:a17:907:c08c:b0:c21:96e8:578d with SMTP id
 a640c23a62f3a-c242e22d1e9mr985944566b.15.1787226482262; Thu, 20 Aug 2026
 04:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810121121.210040-1-vlad@zlab.su>
In-Reply-To: <20260810121121.210040-1-vlad@zlab.su>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Aug 2026 05:47:49 -0600
X-Gm-Features: AcwNN1XeIHyrOI_JtbOBD7QmUWCfs6jOmGCxaoJ2CvViBz-nzt4BaJLUZj-8m5s
Message-ID: <CAFLszTiGPVD1UvGcdE64H1To3OWjOYTd9BNV+jHM0=_dEkMsDQ@mail.gmail.com>
Subject: Re: [PATCH 00/25] ARM: rockchip: Add peripheral support for RV1106
To: Vladislav Leonov <vlad@zlab.su>
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Aurelien Jarno <aurelien@aurel32.net>, Brian Masney <bmasney@redhat.com>, 
	Conor Dooley <conor+dt@kernel.org>, Daniel Golle <daniel@makrotopia.org>, 
	"David S. Miller" <davem@davemloft.net>, David Wu <david.wu@rock-chips.com>, 
	Eric Dumazet <edumazet@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heiko Stuebner <heiko@sntech.de>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Michael Turquette <mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Olivia Mackall <olivia@selenic.com>, 
	Paolo Abeni <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, linux-crypto@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vladislav,

On Mon, 10 Aug 2026 at 06:15, Vladislav Leonov <vlad@zlab.su> wrote:
>
> Basic support for the Rockchip RV1106/RV1103 SoCs currently under review.
> This series builds on top of that and enables the peripherals needed to
> bring up a board beyond a serial console:
>
>  - CRU reset controller support (dt-bindings + clk driver), needed
>    by most of the other peripherals below.
>  - Ethernet (GMAC) via dwmac-rk.
>  - USB2 PHY and USB3-OTG (DWC3).
>  - I2C (rk3x).
>  - DMA (PL330) + support DMA for the UART nodes.
>  - SPI, including a new SCLK_IN_SPI1 clock gate.
>  - RNG.
>  - SDMMC1.
>  - A dts-only quirk (arm,cpu-registers-not-fw-configured) needed on
>    the ARM timer node when booting without a secure firmware that
>    pre-configures the CPU timer registers.
>  - PWM.
>
> Each new dt-binding is added ahead of the driver and dts nodes that
> depend on it, so the series bisects cleanly.
>
> This series depends on:
>  - "Add support for the Rockchip RV1106 and RV1103" (v3)
>    https://lore.kernel.org/all/20260729133609.3465563-1-sjg@chromium.org
>
>  - "pinctrl: Add support for the Rockchip RV1106" (v3)
>    https://lore.kernel.org/all/20260729132736.3807082-1-sjg@chromium.org
>
> Testing: boot-tested on custom RV1106 board, with every peripheral
> touched by this series: reset/CRU, Ethernet, USB2 PHY/USB3 DWC3,
> I2C, DMA+UART, SPI, RNG, SDMMC1 and PWM - exercised and confirmed working.
>
>
> Vladislav Leonov (25):
>   dt-bindings: reset: Add RV1106 CRU reset definitions
>   clk: rockchip: Add reset controller support for RV1106
>   ARM: dts: rockchip: Add reset bindings to RV1106
>   dt-bindings: net: rockchip-dwmac: add RV1106 compatible
>   net: ethernet: stmicro: stmmac: dwmac-rk: Add RV1106 support
>   ARM: dts: rockchip: Add Ethernet GMAC node for RV1106
>   dt-bindings: phy: rockchip,inno-usb2phy: Add RV1106 compatible
>   phy: rockchip: inno-usb2: Add support for RV1106
>   dt-bindings: usb: rockchip,dwc3: add RV1106 SoC support
>   ARM: dts: rockchip: Add USB2 PHY and USB3-OTG (DWC3) nodes for RV1106
>   dt-bindings: i2c: rk3x: Add RV1106 compatible
>   ARM: dts: rockchip: Add I2C nodes for RV1106
>   ARM: dts: rockchip: Add DMAC node for RV1106
>   ARM: dts: rockchip: Add DMA support to UART nodes
>   dt-bindings: clock: rockchip: Add SCLK_IN_SPI1 for RV1106
>   clk: rockchip: Add SCLK_IN_SPI1 gate for RV1106
>   dt-bindings: spi: rockchip: Add RV1106 compatible
>   spi: rockchip: Add support for RV1106
>   ARM: dts: rockchip: Add SPI nodes for RV1106
>   dt-bindings: rng: rockchip: Add RV1106 compatible
>   ARM: dts: rockchip: Add RNG node for RV1106
>   ARM: dts: rockchip: Add SDMMC1 node for RV1106
>   ARM: dts: rockchip: add arm,cpu-registers-not-fw-configured to RV1106
>     timer node
>   dt-bindings: pwm: rockchip: Add RV1106 compatible
>   ARM: dts: rockchip: Add PWM nodes for RV1106
>
>  .../devicetree/bindings/i2c/i2c-rk3x.yaml     |   1 +
>  .../bindings/net/rockchip-dwmac.yaml          |   2 +
>  .../bindings/phy/rockchip,inno-usb2phy.yaml   |   9 +-
>  .../devicetree/bindings/pwm/pwm-rockchip.yaml |   8 +
>  .../bindings/rng/rockchip,rk3588-rng.yaml     |  11 +-
>  .../devicetree/bindings/spi/spi-rockchip.yaml |   5 +
>  .../bindings/usb/rockchip,dwc3.yaml           |  35 +-
>  arch/arm/boot/dts/rockchip/rv1106.dtsi        | 426 ++++++++++++++++++
>  drivers/clk/rockchip/Makefile                 |   2 +-
>  drivers/clk/rockchip/clk-rv1106.c             |   4 +
>  drivers/clk/rockchip/clk.h                    |   1 +
>  drivers/clk/rockchip/rst-rv1106.c             | 340 ++++++++++++++
>  .../net/ethernet/stmicro/stmmac/dwmac-rk.c    |  55 +++
>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c |  76 ++++
>  drivers/spi/spi-rockchip.c                    |   1 +
>  .../dt-bindings/clock/rockchip,rv1106-cru.h   |   2 +
>  .../dt-bindings/reset/rockchip,rv1106-cru.h   | 305 +++++++++++++
>  17 files changed, 1272 insertions(+), 11 deletions(-)
>  create mode 100644 drivers/clk/rockchip/rst-rv1106.c
>  create mode 100644 include/dt-bindings/reset/rockchip,rv1106-cru.h
>
> ---
> base-commit: ac414f5eda0814030636177593400acdacfe5e1e
> branch: rv1106
>
> --
> 2.47.3
>

Just to note that I applied this series and tried it on my Luckfox
Pico Mini B (also RV1103 but more basic) and it boots fine. I enabled
the RNG node and the driver seems to work (i.e. the CRU is good).

For the series:
Tested-by: Simon Glass <sjg@chromium.org>  # Luckfox Pico Mini B (RV1103)

Regards,
Simon
