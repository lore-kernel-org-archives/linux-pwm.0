Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793647385;
	b=AVqXWjUA0wR43KJvPM6w/diUejalytBsFo58CCNPQdJZ2VVg2ZDiJPNyl7hmE6DO7Ffu
	 zzKzbVraX1in4hc8xGh+4/UlQCC7nQSEm8B2rMAzS9cmv7Sok3CFUlJx0B6sIkPd7vYyx
	 VWEvUZzOi4uH2dIGhePhJ05WxZz/S8DKzhVpkytX1dr0rXqkveR8Lbxr7Yx9CJDJMJgQj
	 mgAbxVx1FXO8p3Zcbw2Jc5XrjBw4lYcFd/AQb5EmjwuBaYRW7xT0dXeIWJ0niOzW1gUCg
	 B73j5eRrTzA938wkm+qBvBgOwKUtzjs24j2xtffvMpZsQTngGl4Ya08KZMY8hSuGeoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793647385;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=AEn5kOuJI8KKdvD9XcEieAYlhY01m/lTY2e281fbPUk=;
	b=P9+CEa4NriP+XsO8wkfH/1UIlFHp2uPec91zWL8V/7o5oBXUgseeFilEJDvbMJZendJY
	 Cae8jPFrMMLKjtSaWNN0KdDD4+MPo0BRfNxU8MVYJ7NHr0c3Vu90aR9rPmUzr3WS7AEr9
	 TTNoXrgZBCBhSNGepiCsom9WCXTt6zG4FR4GJz0lQX7b+d4Irv9ygxZSzxa+xRUyGHbXn
	 lby1+YQwIQYuf3X03geeBTB0qXx9LF5xbTS3HezZCcTRw0KL1/WWSZ9XXLnhyU7qTqSss
	 hCazceTFCuXaR/Q4/a1AA0D9INt6UDLheh8Wa/Lc9rD0Ef3mPlx83TvKDg4C9hdG39g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ltyQGKjL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19565606A326;
	Mon,  2 Nov 2026 19:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ltyQGKjL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D13D1F00A16;
	Mon,  2 Nov 2026 19:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793647384;
	bh=AEn5kOuJI8KKdvD9XcEieAYlhY01m/lTY2e281fbPUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ltyQGKjLitBfM0+NBf4Fy9LRsKlMC5f5A5WFTb2Yyc518zMy50CfuMZQfkXKFxB5v
	 t06dQg4OalfMa4ioajDnUQ/hqc6oTZ4wBegCYmN5dVJh5j77a7eJEfSiY4MYROgURp
	 318V/ce2T1OptEpwUSjfaXByL4jgsKDZ5MQn7IDiB5h3Q0EjFXd8AmSxs04pDmSc6L
	 jbrDSzE1rAnrOUXMkdhRRmoY7XIam2OheJ6MYHML9Gd9dabrjTW8cr0o6QjNbaYuaN
	 0SQAvaPFmSxR7d48L1M0hjIJ5dHYue9uSATh/Ocskhm1s5AwkJvEcvqxkbFP6K4mfJ
	 WsPp289gzkQdA==
Date: Mon, 2 Nov 2026 13:23:02 -0600
From: Rob Herring <robh@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Naushir Patuck <naush@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>, mbrugger@suse.com,
	Sean Young <sean@mess.org>, Julian Braha <julianbraha@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v12 1/2] dt-bindings: pwm: Add Raspberry Pi RP1 PWM
 controller
Message-ID: <20261102192302.GA882027-robh@kernel.org>
References: <cover.1790686331.git.andrea.porta@suse.com>
 <ee0aa89faa14e0073f1271693bae28678652998b.1790686331.git.andrea.porta@suse.com>
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
In-Reply-To: <ee0aa89faa14e0073f1271693bae28678652998b.1790686331.git.andrea.porta@suse.com>

On Tue, Sep 29, 2026 at 03:02:11PM +0200, Andrea della Porta wrote:
> From: Naushir Patuck <naush@raspberrypi.com>
> 
> Add the devicetree binding documentation for the PWM
> controller found in the Raspberry Pi RP1 chipset.
> 
> Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> Co-developed-by: Stanimir Varbanov <svarbanov@suse.de>
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  .../bindings/pwm/raspberrypi,rp1-pwm.yaml     | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml

Applied for v7.4 as the .dts user is already applied.

Rob
