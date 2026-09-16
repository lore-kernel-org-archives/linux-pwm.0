Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920213CA487
	for <linux-pwm@vger.kernel.org>; Wed, 16 Sep 2026 17:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789581118; cv=none; b=hX8YzTC2A2DLZhSc8LSxpLwe8uyFqopMmVgP7ALYKBiC5OzkrNBTLU1NySjgZSMqeCKsT3hLoRIXnawoXAveWcclGIlaE/YbM4M5wyABXTANNujLwXoZdoZkyOHLCQpTKmnyjplqgSzzwyZq5ne0kAJE4fqy0CP9uBQfGbwYeB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789581118; c=relaxed/simple;
	bh=I7wDohvBZdnXx6xXZ7WJvhj/+kiuJqGF6WWIHYpgWW4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZYeD4Le9t4myCkes3bvaC6/RGmmf0IXtYXTH2KaopWevCKu+ju3GiYnJ6LZbei1E2qSIgDLeDEhzWsVS6s7o3ECl3dAdUHy+SaSGwf/hbxi4D6uognl6i0qAF9Yzk6g+hkD1SZqOWMqXS0gz6WtJ5qHNOwF6pmZh5wQXCcn1P3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qvH+AEcx; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qvH+AEcx"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D85BAC5CD5B;
	Wed, 16 Sep 2026 17:52:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BDF8F60337;
	Wed, 16 Sep 2026 17:51:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3629911C7B00D;
	Wed, 16 Sep 2026 19:51:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789581092; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rrcIrHoexzNE6VIZRTy50WMD/H8ZLMR7yjePfDT4zUA=;
	b=qvH+AEcxE2wFlijtl0M4qtIwajKDu8s+aJtukStGXs6eT68yHNT2tnmfY8MBq6dsdbFEHq
	0LXg8CN9jjace6Wwt+sucyaHsWlA5MadRtaDTwjFQAJQBIkxxw2ePNzLqyU3w8K2QVY+BK
	CdpQDlBZ9NpDlrIE5/Mi50mfdMCtwVGeifL71jfEBaiJ6HiQCT6PaIZFaHuaJ22kHtK8zU
	dauTf8XFYmtNx9GaBcD7OYItFw9tCiI7YybFEJKqZvD24i+/FMs7DaJIi14cg98L82DNYb
	GMR9EYXL5TfBk0Q4QKnpkP0JNTFeJI3ArrCEq7kVnVVuCw2k1Mi8JvDULcPx/g==
Date: Wed, 16 Sep 2026 19:51:29 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>, Frank Li
 <Frank.li@oss.nxp.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Linus Walleij
 <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Leonardo Costa <leonardo.costa@toradex.com>, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Ernest Van Hoecke
 <ernest.vanhoecke@toradex.com>
Subject: Re: [PATCH v2 3/7] of: unittest: Test fw_devlink with GPIO nexus
 maps
Message-ID: <20260916195129.6f9e50df@bootlin.com>
In-Reply-To: <20260910-fw-devlink-nexus-ready-v2-3-17ac82dbe226@toradex.com>
References: <20260910-fw-devlink-nexus-ready-v2-0-17ac82dbe226@toradex.com>
	<20260910-fw-devlink-nexus-ready-v2-3-17ac82dbe226@toradex.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Ernest,

On Thu, 10 Sep 2026 16:16:44 +0200
Ernest Van Hoecke <ernestvanhoecke@gmail.com> wrote:

> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> 
> Add OF unit tests that call the fw_devlink add_links operation for GPIOs
> routed through nexus maps. Verify that each mapped consumer has exactly
> one link to the final GPIO provider rather than to the nexus.
> 
> Also cover direct references and all GPIO property spellings recognized
> by fw_devlink, including the deprecated singular and unprefixed forms.
> 
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> ---
>  drivers/of/unittest-data/tests-phandle.dtsi | 33 +++++++++++++
>  drivers/of/unittest.c                       | 75 +++++++++++++++++++++++++++++
>  2 files changed, 108 insertions(+)
> 
> diff --git a/drivers/of/unittest-data/tests-phandle.dtsi b/drivers/of/unittest-data/tests-phandle.dtsi
> index 554a996b2ef1..c3727ed15bde 100644
> --- a/drivers/of/unittest-data/tests-phandle.dtsi
> +++ b/drivers/of/unittest-data/tests-phandle.dtsi
> @@ -79,6 +79,39 @@ consumer-b {
>  				phandle-list-bad-args = <&provider2 1 0>,
>  							<&provider4 0>;
>  			};
> +
> +			fw-devlink-tests {
> +				gpio_provider: gpio-controller {
> +					#gpio-cells = <2>;
> +				};
> +
> +				fwdevlink_nexus: nexus {
> +					#gpio-cells = <2>;
> +					gpio-map = <0 0 &gpio_provider 1 0>;

I would add more than one item with values other than 0 in this gpio-map to be
sure that the translation done at the Nexus node really uses the correct item.

> +					gpio-map-mask = <0xffffffff 0>;
> +					gpio-map-pass-thru = <0 0xffffffff>;
> +				};
> +
> +				gpio-compat-consumer {
> +					gpios = <&fwdevlink_nexus 0 0>;

And so, I would use a value other than 0 when a consumer references the Nexus
node.

> +				};
> +


Best regards,
Hervé
