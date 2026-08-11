Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3F843E073;
	Tue, 11 Aug 2026 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456410; cv=none; b=UxEx1AbNjpWrYjXxF95LJO6eLlUHkKd4JpNxVWVJmOyoUsdSSDC0rqS0rtPsNLJ9Vq5BygTEtMwU+CpPY8ML/esbD7Z7ohLbWCEADXf4CfrYIXmcIPH91pG0aNfuBY0wuNkomnrTGzCGAY1IIUNKrlKUP5q0Xc+R+75zD5rEljU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456410; c=relaxed/simple;
	bh=Aag11kzP6OoZz2CrvTPwTWGO5OWYsZlR/JtjlWsGX/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4MBSePL6vMWS8eWWBQPdaH9DqYTG8BTL9i0tr6mEQWJ59ftddv58gmMY31KMqdh0VESWaAF8+psgsFG/erbVgo6lzR4utppJF0E6xvghz0Z5v8BK+0KHMkln5kb5qN5wwBQW4EhSnRIQEDna68T63j5PpJCQ7qapvLHTyscib4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8WocTfH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8WocTfH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB351F000E9;
	Tue, 11 Aug 2026 13:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786456402;
	bh=zOISgtHJcoVhgbuQw7i0w6TcTYQ6uT3lh6JpZDeNOrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X8WocTfHhpLtdAwDoaaQDw/vdNWROCYyO3plt/WqxSeP3Wo6K3OvPtwIsjIXu0ca2
	 QNvX3PqF2wNK+1PDfdhf4dGEtpNaiBB5fyglxRi1EJOIfrYSFfNGXvI3fNqFKlaD4q
	 roE2kLEz5AWLENwxlSVzftQXQ7wpXTxUIuLqXZN4m68iGh/JB2aDpBvoRc8f3mVFit
	 /wKatjrvVPjtTRTv8xXvwx0AgMW3rYRyPk+oLZnXCAkro15h3f3pviKeE60rDzBHXv
	 O+7aIFFUoKnHs3QnI/bqvQqQlRrsKCd8cHs5Su6oGkMVwgd4/Z2O4bdqKdPUWVf8TB
	 1f3JxiYEoGBUw==
Date: Tue, 11 Aug 2026 08:53:21 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: linux-pwm@vger.kernel.org, Hector Martin <marcan@marcan.st>,
	asahi@lists.linux.dev, Mark Kettenis <kettenis@openbsd.org>,
	Radu Rendec <radu@rendec.net>, Sven Peter <sven@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Janne Grunau <j@jannau.net>,
	Linus Walleij <linusw@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Neal Gompa <neal@gompa.dev>, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-i2c@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Sasha Finkelstein <k@chaosmail.tech>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 5/9] dt-bindings: pinctrl: apple,pinctrl: Add t8132
 compatible
Message-ID: <178645640149.2074555.4681413696186496761.robh@kernel.org>
References: <20260801-apple-m4-initial-devicetrees-v2-0-5cb07cc275da@cyberchaos.dev>
 <20260801-apple-m4-initial-devicetrees-v2-5-5cb07cc275da@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801-apple-m4-initial-devicetrees-v2-5-5cb07cc275da@cyberchaos.dev>


On Sat, 01 Aug 2026 23:40:35 +0200, Yureka Lilian wrote:
> The pin controller on the Apple silicon t8132 (M4) SoC is compatible
> with t8103. Add "apple,t8132-pinctrl" as SoC specific compatible under
> "apple,t8103-pinctrl".
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> 
> ---
> This should be pulled via the pinctrl subtree, since it depends on
> "dt-bindings: pinctrl: apple,pinctrl: Add t6030 and t6031 compatibles"[1]
> which has been applied in the pinctrl tree. Thanks!
> 
> Link: https://lore.kernel.org/all/20260709-apple-t603x-initial-devices-v1-7-55b305833123@jannau.net/ [1]
> ---
>  Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

