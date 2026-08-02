Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C890E3B42E1;
	Sun,  2 Aug 2026 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785678900; cv=none; b=XB6ayHlCC7Qw7SOCotKZwB5zpJKIgjVp622RG426fktzOB0dzuc36FJzUwm7VvJzhV86oSWjl6TKt9qYZyxmx6Up+4zhgXMej1nIC0qPxjtIyU+FlTMZsJHOGX5VHUZrc3epugmysGPW6UPo33+NZ89UgYzlSpVyyhFoP+gM/lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785678900; c=relaxed/simple;
	bh=VOcJjiss4niXEUvQDfQflafcnB6M0cWpgiPL7XqFakk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWz/qjPO7QdS+ao/ejH4Hlcz4Bz4coZqWbrQxAFsZGDzcisXAeYFeskP9RtdECmru4YKhpcRE2nV56ItUK4nRDRLwC4FN1Bd0Zp9vLtCDIc8b1cl10uPH2PpkjE8+DDqzWf5lIoDwfuTA+n/m80RkAjYEff0wBPSE0YR4TtQYDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=DplQdUY4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XmXujbLf; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="DplQdUY4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XmXujbLf"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 452731300080;
	Sun,  2 Aug 2026 09:54:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 02 Aug 2026 09:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785678895; x=1785686095; bh=wr9KcQd5UO
	YPcDKO9OAtdsNMsJA9M3uNYC31Vb57iYw=; b=DplQdUY4k5pHQXGjL444hzwd6x
	Uq8dSWgKlS+OHbGSPASMrkkGChOSifHzzrcROinwlM/LbRiWRYwRepZ6NzEcq62J
	1kHQB8c+GkHsi8Xy5ozdjGTV0UT0VfrO/ZCcAJib89mL/KBFed3s24XJXa0y4XR9
	DmG07CgkJacT0R78Bx7D1e+PztPQNCrh105GK2Hel+sJVor6HeDuhC5/7cpoV6xQ
	YjNshJiU/Krc1H5FAlRgLVfjqKGUUyYNT0cH1WmnIhiPUbpRAix/RkmQXRlkVgbM
	acWu0zj9m3upJo6c++8sRnxmrgq5sK85QGKvzAIwtjybopnlu+AehCjw6D/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785678895; x=1785686095; bh=wr9KcQd5UOYPcDKO9OAtdsNMsJA9M3uNYC3
	1Vb57iYw=; b=XmXujbLftAvTzmIRsm3mJklvTHKNeuEFC/RkixKrfD0Mtz+K0QW
	CD+BrUdFEAD4GJLRGUY49krlo/4WFwreAYfzd1zd1jSIbtSciI8kGuFZaceRc7Vq
	Y7PRwikXC54QM3rLe6gMWLoYRglvL4ZRr6A9VOVKVHHvdoknMKisqi57ki0UBcCD
	pvxjVsXivQxijNKu/pxj8f87L++4SmL8+MWJ0WH9QeS5HEr2c81sKgpbnzrDaZwr
	tHKM4H159b94yLV8tQvs8KSWfraamvoV4njSnahvQMZGI0AU7fv5/OcqhV2/NQUd
	NbZ83SIH8TXlD3UwxfXv2cRw8IK6W6jyO3A==
X-ME-Sender: <xms:LkxvauCaoemi6ekbEL9n1F5lQzcO8jBhOXr2q22E3cdSKkDBc7sdiw>
    <xme:LkxvakHYhXc-hWPSL2n9ehREvUyQMNYpvZFqUp57Koi0HCHbm9AXAlBznGHY43fYy
    wtCSx1OlpFrZP5KmeYuogTxS-a6R57xJf5_41EDPpxNuQ4SqBl-f-eg>
X-ME-Received: <xmr:LkxvahkWLqzXMhat6N7CPn46vxNua51boNrAuicmbkwZty6wGHJpTGIjE6L5vRXbV6EZ6rGww3WMNVYpl201s2WGZivyDdDTvs8>
X-ME-Proxy-Cause: dmFkZTFlapO+z6cp3wvBebk5lTAia5phm9tTAKSNHefTMzPdePd5v+T7JVgHEkLB41y5Ob
    eSvN7viLYvrIAaqw29v6S68ef3GuIe/2QfmzPl60v9SPYjt+CGGoHIW4icP01WLKDzOc6C
    MiBlzN9g5EQDae7iZTKYWr2YlkWF31TgHFKA+LB0yLkroETBvzCa+CA0RRC4tNufFsVOkV
    rBdO8gOdXsYuegeK25nP42KabMus7xNwyQdViuVL8OaIh7kc5VQHPyc0zfTyon2d0FkYKU
    iKGSoWac7r1ZoY7PQNed9fLAr9J3ro1NKAbgYiWXJJ8jWVM7YjMG9Y3saYGTypBJmAoANg
    6oyVuzBsRLxCsCECJx6mzrLQKjXPPDHic5NrLn4ffrLwK0LVVeX1gZ0Xk2S6fP1r9ng8rS
    JictUazSi5ecwImXJh9ByzRm9cRSeuTXsMNeYC6L+UY13nPaxF/yi0rzjqeQDNB0/kfdwQ
    7KinW3spMgGWUzGBKXz+yv830VxsxGCoeMjdqciLz8LbA1UDF/b68vIYDiGFV4WePjXVRy
    Ljjjyl0eJI4aDHemiD5CRG+9GLw327mg51Vd9A4CxF++M/+65FvYbANoIyQ+nubqAvFiuR
    ZfkRufrt8jndKpUKNswRdOgYbLvXM/0Sva+kw0GvSxAUnmTFekcIuPPkf3+A
X-ME-Proxy: <xmx:LkxvahvS1sbdmvnJZ79bvRMoB4wNkKEXllAdwxfgsQmg_zYiyk3EMQ>
    <xmx:LkxvalPISx2OLXNqtyUDD7RWX9DKGenGyH6nXZGyL_U3bWBDAYDzoQ>
    <xmx:LkxvajqtZUL0UFkgWV4d3V9XSJ_CEH_wJ0DXe--DGmcfvHAzCkXYtA>
    <xmx:Lkxvau82rTgkUyaBlOMluJnPrylfJgR9EPqvuTQkmdXVMpX1Vqqqlg>
    <xmx:L0xval7YbN51x2-d2X3fl9RZ4c2iEFgHkPjz_Oa7-MvVDSfgkqY73WVC>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Aug 2026 09:54:53 -0400 (EDT)
Date: Sun, 2 Aug 2026 15:54:52 +0200
From: Janne Grunau <j@jannau.net>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Hector Martin <marcan@marcan.st>, Linus Walleij <linusw@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Sasha Finkelstein <k@chaosmail.tech>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 9/9] arm64: dts: apple: Add minimal t8132 (M4) device
 trees
Message-ID: <20260802135452.GJ806854@robin.jannau.net>
References: <20260801-apple-m4-initial-devicetrees-v2-0-5cb07cc275da@cyberchaos.dev>
 <20260801-apple-m4-initial-devicetrees-v2-9-5cb07cc275da@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260801-apple-m4-initial-devicetrees-v2-9-5cb07cc275da@cyberchaos.dev>

On Sat, Aug 01, 2026 at 11:40:39PM +0200, Yureka Lilian wrote:
> Added device trees for the following devices:
> - apple,j604 - MacBook Pro (14-inch, M4, 2024)
> - apple,j623 - iMac (24-inch, 2x USB-C, M4, 2024)
> - apple,j624 - iMac (24-inch, 4x USB-C, M4, 2024)
> - apple,j713 - MacBook Air (13-inch, M4, 2025)
> - apple,j715 - MacBook Air (15-inch, M4, 2025)
> - apple,j773g - Mac mini (M4, 2024)
> 
> The device trees have a minimal set of devices limited to CPU cores,
> interrupt controller, power states, watchdog, serial, pin controller,
> i2c and framebuffer.
> The device trees for the notebooks add a PWM controller for the keyboard
> LED illumination.
> 
> Using the macOS 26.6 iBoot/firmware, the Mac mini reliably boots on a
> single core using the stock kernel.
> Booting with smp requires avoiding the wfi and wfit instructions
> in the idle loop and `delay()` respectively, since those instructions
> cause a loss of architectural state on the secondary cores, and even
> then boot is unreliable.
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  arch/arm64/boot/dts/apple/Makefile        |    6 +
>  arch/arm64/boot/dts/apple/t8132-j604.dts  |   35 +
>  arch/arm64/boot/dts/apple/t8132-j623.dts  |   18 +
>  arch/arm64/boot/dts/apple/t8132-j624.dts  |   18 +
>  arch/arm64/boot/dts/apple/t8132-j713.dts  |   35 +
>  arch/arm64/boot/dts/apple/t8132-j715.dts  |   35 +
>  arch/arm64/boot/dts/apple/t8132-j773g.dts |   25 +
>  arch/arm64/boot/dts/apple/t8132-jxxx.dtsi |   48 ++
>  arch/arm64/boot/dts/apple/t8132-pmgr.dtsi | 1130 +++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/apple/t8132.dtsi      |  447 ++++++++++++
>  10 files changed, 1797 insertions(+)

...

> diff --git a/arch/arm64/boot/dts/apple/t8132.dtsi b/arch/arm64/boot/dts/apple/t8132.dtsi
> new file mode 100644
> index 000000000000..6df6ccdda90e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/t8132.dtsi
> @@ -0,0 +1,447 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Apple T8132 "M4" SoC
> + *
> + * Copyright The Asahi Linux Contributors
> + */
> +
> +#include <dt-bindings/interrupt-controller/apple-aic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/pinctrl/apple.h>
> +
> +/ {
> +	compatible = "apple,t8132", "apple,arm-platform";
> +
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpu_e0>;
> +				};
> +				core1 {
> +					cpu = <&cpu_e1>;
> +				};
> +				core2 {
> +					cpu = <&cpu_e2>;
> +				};
> +				core3 {
> +					cpu = <&cpu_e3>;
> +				};
> +				core4 {
> +					cpu = <&cpu_e4>;
> +				};
> +				core5 {
> +					cpu = <&cpu_e5>;
> +				};
> +			};
> +
> +			cluster1 {
> +				core0 {
> +					cpu = <&cpu_p0>;
> +				};
> +				core1 {
> +					cpu = <&cpu_p1>;
> +				};
> +				core2 {
> +					cpu = <&cpu_p2>;
> +				};
> +				core3 {
> +					cpu = <&cpu_p3>;
> +				};
> +			};
> +		};
> +
> +		cpu_e0: cpu@0 {
> +			compatible = "apple,donan-e";
> +			device_type = "cpu";
> +			reg = <0x0 0x0>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0 0>;
> +			next-level-cache = <&l2_cache_0>;

missing "i-cache-size" and "d-cache-size". As far as I'm aware they
remain unchanged. 128kB i-cache, 64kB d-cache for the e-cores and 192kB
i-cache, 128kB d-cache for the p-cores

...

> +		pmgr_mini: power-management@388280000 {
> +			compatible = "apple,t8132-pmgr", "apple,t8103-pmgr", "syscon", "simple-mfd";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0x3 0x88280000 0 0x4000>;
> +			/* child nodes are added in t8132-pmgr.dtsi */
> +		};
> +
> +		wdt: watchdog@3882b0000 {
> +			compatible = "apple,t8132-wdt", "apple,t8103-wdt";
> +			reg = <0x3 0x882b0000 0x0 0x4000>;
> +			clocks = <&clkref>;
> +			interrupt-parent = <&aic>;
> +			interrupts = <AIC_IRQ 507 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		pinctrl_nub: pinctrl@3881f0000 {

out of order node, it belongs before pmgr_mini in unit-address order

Janne
